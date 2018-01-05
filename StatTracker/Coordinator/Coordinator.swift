//
//  Coordinator.swift
//  Builder
//
//  Created by Akshay Bharath on 12/14/17.
//  Copyright © 2017 Animoto. All rights reserved.
//

import AnimotoKit
import RxCocoa
import RxSwift

class Coordinator: CoordinatorDelegate {
    
    private var window: UIWindow?
    private var currentController: BaseController?
    private var currentNavigationController: BaseNavigationController?
    
    // Used to set 'popability'
    private(set) var canBePopped = Variable(false)
    
    required init(window: UIWindow) {
        self.window = window
    }
    
    required init(navigationController: BaseNavigationController) {
        currentNavigationController = navigationController
    }
    
    required init(controller: BaseController) {
        currentController = controller
    }
    
    @discardableResult
    func transition(to scene: Scene, type: SceneTransitionType) -> Completable {
        return transition(to: scene, type: type, modalTransitionStyle: nil, modalPresentationStyle: nil)
    }
    
    @discardableResult
    func transition(to scene: Scene, modalTransitionStyle: UIModalTransitionStyle?) -> Completable {
        return transition(to: scene, type: .modal, modalTransitionStyle: modalTransitionStyle, modalPresentationStyle: nil)
    }
    
    @discardableResult
    func transition(to scene: Scene, modalPresentationStyle: UIModalPresentationStyle?) -> Completable {
        return transition(to: scene, type: .modal, modalTransitionStyle: nil, modalPresentationStyle: modalPresentationStyle)
    }
    
    @discardableResult
    func pop(animated: Bool) -> Completable {
        let subject = PublishSubject<Void>()
        
        if let currentC = currentController, let presenter = currentC.presentingController {
            // Dismiss controller
            currentC.dismissController(animated: animated) { [weak self] in
                guard let strongSelf = self else {
                    return
                }
                
                // Set current controller
                strongSelf.currentController = Coordinator.actualController(for: presenter)
                if let controller = strongSelf.currentController {
                    ANLog.debug("Current Controller set to \(controller)")
                }
                subject.onCompleted()
                
                // Check and set 'popability'
                if let currC = strongSelf.currentController, currC.presentingController != nil {
                    strongSelf.canBePopped.value = true
                } else {
                    strongSelf.canBePopped.value = false
                }
            }
            
        } else if let currentC = currentController, let navigationController = currentNavigationController {
            // navigate up the stack
            if let uiNavi = navigationController as? UINavigationController {
                // one-off subscription to be notified when pop complete
                _ = uiNavi.rx.delegate
                    .sentMessage(#selector(UINavigationControllerDelegate.navigationController(_:didShow:animated:)))
                    .map { _ in }
                    .bind(to: subject)
            } else {
                subject.onCompleted()
            }
            
            guard navigationController.popController(animated: animated) != nil else {
                fatalError("Can't navigate back from \(currentC)")
            }
            
            guard let lastVC = navigationController.controllers.last else {
                fatalError("There is no last Controller in NavigationController")
            }
            
            // Set current controller
            currentController = Coordinator.actualController(for: lastVC)
            if let controller = currentController {
                ANLog.debug("Current Controller set to \(controller)")
            }
            
            // Check and set 'popability'
            if navigationController.childControllers.count > 1 {
                canBePopped.value = true
            } else {
                canBePopped.value = false
            }
            
        } else if let currentC = currentController {
            fatalError("Not a modal, no NavigationController: can't navigate back from \(currentC)")
        }
        
        return subject.asObservable().take(1).ignoreElements()  // Take at most one emitted element, but don't forward it
    }
}

private extension Coordinator {
    static func actualController(for controller: BaseController?) -> BaseController? {
        if let navigationController = controller as? UINavigationController,
            let firstVC = navigationController.viewControllers.first {
            return firstVC
        } else {
            return controller
        }
    }
    
    @discardableResult
    func transition(to scene: Scene, type: SceneTransitionType, modalTransitionStyle: UIModalTransitionStyle?, modalPresentationStyle: UIModalPresentationStyle?) -> Completable {
        let subject = PublishSubject<Void>()
        let controller = scene.controller()
        
        switch type {
        case .root:
            // Make sure we have a navi controller
            guard let window = window else {
                fatalError("No UIWindow object was created")
            }
            
            // Create and set rootViewController
            // swiftlint:disable:next force_cast
            currentNavigationController = UINavigationController(rootViewController: controller as! UIViewController)
            
            // swiftlint:disable:next force_cast
            window.rootViewController = currentNavigationController as! UINavigationController
            ANLog.debug("Root Controller set to \(controller)")
            canBePopped.value = false
            currentController = Coordinator.actualController(for: window.rootViewController)
            subject.onCompleted()
            
        case .push:
            // Make sure we have a navi controller
            guard let navigationController = currentNavigationController else {
                fatalError("Can't push a Controller without a UINavigationController")
            }
            
            if let uiNavi = navigationController as? UINavigationController {
                // one-off subscription to be notified when push complete
                _ = uiNavi.rx.delegate
                    .sentMessage(#selector(UINavigationControllerDelegate.navigationController(_:didShow:animated:)))
                    .map { _ in }
                    .bind(to: subject)
            } else {
                subject.onCompleted()
            }
            
            // Push the one that belongs to scene
            navigationController.pushController(controller: controller, animated: true)
            
            // Set current VC and 'popability'
            canBePopped.value = true
            currentController = Coordinator.actualController(for: controller)
            if let controller = currentController {
                ANLog.debug("Current Controller set to \(controller)")
            }
            
        case .modal:
            // Set current view controller to root if nil
            if currentController == nil, let navi = currentNavigationController {
                currentController = navi.visibleController
            } else if currentController == nil, let window = window {
                currentController = window.rootViewController
            }
            
            // Make sure we have a current view controller
            guard let currentC = currentController else {
                fatalError("Current Controller not available")
            }
            
            // Use custom transition or presentation animation
            var cont = controller
            if let tStyle = modalTransitionStyle, let vc = controller as? UIViewController {
                vc.modalTransitionStyle = tStyle
                cont = vc
            }
            if let pStyle = modalPresentationStyle, let vc = controller as? UIViewController {
                vc.modalPresentationStyle = pStyle
                if pStyle == .custom {
                    vc.transitioningDelegate = currentC as? UIViewControllerTransitioningDelegate
                }
                cont = vc
            }
            
            // Present modally
            currentC.present(controller: cont, animated: true) {
                subject.onCompleted()
            }
            
            // Set current VC and 'popability'
            canBePopped.value = true
            currentController = Coordinator.actualController(for: controller)
            if let controller = currentController {
                ANLog.debug("Current Controller set to \(controller)")
            }
        }
        
        return subject.asObservable().take(1).ignoreElements()  // Take at most one emitted element, but don't forward it
    }
}

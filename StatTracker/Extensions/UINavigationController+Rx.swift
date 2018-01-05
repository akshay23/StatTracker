//
//  UINavigationController+Rx.swift
//  Builder
//
//  Created by Akshay Bharath on 12/14/17.
//  Copyright © 2017 Animoto. All rights reserved.
//

import RxCocoa
import RxSwift
import UIKit

class RxNavigationControllerDelegateProxy: DelegateProxy<UINavigationController, UINavigationControllerDelegate>, DelegateProxyType, UINavigationControllerDelegate {
    
    init(navigationController: UINavigationController) {
        super.init(parentObject: navigationController, delegateProxy: RxNavigationControllerDelegateProxy.self)
    }
    
    static func registerKnownImplementations() {
        self.register { RxNavigationControllerDelegateProxy(navigationController: $0) }
    }
    
    static func currentDelegateFor(_ object: AnyObject) -> AnyObject? {
        guard let navigationController = object as? UINavigationController else {
            fatalError("Delegate object is not a UINavigationController object")
        }
        return navigationController.delegate
    }
    
    static func setCurrentDelegate(_ delegate: AnyObject?, toObject object: AnyObject) {
        guard let navigationController = object as? UINavigationController else {
            fatalError("Delegate object is not a UINavigationController object")
        }
        if delegate == nil {
            navigationController.delegate = nil
        } else {
            guard let delegate = delegate as? UINavigationControllerDelegate else {
                fatalError("Delegate object is not a UINavigationController object")
            }
            navigationController.delegate = delegate
        }
    }
}

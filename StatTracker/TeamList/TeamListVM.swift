//
//  TeamListVM.swift
//  StatTracker
//
//  Created by Akshay Bharath on 1/5/18.
//  Copyright © 2018 Actionman Inc. All rights reserved.
//

import Action
import AnimotoKit
import RxSwift

class TeamListVM {
    
    private let disposeBag = DisposeBag()
    private let coordinator: CoordinatorDelegate
    
    init(coordinator: CoordinatorDelegate) {
        self.coordinator = coordinator
    }
    
    func dismiss() -> CocoaAction {
        return CocoaAction(enabledIf: coordinator.canBePopped.asObservable()) { [coordinator] _ in
            return coordinator.pop().asObservable().map(void)
        }
    }
}


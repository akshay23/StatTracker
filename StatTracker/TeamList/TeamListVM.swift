//
//  TeamListVM.swift
//  StatTracker
//
//  Created by Akshay Bharath on 1/5/18.
//  Copyright © 2018 Actionman Inc. All rights reserved.
//

import Action
import AnimotoKit
import Reachability
import RxSwift
import SwiftyJSON

class TeamListVM {
    
    let teamList: Observable<[Team]>
    
    private let disposeBag = DisposeBag()
    private let coordinator: CoordinatorDelegate
    private let globalScheduler = ConcurrentDispatchQueueScheduler(queue: DispatchQueue.global())
    
    init(coordinator: CoordinatorDelegate) {
        self.coordinator = coordinator
        
        let timerObs = Observable<NSInteger>.timer(0.0, period: 30.0, scheduler: globalScheduler)
        teamList = Observable.combineLatest(timerObs, Reachability.rx.reachable) { _, reachable in
            ANLog.info(reachable ? "User is connected to network" : "User is NOT connected to network")
            return reachable
        }
        .ignore(value: false)
        .flatMap { _ in StatTrackerProvider.fetchTeams() }
    }
    
    func dismiss() -> CocoaAction {
        return CocoaAction(enabledIf: coordinator.canBePopped.asObservable()) { [coordinator] _ in
            return coordinator.pop().asObservable().map(void)
        }
    }
}


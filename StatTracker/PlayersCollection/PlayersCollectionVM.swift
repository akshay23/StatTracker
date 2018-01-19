//
//  PlayersCollectionVM.swift
//  StatTracker
//
//  Created by Akshay Bharath on 1/19/18.
//  Copyright © 2018 Actionman Inc. All rights reserved.
//

import Action
import AnimotoKit
import Reachability
import RxSwift
import SwiftyJSON

class PlayersCollectionVM: NSObject {
    
    private let disposeBag = DisposeBag()
    private let coordinator: CoordinatorDelegate
    private let timerObs = Observable<NSInteger>.timer(0.0, period: 30.0, scheduler: ConcurrentDispatchQueueScheduler(queue: DispatchQueue.global()))
    
    let team: Team
    let playerList: Observable<[Player]>
    
    init(coordinator: CoordinatorDelegate, team: Team) {
        self.team = team
        self.coordinator = coordinator
        
        playerList = Observable.combineLatest(timerObs, Reachability.rx.reachable) { _, reachable in
            return reachable
        }
        .ignore(value: false)
        .flatMap { [team] _ in StatTrackerProvider.fetchPlayers(inTeam: team) }
        
        super.init()
    }
    
    func goBack() -> CocoaAction {
        return CocoaAction(enabledIf: coordinator.canBePopped.asObservable()) { [coordinator] in
            return coordinator.pop().asObservable().map(void)
        }
    }
}

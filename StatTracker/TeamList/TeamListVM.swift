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

class TeamListVM: NSObject {
    
    let teamList: Observable<[Team]>
    
    private let disposeBag = DisposeBag()
    private let coordinator: CoordinatorDelegate
    private let timerObs = Observable<NSInteger>.timer(0.0, period: 30.0, scheduler: ConcurrentDispatchQueueScheduler(queue: DispatchQueue.global()))
    
    init(coordinator: CoordinatorDelegate) {
        self.coordinator = coordinator
        
        teamList = Observable.combineLatest(timerObs, Reachability.rx.reachable) { _, reachable in
            return reachable
        }
        .ignore(value: false)
        .flatMap { _ in StatTrackerProvider.fetchTeams() }
        
        super.init()
    }
    
    func goToPlayersList(forTeam team: Team) {
        let playersVM = PlayersCollectionVM(coordinator: coordinator, team: team)
        let playersScene = PlayersCollectionScene(playersCollectionVM: playersVM)
        coordinator.transition(to: playersScene, type: .push)
    }
}


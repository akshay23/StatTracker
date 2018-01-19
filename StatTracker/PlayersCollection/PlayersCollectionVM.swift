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
import RxDataSources
import RxSwift
import SwiftyJSON

class PlayersCollectionVM: NSObject {
    
    private let disposeBag = DisposeBag()
    private let coordinator: CoordinatorDelegate
    //private let timerObs = Observable<NSInteger>.timer(0.0, period: 30.0, scheduler: ConcurrentDispatchQueueScheduler(queue: DispatchQueue.global()))
    
    let team: Team
    //let playerList: Observable<[Player]>
    
    init(coordinator: CoordinatorDelegate, team: Team) {
        self.team = team
        self.coordinator = coordinator
        
        super.init()
    }
    
    func playerSectionData() -> Single<[PlayersCollectionSectionData]> {
        return StatTrackerProvider.fetchPlayers(inTeam: team)
                .map { [team] playerList -> [PlayersCollectionSectionData] in
                            var players = [PlayersCollectionSectionData]()
                            players.append(PlayersCollectionSectionData(name: team.name, items: playerList))
                            return players
                }
    }
    
    func goBack() -> CocoaAction {
        return CocoaAction(enabledIf: coordinator.canBePopped.asObservable()) { [coordinator] in
            return coordinator.pop().asObservable().map(void)
        }
    }
}

struct PlayersCollectionSectionData {
    var name: String
    var items: [Player]
}

extension PlayersCollectionSectionData: SectionModelType {
    typealias Item = Player

    init(original: PlayersCollectionSectionData, items: [Item]) {
        self = original
        self.items = items
    }
}

//
//  PlayersCollectionScene.swift
//  StatTracker
//
//  Created by Akshay Bharath on 1/19/18.
//  Copyright © 2018 Actionman Inc. All rights reserved.
//

import Foundation

class PlayersCollectionScene: Scene {
    
    let viewModel: PlayersCollectionVM
    
    init(playersCollectionVM: PlayersCollectionVM) {
        viewModel = playersCollectionVM
    }
    
    func controller() -> BaseController {
        var vc = PlayersCollectionVC()
        vc.bindViewModel(to: viewModel)
        return vc
    }
}

//
//  TeamListScene.swift
//  StatTracker
//
//  Created by Akshay Bharath on 1/5/18.
//  Copyright © 2018 Actionman Inc. All rights reserved.
//

import Foundation

class TeamListScene: Scene {
    
    let viewModel: TeamListVM
    
    init(teamListVM: TeamListVM) {
        viewModel = teamListVM
    }
    
    func controller() -> BaseController {
        var vc = TeamListVC()
        vc.bindViewModel(to: viewModel)
        return vc
    }
}

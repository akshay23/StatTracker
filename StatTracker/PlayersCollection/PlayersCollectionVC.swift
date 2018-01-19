//
//  PlayersCollectionVC.swift
//  StatTracker
//
//  Created by Akshay Bharath on 1/19/18.
//  Copyright © 2018 Actionman Inc. All rights reserved.
//

import UIKit

class PlayersCollectionVC: UIViewController {
    
    var viewModel: PlayersCollectionVM?
    
    var backButton: UIBarButtonItem!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = viewModel?.team.name
        view.backgroundColor = .white
        backButton = UIBarButtonItem(title: "Back", style: .plain, target: nil, action: nil)
        navigationItem.leftBarButtonItem = backButton
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

// MARK:- BindableType
extension PlayersCollectionVC: BindableType {
    func bindViewModel() {
        if let viewModel = viewModel {
            backButton.rx.action = viewModel.goBack()
        }
    }
}

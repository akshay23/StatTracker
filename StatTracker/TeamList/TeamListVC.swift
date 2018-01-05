//
//  TeamListVC.swift
//  StatTracker
//
//  Created by Akshay Bharath on 1/5/18.
//  Copyright © 2018 Actionman Inc. All rights reserved.
//

import UIKit

class TeamListVC: UIViewController {
    
    var viewModel: TeamListVM?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

// MARK:- BindableType
extension TeamListVC: BindableType {
    func bindViewModel() {
    }
}

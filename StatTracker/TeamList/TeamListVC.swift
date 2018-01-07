//
//  TeamListVC.swift
//  StatTracker
//
//  Created by Akshay Bharath on 1/5/18.
//  Copyright © 2018 Actionman Inc. All rights reserved.
//

import AnimotoKit
import NSObject_Rx
import RxSwift
import SnapKit
import UIKit

class TeamListVC: UIViewController {
    
    var viewModel: TeamListVM?
    var scrollView: UIScrollView!
    var jsonTextView: UITextView!
    var myTableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.ANGray()
        
        // Table setup
        myTableView = UITableView()
        myTableView.register(TeamCell.self, forCellReuseIdentifier: "TeamCell")
        myTableView.tableFooterView = UIView() //Prevent empty rows
        myTableView.dataSource = nil
        myTableView.delegate = nil
        view.addSubview(myTableView)
        
        // Table constraints
        myTableView.snp.makeConstraints() { make in
            make.width.equalTo(view.bounds.width)
            make.bottom.equalToSuperview().offset(-30)
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
        }
        
//        scrollView = UIScrollView()
//        scrollView.bounces = true
//        scrollView.isScrollEnabled = true
//        scrollView.backgroundColor = UIColor.ANDarkGray()
//        view.addSubview(scrollView)
//
//        jsonTextView = UITextView()
//        jsonTextView.backgroundColor = UIColor.ANLightTeal()
//        jsonTextView.textColor = UIColor.ANBlack()
//        jsonTextView.isEditable = false
//        jsonTextView.isScrollEnabled = true
//        scrollView.addSubview(jsonTextView)
//        scrollView.contentSize = jsonTextView.bounds.size
//
//        scrollView.snp.makeConstraints() { make in
//            make.centerX.equalToSuperview()
//            make.centerY.equalToSuperview()
//            make.size.equalTo(CGSize(width: view.bounds.size.width, height: view.bounds.size.height - 100))
//        }
//
//        jsonTextView.snp.makeConstraints() { make in
//            make.centerX.equalToSuperview()
//            make.centerY.equalToSuperview()
//            make.size.equalTo(CGSize(width: view.bounds.size.width, height: view.bounds.size.height - 100))
//        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

// MARK:- BindableType
extension TeamListVC: BindableType {
    func bindViewModel() {
        if let viewModel = viewModel {
            // Fetch teams and bind to table
            viewModel.teamList
                .bind(to: myTableView.rx.items(cellIdentifier: "TeamCell", cellType: TeamCell.self)) {  row, element, cell in
                    cell.configureCell(usingTeam: element)
                }
                .disposed(by: rx.disposeBag)
        }
    }
}

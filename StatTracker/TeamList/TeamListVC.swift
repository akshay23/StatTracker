//
//  TeamListVC.swift
//  StatTracker
//
//  Created by Akshay Bharath on 1/5/18.
//  Copyright © 2018 Actionman Inc. All rights reserved.
//

import AnimotoKit
import NSObject_Rx
import RxDataSources
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
        
        // Table setup
        myTableView = UITableView()
        myTableView.register(TeamCell.self, forCellReuseIdentifier: "TeamCell")
        myTableView.rowHeight = 100
        myTableView.tableFooterView = UIView() //Prevent empty rows
        myTableView.dataSource = nil
        myTableView.delegate = self
        myTableView.backgroundColor = UIColor.ANLightGray()
        view.addSubview(myTableView)
        
        // Table constraints
        myTableView.snp.makeConstraints() { make in
            make.width.equalTo(view.bounds.width)
            make.bottom.equalToSuperview().offset(-30)
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
        }
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
                .asDriver(onErrorJustReturn: [])
                .drive(myTableView.rx.items(cellIdentifier: "TeamCell", cellType: TeamCell.self)) {  row, element, cell in
                    cell.configureCell(usingTeam: element)
                }
                .disposed(by: rx.disposeBag)
            
            myTableView.rx.itemSelected
                .subscribe(onNext: { [weak self] indexPath in
                    if let cell = self?.myTableView.cellForRow(at: indexPath) as? TeamCell, let t = cell.localTeam {
                        viewModel.goToPlayersList(forTeam: t)
                    }
                })
                .disposed(by: rx.disposeBag)
        }
    }
}

extension TeamListVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let v = UIView()
        v.backgroundColor = UIColor.clear
        return v
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 10
    }
}

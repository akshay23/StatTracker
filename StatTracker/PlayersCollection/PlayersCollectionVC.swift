//
//  PlayersCollectionVC.swift
//  StatTracker
//
//  Created by Akshay Bharath on 1/19/18.
//  Copyright © 2018 Actionman Inc. All rights reserved.
//

import AnimotoKit
import RxCocoa
import RxDataSources
import RxSwift
import RxSwiftExt
import SnapKit
import UIKit

class PlayersCollectionVC: UIViewController {
    
    var viewModel: PlayersCollectionVM?
    
    private let disposeBag = DisposeBag()
    private var backButton: UIBarButtonItem!
    private var activityIndicator: UIActivityIndicatorView!
    private var collectionView: UICollectionView!
    private var dataSource: RxCollectionViewSectionedReloadDataSource<PlayersCollectionSectionData>!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = viewModel?.team.name
        view.backgroundColor = .white
        backButton = UIBarButtonItem(title: "Back", style: .plain, target: nil, action: nil)
        navigationItem.leftBarButtonItem = backButton
        
        collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: UICollectionViewFlowLayout())
        collectionView.register(PlayerCell.self, forCellWithReuseIdentifier: PlayerCell.reuseIdentifier())
        collectionView.delegate = self
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .clear
        view.addSubview(collectionView)
        
        collectionView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        let dataSource = RxCollectionViewSectionedReloadDataSource<PlayersCollectionSectionData>(configureCell: { dataSource, collectionView, indexPath, player -> UICollectionViewCell in
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PlayerCell.reuseIdentifier(), for: indexPath) as? PlayerCell else {
                return UICollectionViewCell()
            }
            
            cell.player = player
            cell.layer.borderWidth = 1.0
            cell.layer.cornerRadius = 4.0
            return cell
        })
        
        self.dataSource = dataSource
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
            
            viewModel.playerSectionData()
                .asObservable()
                .bind(to: collectionView.rx.items(dataSource: dataSource))
                .disposed(by: rx.disposeBag)

        }
    }
}

extension PlayersCollectionVC: UICollectionViewDelegateFlowLayout {
    internal func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (collectionView.frame.width - 8.0 * 6.0) / 3.0
        let height = width + 50
        
        return CGSize(width: width, height: height)
    }
    
    internal func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: collectionView.frame.size.width, height: 32.0)
    }
    
    internal func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 8.0, left: 8.0, bottom: 8.0, right: 8.0)
    }
    
    internal func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 8.0
    }
    
    internal func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 8.0
    }
}

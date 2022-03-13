//
//  CollectionViewController.swift
//  vazhuravlev_3PW3
//
//  Created by Валерий Журавлев on 13.03.2022.
//

import Foundation
import UIKit

class CollectionViewController: UIViewController {
    private var collection: UICollectionView?
        
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .black
        setupCollectionView()
    }
        
    private func setupCollectionView() {
        let layoutFlow = UICollectionViewFlowLayout()
        layoutFlow.sectionInset = UIEdgeInsets(top: 20, left: 10, bottom: 10, right: 10)
        layoutFlow.itemSize = CGSize(width: 60, height: 60)
            
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layoutFlow)
        collection.backgroundColor = .white
        self.view.addSubview(collection)
        collection.pinTop(to: self.view.safeAreaLayoutGuide.topAnchor)
        collection.pinBottom(to: self.view.safeAreaLayoutGuide.bottomAnchor)
        collection.pin(to: self.view, .left, .right)
        self.collection = collection
    }
}

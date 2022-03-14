//
//  CollectionViewController.swift
//  vazhuravlev_3PW3
//
//  Created by Валерий Журавлев on 13.03.2022.
//

import Foundation
import UIKit

class CollectionViewController: UIViewController, CollectionViewDisplayLogic, CollectionAlarmViewDelegate {
    public var interactor: CollectionViewBusinessLogic!
    private var collection: UICollectionView?
    private var currentAlarms: [AlarmModel] = []
        
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        setupCollectionView()
    }
    
    // When view apperars we update alarms.
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        interactor.fetchAlarms()
    }
        
    private func setupCollectionView() {
        // Configuring layout.
        let layoutFlow = UICollectionViewFlowLayout()
        layoutFlow.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        layoutFlow.itemSize = CGSize(width: self.view.frame.width, height: 80)
        layoutFlow.minimumLineSpacing = 0
        layoutFlow.minimumInteritemSpacing = 0
        layoutFlow.scrollDirection = .horizontal
        
        // Configuring collection view.
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layoutFlow)
        collection.isPagingEnabled = true
        collection.dataSource = self
        collection.register(CollectionAlarmView.self,
                            forCellWithReuseIdentifier: CollectionAlarmView.reuseIdentifier)
        collection.backgroundColor = .white
        self.view.addSubview(collection)
        collection.pinTop(to: self.view.safeAreaLayoutGuide.topAnchor)
        collection.pinBottom(to: self.view.safeAreaLayoutGuide.bottomAnchor)
        collection.pin(to: self.view, .left, .right)
        self.collection = collection
    }
    
    func displayUpdatedAlarms(alarms: [AlarmModel]) {
        self.currentAlarms = alarms
        self.collection?.reloadData()
    }
    
    func processSwitchActionFrom(id: UUID, with activity: Bool) {
        self.interactor.changeActivityIndicatorAt(id: id, with: activity)
    }
}

extension CollectionViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        currentAlarms.count
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: CollectionAlarmView.reuseIdentifier, for: indexPath) as? CollectionAlarmView
        cell?.loadFrom(alarmModel: currentAlarms[indexPath.row])
        cell?.delegate = self
        return cell ?? UICollectionViewCell()
    }
    
}

protocol CollectionViewDisplayLogic: AnyObject {
    func displayUpdatedAlarms(alarms: [AlarmModel])
}

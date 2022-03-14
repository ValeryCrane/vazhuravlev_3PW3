//
//  CollectionViewController.swift
//  vazhuravlev_3PW3
//
//  Created by Валерий Журавлев on 13.03.2022.
//

import Foundation
import UIKit

protocol CollectionDisplayLogic: AnyObject {
    func displayUpdatedAlarms(alarms: [TextAlarmModel]) // Displays alarm data recieved from presenter.
}

class CollectionViewController: UIViewController {
    public var interactor: CollectionBusinessLogic!
    public var router: CollectionRoutingLogic!
    private var collection: UICollectionView?
    private var currentAlarms: [TextAlarmModel] = []
        
    // MARK: - ViewController's life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
    }
    
    // When view apperars we update alarms.
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        interactor.fetchAlarms()
    }
        
    // MARK: - Setup functions
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
        collection.delegate = self
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
}


// MARK: - UICollectionViewDelegate & DataSource implementation
extension CollectionViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.router.routeToEditAlarmScene(alarmId: self.currentAlarms[indexPath.row].id)
        collectionView.deselectItem(at: indexPath, animated: false)
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
        cell?.loadFrom(alarm: currentAlarms[indexPath.row])
        cell?.delegate = self
        return cell ?? UICollectionViewCell()
    }
    
}


// MARK: - CollectionDisplayLogic implementation
extension CollectionViewController: CollectionDisplayLogic {
    func displayUpdatedAlarms(alarms: [TextAlarmModel]) {
        self.currentAlarms = alarms
        self.collection?.reloadData()
    }
}


// MARK: - CollectionAlarmViewDelegate implementation
extension CollectionViewController: CollectionAlarmViewDelegate {
    func processSwitchActionFrom(id: UUID, with activity: Bool) {
        self.interactor.changeActivityIndicatorAt(id: id, with: activity)
    }
}

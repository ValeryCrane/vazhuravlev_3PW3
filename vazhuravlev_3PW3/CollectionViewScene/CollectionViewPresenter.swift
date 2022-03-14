//
//  CollectionViewPresenter.swift
//  vazhuravlev_3PW3
//
//  Created by Валерий Журавлев on 14.03.2022.
//

import Foundation

class CollectionViewPresenter: CollectionViewPresentationLogic {
    public weak var view: CollectionViewDisplayLogic!
    
    func presentUpdatedAlarms(alarms: [AlarmModel]) {
        view.displayUpdatedAlarms(alarms: alarms)
    }
}

protocol CollectionViewPresentationLogic: AnyObject {
    func presentUpdatedAlarms(alarms: [AlarmModel])     // Presents fetched alarms.
}

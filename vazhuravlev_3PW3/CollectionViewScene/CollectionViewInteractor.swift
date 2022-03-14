//
//  CollectionViewInteractor.swift
//  vazhuravlev_3PW3
//
//  Created by Валерий Журавлев on 14.03.2022.
//

import Foundation

class CollectionViewInteractor: CollectionViewBusinessLogic {
    private let alarmWorker = AlarmWorker()
    public var presenter: CollectionViewPresentationLogic!
    
    func fetchAlarms() {
        self.presenter.presentUpdatedAlarms(alarms: self.alarmWorker.getCurrentAlarms())
    }
    
    func changeActivityIndicatorAt(id: UUID, with activity: Bool) {
        alarmWorker.change(id: id, activity: activity)
    }
}

protocol CollectionViewBusinessLogic: AnyObject {
    func fetchAlarms()                                      // Fetches alarms from worker and passes it to presenter.
    func changeActivityIndicatorAt(id: UUID, with: Bool)    // Changes activity indicator of certain alarm.
}

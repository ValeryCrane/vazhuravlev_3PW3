//
//  StackViewInteractor.swift
//  vazhuravlev_3PW3
//
//  Created by Валерий Журавлев on 13.03.2022.
//

import Foundation

class StackViewInteractor: StackViewBusinessLogic {
    private let alarmWorker = AlarmWorker()
    public var presenter: StackViewPresentationLogic!
    
    func fetchAlarms() {
        self.presenter.presentUpdatedAlarms(alarms: self.alarmWorker.getCurrentAlarms())
    }
    
    func changeActivityIndicatorAt(id: UUID, with activity: Bool) {
        alarmWorker.change(id: id, activity: activity)
    }
}

protocol StackViewBusinessLogic: AnyObject {
    func fetchAlarms()                                      // Fetches alarms from worker and passes it to presenter.
    func changeActivityIndicatorAt(id: UUID, with: Bool)    // Changes activity indicator of certain alarm.
}

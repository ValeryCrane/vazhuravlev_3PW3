//
//  StackInteractor.swift
//  vazhuravlev_3PW3
//
//  Created by Валерий Журавлев on 13.03.2022.
//

import Foundation


protocol StackBusinessLogic: AnyObject {
    func fetchAlarms()                                      // Fetches alarms from worker and passes it to presenter.
    func changeActivityIndicatorAt(id: UUID, with: Bool)    // Changes activity indicator of certain alarm.
}


class StackInteractor {
    private let alarmWorker = AlarmWorker()
    public var presenter: StackPresentationLogic!
}


// MARK: - StackBusinessLogic implementation
extension StackInteractor: StackBusinessLogic {
    func fetchAlarms() {
        let alarms = self.alarmWorker.getCurrentAlarms()
        self.presenter.presentUpdatedAlarms(alarms: alarms)
    }
    
    func changeActivityIndicatorAt(id: UUID, with activity: Bool) {
        alarmWorker.change(id: id, activity: activity)
    }
}

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
    
    func addRandomAlarms(count: Int) {
        for _ in 0..<count {
            self.alarmWorker.add(
                alarm: AlarmModel(hours: Int.random(in: 0..<24),
                                  minutes: Int.random(in: 0..<60)),
                completion: nil
            )
        }
        self.presenter.presentUpdatedAlarms(alarms: self.alarmWorker.getCurrentAlarms())
    }
}

protocol StackViewBusinessLogic: AnyObject {
    func fetchAlarms() // Fetches alarms from worker and passes it to presenter.
    func addRandomAlarms(count: Int) // Adds alarms through worker and passes result to presenter.
}

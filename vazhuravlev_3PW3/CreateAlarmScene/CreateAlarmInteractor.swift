//
//  CreateAlarmInteractor.swift
//  vazhuravlev_3PW3
//
//  Created by Валерий Журавлев on 14.03.2022.
//

import Foundation


protocol CreateAlarmBusinessLogic: AnyObject {
    func addAlarm(hours: Int, minutes: Int)    // Adds given alarm via worker.
}

class CreateAlarmInteractor {
    private let alarmWorker = AlarmWorker()
}


// MARK: - CreateAlarmBusinessLogic implementation
extension CreateAlarmInteractor: CreateAlarmBusinessLogic {
    func addAlarm(hours: Int, minutes: Int) {
        let alarm = AlarmModel(hours: hours, minutes: minutes)
        alarmWorker.add(alarm: alarm, completion: nil)
    }
}

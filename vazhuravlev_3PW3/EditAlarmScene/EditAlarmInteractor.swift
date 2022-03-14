//
//  EditAlarmInteractor.swift
//  vazhuravlev_3PW3
//
//  Created by Валерий Журавлев on 14.03.2022.
//

import Foundation

protocol EditAlarmBusinessLogic: AnyObject {
    func fetchAlarm()                           // Fetches given alarm by id.
    func editAlarm(hours: Int, minutes: Int)    // Edits given alarm by id.
}

protocol EditAlarmDataStore: AnyObject {
    var alarmId: UUID? { get set }              // Given alarm id.
}

class EditAlarmInteractor: EditAlarmDataStore {
    public var alarmId: UUID?
    public var presenter: EditAlarmPresentationLogic!
    private let alarmWorker = AlarmWorker()
}


// MARK: - EditAlarmBusinessLogic implementation
extension EditAlarmInteractor: EditAlarmBusinessLogic {
    func editAlarm(hours: Int, minutes: Int) {
        if let alarmId = self.alarmId {
            self.alarmWorker.change(id: alarmId, hours: hours, minutes: minutes)
        }
    }
    
    func fetchAlarm() {
        if let alarmId = self.alarmId {
            let alarm = self.alarmWorker.getAlarmById(id: alarmId)
            if let alarm = alarm {
                self.presenter.present(alarm: alarm)
            }
        }
    }
}


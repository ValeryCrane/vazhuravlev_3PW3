//
//  AlarmManager.swift
//  vazhuravlev_3PW3
//
//  Created by Валерий Журавлев on 13.03.2022.
//

import Foundation

// Worker stores and mutate alarm models.
class AlarmWorker {
    private static var alarms: [AlarmModel] = []
    
    func add(alarm: AlarmModel, completion: (([AlarmModel]) -> ())?) {
        AlarmWorker.alarms.append(alarm)
        AlarmWorker.alarms.sort {$0.getSumOfMinutes() < $1.getSumOfMinutes()}
        completion?(AlarmWorker.alarms)
    }
    
    func remove(id: UUID, completion: (([AlarmModel]) -> ())?) {
        AlarmWorker.alarms = AlarmWorker.alarms.filter {$0.getId() != id}
        completion?(AlarmWorker.alarms)
    }
    
    func getCurrentAlarms() -> [AlarmModel] {
        return AlarmWorker.alarms
    }
}

//
//  AlarmManager.swift
//  vazhuravlev_3PW3
//
//  Created by Валерий Журавлев on 13.03.2022.
//

import Foundation

// Worker stores and mutate alarm models.
class AlarmWorker {
    private var alarms: [AlarmModel] = []
    
    func add(alarm: AlarmModel, completion: (([AlarmModel]) -> ())?) {
        alarms.append(alarm)
        alarms.sort {$0.getSumOfMinutes() < $1.getSumOfMinutes()}
        completion?(alarms)
    }
    
    func remove(id: UUID, completion: (([AlarmModel]) -> ())?) {
        alarms = alarms.filter {$0.getId() != id}
        completion?(alarms)
    }
    
    func getCurrentAlarms() -> [AlarmModel] {
        return alarms
    }
}

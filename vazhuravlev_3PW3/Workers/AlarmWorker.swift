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
    
    func change(id: UUID, activity: Bool) {
        for i in 0..<AlarmWorker.alarms.count {
            if AlarmWorker.alarms[i].getId() == id {
                AlarmWorker.alarms[i].isActive = activity
            }
        }
    }
    
    func change(id: UUID, hours: Int, minutes: Int) {
        for i in 0..<AlarmWorker.alarms.count {
            if AlarmWorker.alarms[i].getId() == id {
                AlarmWorker.alarms[i].changeTime(hours: hours, minutes: minutes)
            }
        }
        AlarmWorker.alarms.sort {$0.getSumOfMinutes() < $1.getSumOfMinutes()}
    }
    
    func getCurrentAlarms() -> [AlarmModel] {
        return AlarmWorker.alarms
    }
    
    func getAlarmById(id: UUID) -> AlarmModel? {
        for alarm in AlarmWorker.alarms {
            if alarm.getId() == id {
                return alarm
            }
        }
        return nil
    }
    
    func addRandomAlarms(count: Int, completion: (([AlarmModel]) -> ())?) {
        for _ in 0..<count {
            var alarm = AlarmModel(hours: Int.random(in: 0..<24), minutes: Int.random(in: 0..<60))
            alarm.isActive = Bool.random()
            self.add(alarm: alarm, completion: nil)
        }
        completion?(AlarmWorker.alarms)
    }
}

//
//  AlarmManager.swift
//  vazhuravlev_3PW3
//
//  Created by Валерий Журавлев on 13.03.2022.
//

import Foundation
import UserNotifications
import CoreData

// Worker stores and mutate alarm models.
class AlarmWorker {
    public static let storeName = "AlarmCoreData"
    private static var alarms: [AlarmModel] = []
    private static let notificationCenter = UNUserNotificationCenter.current()
    
    
    // MARK: - CoreData
    // Initializing context
    private static let context: NSManagedObjectContext = {
        // Creationg persistantContainer, loadingStores and returning context.
        let container = NSPersistentContainer(name: AlarmWorker.storeName)
        container.loadPersistentStores { _, error in
            if let error = error {
                fatalError("Container loading failed")
            }
        }
        return container.viewContext
    }()
    
    // Method saves changes in context.
    private static func saveChanges() {
        if Self.context.hasChanges {
            try? Self.context.save()
        }
    }
    
    // Method fetches data from CoreData.
    public static func boundWithCoreData() {
        let fetchRequest: NSFetchRequest<Alarm> = Alarm.fetchRequest()
        guard let alarms = try? Self.context.fetch(fetchRequest) else { return }
        Self.alarms = []
        for alarm in alarms {
            var newAlarm = AlarmModel(hours: Int(alarm.hours),
                                      minutes: Int(alarm.minutes),
                                      sound: AlarmSound(rawValue: Int(alarm.sound)) ?? AlarmSound.student)
            newAlarm.isActive = alarm.isActive
            newAlarm.setId(id: alarm.id)
            Self.alarms.append(newAlarm)
        }
    }
    
    // Method adds alarm to CoreData
    private func addCoreData(alarm: AlarmModel) {
        let coreAlarm = Alarm(context: Self.context)
        coreAlarm.id = alarm.getId()
        coreAlarm.hours = Int32(alarm.getHours())
        coreAlarm.minutes = Int32(alarm.getMinutes())
        coreAlarm.isActive = alarm.isActive
        coreAlarm.sound = Int32(alarm.getSound().rawValue)
        Self.saveChanges()
    }
    
    // Method removes alarm from CoreData
    private func removeCoreData(id: UUID) {
        let fetchRequest: NSFetchRequest<Alarm> = Alarm.fetchRequest()
        guard let alarms = try? Self.context.fetch(fetchRequest) else { return }
        for alarm in alarms {
            if alarm.id == id {
                Self.context.delete(alarm)
            }
        }
        Self.saveChanges()
    }
    
    // Method chages alarm in CoreData
    private func changeCoreData(id: UUID, activity: Bool) {
        print("Change")
        let fetchRequest: NSFetchRequest<Alarm> = Alarm.fetchRequest()
        guard let alarms = try? Self.context.fetch(fetchRequest) else { return }
        print("Success")
        for alarm in alarms {
            print(alarm.id, id)
            if alarm.id == id {
                alarm.isActive = activity
            }
        }
        Self.saveChanges()
    }
    
    // Method chages alarm in CoreData
    private func changeCoreData(id: UUID, hours: Int, minutes: Int) {
        let fetchRequest: NSFetchRequest<Alarm> = Alarm.fetchRequest()
        guard let alarms = try? Self.context.fetch(fetchRequest) else { return }
        for alarm in alarms {
            if alarm.id == id {
                alarm.hours = Int32(hours)
                alarm.minutes = Int32(minutes)
            }
        }
        Self.saveChanges()
    }
    
    // Method chages alarm in CoreData
    private func changeCoreData(id: UUID, sound: AlarmSound) {
        let fetchRequest: NSFetchRequest<Alarm> = Alarm.fetchRequest()
        guard let alarms = try? Self.context.fetch(fetchRequest) else { return }
        for alarm in alarms {
            if alarm.id == id {
                alarm.sound = Int32(sound.rawValue)
            }
        }
        Self.saveChanges()
    }
    
    // MARK: - User Notifications
    // Method updates notification in notification center.
    private func updateNotification(alarm: AlarmModel) {
        let content = UNMutableNotificationContent()
        content.title = "Alarm"
        
        switch alarm.getSound() {
        case .student:
            content.sound = UNNotificationSound(named: UNNotificationSoundName(rawValue: "Student.wav"))
        case .armyanRadio:
            content.sound = UNNotificationSound(named: UNNotificationSoundName(rawValue: "ArmyanRadio.wav"))
        case .govoritMoskva:
            content.sound = UNNotificationSound(named: UNNotificationSoundName(rawValue: "GovoritMoskva.wav"))
        }
        
        var dateComponents = DateComponents()
        dateComponents.hour = alarm.getHours()
        dateComponents.minute = alarm.getMinutes()
        dateComponents.second = 0
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
        
        let id = "\(alarm.getId())"
        
        let request = UNNotificationRequest(identifier: id, content: content, trigger: trigger)
        
        Self.notificationCenter.add(request) { error in
            if let error = error {
                print(error.localizedDescription)
            }
        }
    }
    
    // Method removes notification from notification center.
    private func removeNotification(id: UUID) {
        Self.notificationCenter.removePendingNotificationRequests(withIdentifiers: ["\(id)"])
        Self.notificationCenter.removeDeliveredNotifications(withIdentifiers: ["\(id)"])
    }
    
    
    // MARK: default functions
    // Method adds alarm.
    func add(alarm: AlarmModel, completion: (([AlarmModel]) -> ())?) {
        AlarmWorker.alarms.append(alarm)
        AlarmWorker.alarms.sort {$0.getSumOfMinutes() < $1.getSumOfMinutes()}
        if (alarm.isActive) {
            updateNotification(alarm: alarm)
        }
        addCoreData(alarm: alarm)
        completion?(AlarmWorker.alarms)
    }
    
    // Method removes alarm.
    func remove(id: UUID, completion: (([AlarmModel]) -> ())?) {
        AlarmWorker.alarms = AlarmWorker.alarms.filter {$0.getId() != id}
        removeNotification(id: id)
        removeCoreData(id: id)
        completion?(AlarmWorker.alarms)
    }
    
    // Method changes alarm.
    func change(id: UUID, activity: Bool) {
        for i in 0..<AlarmWorker.alarms.count {
            if AlarmWorker.alarms[i].getId() == id {
                AlarmWorker.alarms[i].isActive = activity
                if activity {
                    updateNotification(alarm: AlarmWorker.alarms[i])
                } else {
                    removeNotification(id: id)
                }
            }
        }
        changeCoreData(id: id, activity: activity)
    }
    
    // Method changes alarm.
    func change(id: UUID, hours: Int, minutes: Int) {
        for i in 0..<AlarmWorker.alarms.count {
            if AlarmWorker.alarms[i].getId() == id {
                AlarmWorker.alarms[i].changeTime(hours: hours, minutes: minutes)
                updateNotification(alarm: AlarmWorker.alarms[i])
            }
        }
        AlarmWorker.alarms.sort {$0.getSumOfMinutes() < $1.getSumOfMinutes()}
        changeCoreData(id: id, hours: hours, minutes: minutes)
    }
    
    // Method changes alarm.
    func change(id: UUID, sound: AlarmSound) {
        for i in 0..<AlarmWorker.alarms.count {
            if AlarmWorker.alarms[i].getId() == id {
                AlarmWorker.alarms[i].changeSound(sound: sound)
                updateNotification(alarm: AlarmWorker.alarms[i])
            }
        }
        changeCoreData(id: id, sound: sound)
    }
    
    // Returns all current alarms.
    func getCurrentAlarms() -> [AlarmModel] {
        return AlarmWorker.alarms
    }
    
    // Returns alarm bu its id.
    func getAlarmById(id: UUID) -> AlarmModel? {
        for alarm in AlarmWorker.alarms {
            if alarm.getId() == id {
                return alarm
            }
        }
        return nil
    }
}

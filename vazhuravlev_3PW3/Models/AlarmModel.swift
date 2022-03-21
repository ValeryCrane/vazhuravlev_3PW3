//
//  AlarmModel.swift
//  vazhuravlev_3PW3
//
//  Created by Валерий Журавлев on 13.03.2022.
//

import Foundation

struct AlarmModel {
    private var hours: Int
    private var minutes: Int
    private var id = UUID()
    private var sound: AlarmSound
    var isActive: Bool = true
    
    init(minutes: Int, sound: AlarmSound) {
        guard minutes >= 0, minutes < 1440
        else { self.minutes = 0; self.hours = 0; self.sound = sound; return }
        self.hours = minutes / 60
        self.minutes = minutes % 60;
        self.sound = sound
    }
    
    init(hours: Int, minutes: Int, sound: AlarmSound) {
        guard minutes >= 0, minutes < 60,
              hours >= 0, hours < 24
        else { self.minutes = 0; self.hours = 0; self.sound = sound; return }
        self.hours = hours
        self.minutes = minutes
        self.sound = sound
    }
    
    mutating func changeTime(hours: Int, minutes: Int) {
        guard minutes >= 0, minutes < 60, hours >= 0, hours < 24 else { return }
        self.hours = hours
        self.minutes = minutes
    }
    
    mutating func changeSound(sound: AlarmSound) {
        self.sound = sound
    }
    
    mutating func setId(id: UUID) {
        self.id = id
    }
    
    func getSound() -> AlarmSound {
        return sound
    }
    
    func getHours() -> Int {
        return self.hours
    }
    
    func getMinutes() -> Int {
        return self.minutes
    }
    
    func getSumOfMinutes() -> Int {
        return self.hours * 60 + self.minutes
    }
    
    func getId() -> UUID {
        return id
    }
}

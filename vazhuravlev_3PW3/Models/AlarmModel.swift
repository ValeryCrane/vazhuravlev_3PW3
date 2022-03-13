//
//  AlarmModel.swift
//  vazhuravlev_3PW3
//
//  Created by Валерий Журавлев on 13.03.2022.
//

import Foundation

struct AlarmModel {
    private let id = UUID()
    private let minutes: Int
    public var isActive: Bool = true
    
    init(minutes: Int) {
        guard minutes >= 0, minutes < 1440 else { self.minutes = 0; return }
        self.minutes = minutes;
    }
    
    init(hours: Int, minutes: Int) {
        guard minutes >= 0, minutes < 60,
              hours >= 0, hours < 24 else { self.minutes = 0; return }
        self.minutes = hours * 60 + minutes
    }
    
    func getHours() -> Int {
        return self.minutes / 60
    }
    
    func getMinutes() -> Int {
        return self.minutes % 60
    }
    
    func getSumOfMinutes() -> Int {
        return self.minutes
    }
    
    func getId() -> UUID {
        return id
    }
}

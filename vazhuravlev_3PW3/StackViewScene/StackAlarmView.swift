//
//  StackAlarmView.swift
//  vazhuravlev_3PW3
//
//  Created by Валерий Журавлев on 13.03.2022.
//

import Foundation
import UIKit

// Custom alarm view for UIStackView. Consists of time label and switch.
class StackAlarmView: UIView {
    private let id: UUID
    
    init(alarmModel: AlarmModel) {
        id = alarmModel.getId()
        super.init(frame: .zero)
        
        let timeLabel = UILabel()
        timeLabel.text = presentTime(hours: alarmModel.getHours(), minutes: alarmModel.getMinutes())
        timeLabel.font = UIFont.systemFont(ofSize: 32)
        self.addSubview(timeLabel)
        timeLabel.pinTop(to: self.topAnchor, 20)
        timeLabel.pinLeft(to: self.leadingAnchor, 20)
        timeLabel.pinBottom(to: self.bottomAnchor, 20)
        
        let onSwitch = UISwitch()
        onSwitch.isOn = alarmModel.isActive
        self.addSubview(onSwitch)
        onSwitch.pinTop(to: self.topAnchor, 20)
        onSwitch.pinRight(to: self.trailingAnchor, 20)
    }
    
    // Converts numbered time to string
    private func presentTime(hours: Int, minutes: Int) -> String {
        return (hours < 10 ? "0" + String(hours) : String(hours)) + ":" +
               (minutes < 10 ? "0" + String(minutes) : String(minutes))
    }
    
    // Returns Id of given alarm
    func getAlarmId() -> UUID {
        return id
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

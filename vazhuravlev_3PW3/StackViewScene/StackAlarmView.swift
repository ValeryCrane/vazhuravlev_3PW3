//
//  StackAlarmView.swift
//  vazhuravlev_3PW3
//
//  Created by Валерий Журавлев on 13.03.2022.
//

import Foundation
import UIKit


protocol StackAlarmViewDelegate: AnyObject {
    func processSwitchActionFrom(id: UUID, with: Bool) // Processes switch action from certain alarm.
    func processTapOnAlarmWith(id: UUID)               // Processes tap on alarmView.
}


// Custom alarm view for UIStackView. Consists of time label and switch.
class StackAlarmView: UIView {
    public weak var delegate: StackAlarmViewDelegate?
    private let alarmId: UUID
    private let timeLabel: UILabel
    private let onSwitch: UISwitch
    
    init(alarm: TextAlarmModel) {
        self.alarmId = alarm.id
        self.timeLabel = UILabel()
        self.onSwitch = UISwitch()
        super.init(frame: .zero)
        
        self.timeLabel.text = alarm.time
        self.timeLabel.font = UIFont.systemFont(ofSize: 32)
        self.addSubview(timeLabel)
        self.timeLabel.pinTop(to: self.topAnchor, 20)
        self.timeLabel.pinLeft(to: self.leadingAnchor, 20)
        self.timeLabel.pinBottom(to: self.bottomAnchor, 20)
        
        self.onSwitch.isOn = alarm.isActive
        self.addSubview(onSwitch)
        self.onSwitch.pinTop(to: self.topAnchor, 20)
        self.onSwitch.pinRight(to: self.trailingAnchor, 20)
        self.onSwitch.addTarget(self, action: #selector(self.sendSwitchAction), for: .valueChanged)
        
        let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.sendTapAction))
        self.addGestureRecognizer(tapRecognizer)
    }
    
    // Returns Id of given alarm
    func getAlarmId() -> UUID {
        return alarmId
    }
    
    // Notifying delegate about switch value changed.
    @objc private func sendSwitchAction() {
        self.delegate?.processSwitchActionFrom(id: self.alarmId, with: onSwitch.isOn)
    }
    
    // Notifying delegate about tap on view.
    @objc private func sendTapAction() {
        self.delegate?.processTapOnAlarmWith(id: self.alarmId)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


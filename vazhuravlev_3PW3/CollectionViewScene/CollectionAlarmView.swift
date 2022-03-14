//
//  CollectionAlarmView.swift
//  vazhuravlev_3PW3
//
//  Created by Валерий Журавлев on 14.03.2022.
//

import Foundation
import UIKit

// Custom alarm view for UICollectionView. Consists of time label and switch.
class CollectionAlarmView: UICollectionViewCell {
    public static let reuseIdentifier = "CollectionAlarmCell"
    public weak var delegate: CollectionAlarmViewDelegate?
    private var id: UUID?
    private let timeLabel: UILabel
    private let onSwitch: UISwitch
    
    override init(frame: CGRect) {
        self.timeLabel = UILabel()
        self.onSwitch = UISwitch()
        super.init(frame: frame)
        
        self.timeLabel.font = UIFont.systemFont(ofSize: 32)
        self.contentView.addSubview(timeLabel)
        self.timeLabel.pinTop(to: self.contentView.topAnchor, 20)
        self.timeLabel.pinLeft(to: self.contentView.leadingAnchor, 20)
        self.timeLabel.pinBottom(to: self.contentView.bottomAnchor, 20)
        
        self.contentView.addSubview(onSwitch)
        self.onSwitch.pinTop(to: self.contentView.topAnchor, 20)
        self.onSwitch.pinRight(to: self.contentView.trailingAnchor, 20)
        self.onSwitch.addTarget(self, action: #selector(self.sendSwitchAction), for: .valueChanged)
    }
    
    // Loads data from alarmModel into view elements.
    func loadFrom(alarmModel: AlarmModel) {
        self.id = alarmModel.getId()
        self.timeLabel.text = presentTime(hours: alarmModel.getHours(), minutes: alarmModel.getMinutes())
        self.onSwitch.isOn = alarmModel.isActive
    }
    
    // Converts numbered time to string.
    private func presentTime(hours: Int, minutes: Int) -> String {
        return (hours < 10 ? "0" + String(hours) : String(hours)) + ":" +
               (minutes < 10 ? "0" + String(minutes) : String(minutes))
    }
    
    // Notifying delegate about uiswitch value changed.
    @objc func sendSwitchAction() {
        if let id = self.id {
            self.delegate?.processSwitchActionFrom(id: id, with: onSwitch.isOn)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

protocol CollectionAlarmViewDelegate: AnyObject {
    func processSwitchActionFrom(id: UUID, with: Bool)
}

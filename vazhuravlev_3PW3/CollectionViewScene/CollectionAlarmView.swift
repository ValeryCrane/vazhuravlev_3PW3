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
    
    // Setting up the view.
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
    func loadFrom(alarm: TextAlarmModel) {
        self.id = alarm.id
        self.timeLabel.text = alarm.time
        self.onSwitch.isOn = alarm.isActive
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

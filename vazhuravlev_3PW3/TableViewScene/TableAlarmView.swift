//
//  TableAlarmView.swift
//  vazhuravlev_3PW3
//
//  Created by Валерий Журавлев on 14.03.2022.
//

import Foundation
import UIKit

// Custom alarm view for UITableView. Consists of time label and switch.
final class TableAlarmView: UITableViewCell {
    public static let reuseIdentifier = "TableAlarmCell"
    public weak var delegate: TableAlarmViewDelegate?
    private var id: UUID?
    private let timeLabel: UILabel
    private let onSwitch: UISwitch
    
    // Setting up the view.
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        timeLabel = UILabel()
        onSwitch = UISwitch()
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        timeLabel.font = UIFont.systemFont(ofSize: 32)
        self.contentView.addSubview(timeLabel)
        timeLabel.pinTop(to: self.contentView.topAnchor, 20)
        timeLabel.pinLeft(to: self.contentView.leadingAnchor, 20)
        timeLabel.pinBottom(to: self.contentView.bottomAnchor, 20)
        
        self.contentView.addSubview(onSwitch)
        onSwitch.pinTop(to: self.contentView.topAnchor, 20)
        onSwitch.pinRight(to: self.contentView.trailingAnchor, 20)
        onSwitch.addTarget(self, action: #selector(self.sendSwitchAction), for: .valueChanged)
        
        let separator = UIView()
        separator.backgroundColor = .darkGray
        self.contentView.addSubview(separator)
        separator.pin(to: contentView, .left, .right, .bottom)
        separator.setHeight(to: 1)
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

protocol TableAlarmViewDelegate: AnyObject {
    func processSwitchActionFrom(id: UUID, with: Bool)
}

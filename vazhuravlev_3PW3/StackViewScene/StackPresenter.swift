//
//  StackPresenter.swift
//  vazhuravlev_3PW3
//
//  Created by Валерий Журавлев on 13.03.2022.
//

import Foundation


protocol StackPresentationLogic: AnyObject {
    func presentUpdatedAlarms(alarms: [AlarmModel]) // Presents fetched alarms.
}


class StackPresenter {
    public weak var view: StackDisplayLogic!
    
    // Converts digital time into string
    private func convertTimeToString(hours: Int, minutes: Int) -> String {
        guard hours >= 0, hours < 24, minutes >= 0, minutes < 60 else { return "00:00" }
        return (hours < 10 ? "0" + String(hours) : String(hours)) + ":" +
            (minutes < 10 ? "0" + String(minutes): String(minutes))
    }
}


// MARK: - StackPresentationLogic implementation
extension StackPresenter: StackPresentationLogic {
    func presentUpdatedAlarms(alarms: [AlarmModel]) {
        let textAlarms = alarms.map { alarm in
            return TextAlarmModel(
                id: alarm.getId(),
                time:
                    convertTimeToString(
                    hours: alarm.getHours(),
                    minutes: alarm.getMinutes()),
                isActive: alarm.isActive
            )
        }
        view.displayUpdatedAlarms(alarms: textAlarms)
    }
}

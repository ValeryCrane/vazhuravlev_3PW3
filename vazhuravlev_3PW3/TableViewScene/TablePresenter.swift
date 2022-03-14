//
//  TablePresenter.swift
//  vazhuravlev_3PW3
//
//  Created by Валерий Журавлев on 14.03.2022.
//

import Foundation

protocol TablePresentationLogic: AnyObject {
    func presentUpdatedAlarms(alarms: [AlarmModel]) // Presents fetched alarms.
}

class TablePresenter {
    public weak var view: TableDisplayLogic!
    
    // Converts digital time into string
    private func convertTimeToString(hours: Int, minutes: Int) -> String {
        guard hours >= 0, hours < 24, minutes >= 0, minutes < 60 else { return "00:00" }
        return (hours < 10 ? "0" + String(hours) : String(hours)) + ":" +
            (minutes < 10 ? "0" + String(minutes): String(minutes))
    }
}


// MARK: - TablePresentationLogic implementation
extension TablePresenter: TablePresentationLogic {
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

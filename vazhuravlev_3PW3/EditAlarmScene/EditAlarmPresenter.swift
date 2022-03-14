//
//  EditAlarmPresenter.swift
//  vazhuravlev_3PW3
//
//  Created by Валерий Журавлев on 14.03.2022.
//

import Foundation


protocol EditAlarmPresentationLogic: AnyObject {
    func present(alarm: AlarmModel)                 // Presents given alarm.
}


class EditAlarmPresenter {
    public weak var view: EditAlarmDisplayLogic!
}


// MARK: - EditAlarmPresentationLogic implementation
extension EditAlarmPresenter: EditAlarmPresentationLogic {
    func present(alarm: AlarmModel) {
        view.displayAlarm(
            hours: alarm.getHours(),
            minutes: alarm.getMinutes()
        )
    }
}

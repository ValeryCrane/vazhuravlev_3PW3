//
//  StackViewPresenter.swift
//  vazhuravlev_3PW3
//
//  Created by Валерий Журавлев on 13.03.2022.
//

import Foundation

class StackViewPresenter: StackViewPresentationLogic {
    public weak var view: StackViewDisplayLogic!
    
    func presentUpdatedAlarms(alarms: [AlarmModel]) {
        view.displayUpdatedAlarms(alarms: alarms)
    }
}

protocol StackViewPresentationLogic: AnyObject {
    func presentUpdatedAlarms(alarms: [AlarmModel]) // Presents fetched alarms.
}

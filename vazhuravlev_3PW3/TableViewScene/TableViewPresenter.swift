//
//  TableViewPresenter.swift
//  vazhuravlev_3PW3
//
//  Created by Валерий Журавлев on 14.03.2022.
//

import Foundation

class TableViewPresenter: TableViewPresentationLogic {
    public weak var view: TableViewDisplayLogic!
    
    func presentUpdatedAlarms(alarms: [AlarmModel]) {
        view.displayUpdatedAlarms(alarms: alarms)
    }
}

protocol TableViewPresentationLogic: AnyObject {
    func presentUpdatedAlarms(alarms: [AlarmModel]) // Presents fetched alarms.
}

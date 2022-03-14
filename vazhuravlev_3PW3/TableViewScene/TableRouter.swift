//
//  TableRouter.swift
//  vazhuravlev_3PW3
//
//  Created by Валерий Журавлев on 14.03.2022.
//

import Foundation
import UIKit

protocol TableRoutingLogic {
    func routeToEditAlarmScene(alarmId: UUID)   // Opens editor for alarm with given id.
}

class TableRouter {
    public weak var view: UIViewController!
}

// MARK: - TableRoutingLogic implementation
extension TableRouter: TableRoutingLogic {
    func routeToEditAlarmScene(alarmId: UUID) {
        let editor = EditAlarmAssembly().assemble(alarmId: alarmId)
        self.view.navigationController?.pushViewController(editor, animated: true)
    }
}

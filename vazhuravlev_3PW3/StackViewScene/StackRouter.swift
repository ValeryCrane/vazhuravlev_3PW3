//
//  StackRouter.swift
//  vazhuravlev_3PW3
//
//  Created by Валерий Журавлев on 14.03.2022.
//

import Foundation
import UIKit

protocol StackRoutingLogic {
    func routeToEditAlarmScene(alarmId: UUID)   // Opens editor for alarm with given id.
}

class StackRouter {
    public weak var view: UIViewController!
}


// MARK: - StackRoutingLogic implementation
extension StackRouter: StackRoutingLogic {
    func routeToEditAlarmScene(alarmId: UUID) {
        let editView = EditAlarmAssembly().assemble(alarmId: alarmId)
        view.navigationController?.pushViewController(editView, animated: true)
    }
}

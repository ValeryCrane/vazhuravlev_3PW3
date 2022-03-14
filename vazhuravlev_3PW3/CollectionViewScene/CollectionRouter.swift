//
//  CollectionRouter.swift
//  vazhuravlev_3PW3
//
//  Created by Валерий Журавлев on 15.03.2022.
//

import Foundation
import UIKit

protocol CollectionRoutingLogic: AnyObject {
    func routeToEditAlarmScene(alarmId: UUID)   // Opens editor for alarm with given id.
}

class CollectionRouter {
    public weak var view: UIViewController!
}

// MARK: - CollectionRoutingLogic implementation
extension CollectionRouter: CollectionRoutingLogic {
    func routeToEditAlarmScene(alarmId: UUID) {
        let editView = EditAlarmAssembly().assemble(alarmId: alarmId)
        view.navigationController?.pushViewController(editView, animated: true)
    }
}

//
//  AlarmTabBarRouter.swift
//  vazhuravlev_3PW3
//
//  Created by Валерий Журавлев on 14.03.2022.
//

import Foundation
import UIKit

protocol AlarmTabBarRoutingLogic {
    func openCreateAlarmView()
}


class AlarmTabBarRouter {
    public weak var view: UIViewController!
}


// MARK: - AlarmTabBarRoutingLogic implementation
extension AlarmTabBarRouter: AlarmTabBarRoutingLogic {
    func openCreateAlarmView() {
        let createAlarmView = CreateAlarmAssembly().assemble()
        view.navigationController?.pushViewController(createAlarmView, animated: true)
    }
}

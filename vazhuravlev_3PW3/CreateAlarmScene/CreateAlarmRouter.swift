//
//  CreateAlarmRouter.swift
//  vazhuravlev_3PW3
//
//  Created by Валерий Журавлев on 14.03.2022.
//

import Foundation
import UIKit


protocol CreateAlarmRoutingLogic {
    func closeView()                // Closes CreateAlarmScene
}

class CreateAlarmRouter {
    public weak var view: UIViewController!
}


// MARK: - CreateAlarmRoutingLogic implementation
extension CreateAlarmRouter: CreateAlarmRoutingLogic {
    func closeView() {
        view.navigationController?.popViewController(animated: true)
    }
}


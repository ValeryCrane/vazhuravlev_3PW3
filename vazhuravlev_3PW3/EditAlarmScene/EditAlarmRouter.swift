//
//  EditAlarmRouter.swift
//  vazhuravlev_3PW3
//
//  Created by Валерий Журавлев on 14.03.2022.
//

import Foundation
import UIKit

protocol EditAlarmRoutingLogic: AnyObject {
    func closeView()                                // Closes EditAlarmScene
}

protocol EditAlarmDataPassing: AnyObject {
    var dataStore: EditAlarmDataStore! { get }      // Serves as link to Interactor by protocol.
}


class EditAlarmRouter: EditAlarmDataPassing {
    public weak var dataStore: EditAlarmDataStore!
    public weak var view: UIViewController!
}

extension EditAlarmRouter: EditAlarmRoutingLogic {
    func closeView() {
        view.navigationController?.popViewController(animated: true)
    }
}

//
//  EditAlarmAssembly.swift
//  vazhuravlev_3PW3
//
//  Created by Валерий Журавлев on 14.03.2022.
//

import Foundation
import UIKit

// Class, which assembles EditAlarmScene by alarmId and gives resulting viewController.
class EditAlarmAssembly {
    func assemble(alarmId: UUID) -> UIViewController {
        let view = EditAlarmViewController()
        let interactor = EditAlarmInteractor()
        let presenter = EditAlarmPresenter()
        let router = EditAlarmRouter()
        
        // Creating links.
        view.interactor = interactor
        view.router = router
        interactor.presenter = presenter
        presenter.view = view
        router.view = view
        router.dataStore = interactor
        
        // Passing data.
        router.dataStore.alarmId = alarmId
        
        return view
    }
}

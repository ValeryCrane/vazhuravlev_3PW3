//
//  CreateAlarmAssembly.swift
//  vazhuravlev_3PW3
//
//  Created by Валерий Журавлев on 14.03.2022.
//

import Foundation
import UIKit

// Class, which assembles CreateAlarmScene and gives resulting viewController.
class CreateAlarmAssembly {
    func assemble() -> UIViewController {
        let view = CreateAlarmViewController()
        let interactor = CreateAlarmInteractor()
        let router = CreateAlarmRouter()
        
        view.interactor = interactor
        view.router = router
        router.view = view
        
        return view
    }
}

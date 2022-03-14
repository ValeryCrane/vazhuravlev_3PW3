//
//  StackAssembly.swift
//  vazhuravlev_3PW3
//
//  Created by Валерий Журавлев on 13.03.2022.
//

import Foundation
import UIKit

// Class, which assembles StackViewScene and gives resulting viewController.
class StackAssembly {
    func assemble() -> UIViewController {
        let view = StackViewController()
        let presenter = StackPresenter()
        let interactor = StackInteractor()
        let router = StackRouter()
        
        view.interactor = interactor
        view.router = router
        router.view = view
        interactor.presenter = presenter
        presenter.view = view
        
        return view
    }
}

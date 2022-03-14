//
//  TableAssembly.swift
//  vazhuravlev_3PW3
//
//  Created by Валерий Журавлев on 14.03.2022.
//

import Foundation
import UIKit

// Class, which assembles TableViewScene and gives resulting viewController.
class TableAssembly {
    func assemble() -> UIViewController {
        let view = TableViewController()
        let presenter = TablePresenter()
        let interactor = TableInteractor()
        let router = TableRouter()
        
        view.interactor = interactor
        view.router = router
        interactor.presenter = presenter
        presenter.view = view
        router.view = view
        
        return view
    }
}

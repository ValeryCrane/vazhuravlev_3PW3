//
//  TableViewAssembly.swift
//  vazhuravlev_3PW3
//
//  Created by Валерий Журавлев on 14.03.2022.
//

import Foundation
import UIKit

// Class, which assembles TableViewScene and gives resulting viewController.
class TableViewAssembly {
    private static weak var view: UIViewController?
    
    func assemble() -> UIViewController {
        if let view = TableViewAssembly.view { return view }
        let view = TableViewController()
        let presenter = TableViewPresenter()
        let interactor = TableViewInteractor()
        
        view.interactor = interactor
        interactor.presenter = presenter
        presenter.view = view
        
        TableViewAssembly.view = view
        return view
    }
}

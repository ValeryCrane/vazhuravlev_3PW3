//
//  StackViewAssembly.swift
//  vazhuravlev_3PW3
//
//  Created by Валерий Журавлев on 13.03.2022.
//

import Foundation
import UIKit

// Class, which assembles StackViewScene and gives resulting viewController.
class StackViewAssembly {
    private static weak var view: UIViewController?
    
    func assemble() -> UIViewController {
        if let view = StackViewAssembly.view { return view }
        let view = StackViewController()
        let presenter = StackViewPresenter()
        let interactor = StackViewInteractor()
        
        view.interactor = interactor
        interactor.presenter = presenter
        presenter.view = view
        
        StackViewAssembly.view = view
        return view
    }
}

//
//  CollectionViewAssembly.swift
//  vazhuravlev_3PW3
//
//  Created by Валерий Журавлев on 14.03.2022.
//

import Foundation
import UIKit

// Class, which assembles CollectionViewScene and gives resulting viewController.
class CollectionViewAssembly {
    private static weak var view: UIViewController?
    
    func assemble() -> UIViewController {
        if let view = CollectionViewAssembly.view { return view }
        let view = CollectionViewController()
        let interactor = CollectionViewInteractor()
        let presenter = CollectionViewPresenter()
        
        view.interactor = interactor
        interactor.presenter = presenter
        presenter.view = view
        
        CollectionViewAssembly.view = view
        return view
    }
}

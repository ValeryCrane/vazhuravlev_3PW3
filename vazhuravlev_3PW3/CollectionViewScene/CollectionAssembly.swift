//
//  CollectionAssembly.swift
//  vazhuravlev_3PW3
//
//  Created by Валерий Журавлев on 14.03.2022.
//

import Foundation
import UIKit

// Class, which assembles CollectionViewScene and gives resulting viewController.
class CollectionAssembly {
    func assemble() -> UIViewController {
        let view = CollectionViewController()
        let interactor = CollectionInteractor()
        let presenter = CollectionPresenter()
        let router = CollectionRouter()
        
        view.interactor = interactor
        view.router = router
        router.view = view
        interactor.presenter = presenter
        presenter.view = view
        
        return view
    }
}

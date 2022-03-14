//
//  AlarmTabBarAssembly.swift
//  vazhuravlev_3PW3
//
//  Created by Валерий Журавлев on 14.03.2022.
//

import Foundation
import UIKit

class AlarmTabBarAssembly {
    private static var view: UITabBarController?
    
    func assemble() -> UITabBarController {
        if let view = AlarmTabBarAssembly.view { return view }
        let view = AlarmTabBarViewController()
        let router = AlarmTabBarRouter()
        
        view.router = router
        router.view = view
        
        AlarmTabBarAssembly.view = view
        return view
    }
}

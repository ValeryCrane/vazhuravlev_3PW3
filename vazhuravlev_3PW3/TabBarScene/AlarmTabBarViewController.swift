//
//  AlarmTabBarViewController.swift
//  vazhuravlev_3PW3
//
//  Created by Валерий Журавлев on 14.03.2022.
//

import Foundation
import UIKit

class AlarmTabBarViewController: UITabBarController {
    public var router: AlarmTabBarRoutingLogic!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Alarms"
        setupNavigationBar()
    }
    
    // Creating '+' button for adding an alarm
    private func setupNavigationBar() {
        navigationItem.rightBarButtonItem =
            UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(self.openCreateAlarmView))
    }
    
    @objc private func openCreateAlarmView() {
        router.openCreateAlarmView()
    }
}

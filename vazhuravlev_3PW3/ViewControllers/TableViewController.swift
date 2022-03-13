//
//  TableViewController.swift
//  vazhuravlev_3PW3
//
//  Created by Валерий Журавлев on 13.03.2022.
//

import Foundation
import UIKit

class TableViewController: UIViewController {
    private var table: UITableView?
        
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .gray
        setupTableView()
    }
        
    private func setupTableView() {
        let table = UITableView()
        table.backgroundColor = .white
        self.view.addSubview(table)
        table.pinTop(to: self.view.safeAreaLayoutGuide.topAnchor)
        table.pinBottom(to: self.view.safeAreaLayoutGuide.bottomAnchor)
        table.pin(to: self.view, .left, .right)
    }
}

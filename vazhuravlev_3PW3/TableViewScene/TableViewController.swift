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
        table.register(EyeCell.self, forCellReuseIdentifier: "eyeCell")
        table.delegate = self
        table.dataSource = self
        table.backgroundColor = .white
        self.view.addSubview(table)
        table.pinTop(to: self.view.safeAreaLayoutGuide.topAnchor)
        table.pinBottom(to: self.view.safeAreaLayoutGuide.bottomAnchor)
        table.pin(to: self.view, .left, .right)
    }
}

extension TableViewController: UITableViewDelegate {}

extension TableViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        300
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(
            withIdentifier: "eyeCell", for: indexPath) as? EyeCell
        cell?.setupEye()
        return cell ?? UITableViewCell()
    }
    
}

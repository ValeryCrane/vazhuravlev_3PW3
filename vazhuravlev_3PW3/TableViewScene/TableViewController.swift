//
//  TableViewController.swift
//  vazhuravlev_3PW3
//
//  Created by Валерий Журавлев on 13.03.2022.
//

import Foundation
import UIKit

class TableViewController: UIViewController, TableViewDisplayLogic {
    private var table: UITableView?
    private var currentAlarms: [AlarmModel] = []
    public var interactor: TableViewBusinessLogic!
        
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .gray
        setupTableView()
        interactor.fetchAlarms()
        table?.reloadData()
    }
        
    private func setupTableView() {
        let table = UITableView()
        table.register(TableAlarmView.self, forCellReuseIdentifier: TableAlarmView.reuseIdentifier)
        table.delegate = self
        table.dataSource = self
        table.backgroundColor = .white
        self.view.addSubview(table)
        table.pinTop(to: self.view.safeAreaLayoutGuide.topAnchor)
        table.pinBottom(to: self.view.safeAreaLayoutGuide.bottomAnchor)
        table.pin(to: self.view, .left, .right)
        self.table = table
    }
    
    func displayUpdatedAlarms(alarms: [AlarmModel]) {
        self.currentAlarms = alarms
        self.table?.reloadData()
    }
}

extension TableViewController: UITableViewDelegate {}

extension TableViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.currentAlarms.count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(
            withIdentifier: TableAlarmView.reuseIdentifier, for: indexPath) as? TableAlarmView
        cell?.loadFrom(alarmModel: self.currentAlarms[indexPath.row])
        return cell ?? UITableViewCell()
    }
}

protocol TableViewDisplayLogic: AnyObject {
    func displayUpdatedAlarms(alarms: [AlarmModel]) // Displays alarm data recieved from presenter.
}

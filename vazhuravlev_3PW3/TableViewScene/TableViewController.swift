//
//  TableViewController.swift
//  vazhuravlev_3PW3
//
//  Created by Валерий Журавлев on 13.03.2022.
//

import Foundation
import UIKit

protocol TableDisplayLogic: AnyObject {
    func displayUpdatedAlarms(alarms: [TextAlarmModel]) // Displays alarm data recieved from presenter.
}

class TableViewController: UIViewController {
    public var interactor: TableBusinessLogic!
    public var router: TableRoutingLogic!
    
    private var table: UITableView?
    private var currentAlarms: [TextAlarmModel] = []
        
    // MARK: - ViewController's life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
    }
    
    // When view apperars we update alarms.
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        interactor.fetchAlarms()
    }
        
    // MARK: - Setup functions
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
}


// MARK: - UITableViewDelegate & DataSource implementation
extension TableViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        router.routeToEditAlarmScene(alarmId: currentAlarms[indexPath.row].id)
        tableView.deselectRow(at: indexPath, animated: false)
    }
}

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
        cell?.loadFrom(alarm: self.currentAlarms[indexPath.row])
        cell?.delegate = self
        return cell ?? UITableViewCell()
    }
}


// MARK: - TableDisplayLogic implementation
extension TableViewController: TableDisplayLogic {
    func displayUpdatedAlarms(alarms: [TextAlarmModel]) {
        self.currentAlarms = alarms
        self.table?.reloadData()
    }
}


// MARK: - TableAlarmViewDelegate implementation
extension TableViewController: TableAlarmViewDelegate {
    func processSwitchActionFrom(id: UUID, with activity: Bool) {
        self.interactor.changeActivityIndicatorAt(id: id, with: activity)
    }
}

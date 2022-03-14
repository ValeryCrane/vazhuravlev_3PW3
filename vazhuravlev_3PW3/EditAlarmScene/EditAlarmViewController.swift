//
//  EditAlarmViewController.swift
//  vazhuravlev_3PW3
//
//  Created by Валерий Журавлев on 14.03.2022.
//

import Foundation
import UIKit


protocol EditAlarmDisplayLogic: AnyObject {
    func displayAlarm(hours: Int, minutes: Int) // Displays fetched alarm in picker view.
}

class EditAlarmViewController: UIViewController {
    public var interactor: EditAlarmBusinessLogic!
    public var router: EditAlarmRoutingLogic!
    
    private var timePicker: UIPickerView?
    
    // MARK: - ViewController's life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        self.title = "Edit"
        setupTimePicker()
        setupNavigationBar()
    }
    
    // MARK: - Setup functions
    private func setupTimePicker() {
        let timePicker = UIPickerView()
        timePicker.dataSource = self
        timePicker.delegate = self
        self.view.addSubview(timePicker)
        timePicker.pinCenter(to: self.view)
        timePicker.pinHeight(to: self.view.heightAnchor, 0.3)
        timePicker.pinWidth(to: self.view.widthAnchor, 0.8)
        self.timePicker = timePicker
        interactor.fetchAlarm()
    }
    
    private func setupNavigationBar() {
        navigationItem.leftBarButtonItem =
            UIBarButtonItem(title: "Close", style: .plain, target: self, action: #selector(self.closeView))
        navigationItem.rightBarButtonItem =
            UIBarButtonItem(title: "Save", style: .done, target: self, action: #selector(self.addAlarm))
    }
    
    // Asks interactor to add alarm amd closes view.
    @objc private func addAlarm() {
        if let timePicker = self.timePicker {
            interactor.editAlarm(
                hours: timePicker.selectedRow(inComponent: 0),
                minutes: timePicker.selectedRow(inComponent: 1)
            )
            router.closeView()
        }
    }
    
    // Closes edit view.
    @objc private func closeView() {
        router.closeView()
    }
}


// MARK: - UIPickerViewDelegate & DataSource implementation
extension EditAlarmViewController: UIPickerViewDelegate {
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if (row < 10) {
            return "0" + String(row)
        }
        return String(row)
    }
    
    func pickerView(_ pickerView: UIPickerView, widthForComponent component: Int) -> CGFloat {
        return 70
    }
}

extension EditAlarmViewController: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        2
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        component == 0 ? 24 : 60
    }
}


// MARK: - EditAlarmDisplayLogic implementation
extension EditAlarmViewController: EditAlarmDisplayLogic {
    func displayAlarm(hours: Int, minutes: Int) {
        guard hours >= 0, hours < 24, minutes >= 0, minutes < 60 else { return }
        self.timePicker?.selectRow(hours, inComponent: 0, animated: true)
        self.timePicker?.selectRow(minutes, inComponent: 1, animated: true)
    }
}

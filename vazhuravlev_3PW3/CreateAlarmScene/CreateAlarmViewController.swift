//
//  CreateAlarmViewController.swift
//  vazhuravlev_3PW3
//
//  Created by Валерий Журавлев on 14.03.2022.
//

import Foundation
import UIKit

class CreateAlarmViewController: UIViewController {
    public var interactor: CreateAlarmBusinessLogic!
    public var router: CreateAlarmRoutingLogic!
    private var timePicker: UIPickerView?
    
    // MARK: - ViewController's life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Add alarm"
        self.view.backgroundColor = .white
        self.setupTimePicker()
        self.setupNavigationBar()
    }
    
    // MARK: - Setup functions.
    private func setupTimePicker() {
        let timePicker = UIPickerView()
        timePicker.dataSource = self
        timePicker.delegate = self
        self.view.addSubview(timePicker)
        timePicker.pinCenter(to: self.view)
        timePicker.pinHeight(to: self.view.heightAnchor, 0.3)
        timePicker.pinWidth(to: self.view.widthAnchor, 0.8)
        self.timePicker = timePicker
    }
    
    private func setupNavigationBar() {
        navigationItem.leftBarButtonItem =
            UIBarButtonItem(title: "Close", style: .plain, target: self, action: #selector(self.closeView))
        navigationItem.rightBarButtonItem =
            UIBarButtonItem(title: "Save", style: .done, target: self, action: #selector(self.addAlarm))
    }
    
    // Adds alarm via interactor and closes view via router.
    @objc private func addAlarm() {
        if let timePicker = self.timePicker {
            interactor.addAlarm(
                hours: timePicker.selectedRow(inComponent: 0),
                minutes: timePicker.selectedRow(inComponent: 1)
            )
            router.closeView()
        }
    }
    
    // Closes view without any change.
    @objc private func closeView() {
        router.closeView()
    }
}


// MARK: - UIPickerViewDelegate & DataSource implementation
extension CreateAlarmViewController: UIPickerViewDelegate {
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

extension CreateAlarmViewController: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        2
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        component == 0 ? 24 : 60
    }
}

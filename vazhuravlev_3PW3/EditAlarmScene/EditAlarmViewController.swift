//
//  EditAlarmViewController.swift
//  vazhuravlev_3PW3
//
//  Created by Валерий Журавлев on 14.03.2022.
//

import Foundation
import UIKit


protocol EditAlarmDisplayLogic: AnyObject {
    func displayAlarm(hours: Int, minutes: Int, sound: AlarmSound)     // Displays fetched alarm in picker view.
}

class EditAlarmViewController: UIViewController {
    private static let sounds = ["Студент", "Радио", "Москва"]
    
    public var interactor: EditAlarmBusinessLogic!
    public var router: EditAlarmRoutingLogic!
    
    private var timePicker: UIPickerView?
    private var deleteButton: UIButton?
    
    // MARK: - ViewController's life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        self.title = "Edit"
        setupTimePicker()
        setupNavigationBar()
        setupDeleteButton()
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
        navigationItem.rightBarButtonItem =
            UIBarButtonItem(title: "Save", style: .done, target: self, action: #selector(self.addAlarm))
    }
    
    private func setupDeleteButton() {
        let deleteButton = UIButton()
        deleteButton.setTitle("Delete", for: .normal)
        deleteButton.setTitleColor(.systemRed, for: .normal)
        deleteButton.titleLabel?.font = .systemFont(ofSize: 24, weight: .light)
        deleteButton.addTarget(self, action: #selector(removeAlarm), for: .touchUpInside)
        view.addSubview(deleteButton)
        deleteButton.pinBottom(to: view.safeAreaLayoutGuide.bottomAnchor)
        deleteButton.pin(to: view, .left, .right)
        self.deleteButton = deleteButton
    }
    
    // Asks interactor to add alarm amd closes view.
    @objc private func addAlarm() {
        if let timePicker = self.timePicker {
            interactor.editAlarm(
                hours: timePicker.selectedRow(inComponent: 0),
                minutes: timePicker.selectedRow(inComponent: 1),
                sound: timePicker.selectedRow(inComponent: 2)
            )
            router.closeView()
        }
    }
    
    // Asks interactor to remove alarm amd closes view.
    @objc private func removeAlarm() {
        interactor.removeAlarm()
        router.closeView()
    }
    
    // Closes edit view.
    @objc private func closeView() {
        router.closeView()
    }
}


// MARK: - UIPickerViewDelegate & DataSource implementation
extension EditAlarmViewController: UIPickerViewDelegate {
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if component == 0 || component == 1 {
            if row < 10 {
                return "0" + String(row)
            }
            return String(row)
        }
        return Self.sounds[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, widthForComponent component: Int) -> CGFloat {
        if component == 0 || component == 1 {
            return 70
        }
        return 150
    }
}

extension EditAlarmViewController: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        3
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        switch component {
        case 0: return 24
        case 1: return 60
        case 2: return Self.sounds.count
        default: return 0
        }
    }
}


// MARK: - EditAlarmDisplayLogic implementation
extension EditAlarmViewController: EditAlarmDisplayLogic {
    func displayAlarm(hours: Int, minutes: Int, sound: AlarmSound) {
        guard hours >= 0, hours < 24, minutes >= 0, minutes < 60 else { return }
        self.timePicker?.selectRow(hours, inComponent: 0, animated: true)
        self.timePicker?.selectRow(minutes, inComponent: 1, animated: true)
        self.timePicker?.selectRow(sound.rawValue, inComponent: 2, animated: true)
    }
}

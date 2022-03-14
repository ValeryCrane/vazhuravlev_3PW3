//
//  StackViewController.swift
//  vazhuravlev_3PW3
//
//  Created by Валерий Журавлев on 13.03.2022.
//

import Foundation
import UIKit

protocol StackDisplayLogic: AnyObject {
    func displayUpdatedAlarms(alarms: [TextAlarmModel]) // Displays alarm data recieved from presenter.
}

class StackViewController: UIViewController {
    public var interactor: StackBusinessLogic!
    public var router: StackRoutingLogic!
    
    private var scroll: UIScrollView?
    private var stack: UIStackView?
    
    // MARK: - ViewController's life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupStackView()
    }
    
    // When view apperars we update alarms.
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        interactor.fetchAlarms()
    }
    
    // Adjusting scroll view content size.
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if let scroll = self.scroll,
            let stack = self.stack {
            scroll.contentSize = CGSize(width: scroll.frame.width, height: stack.frame.height)
        }
    }
        
    // MARK: - Setup functions
    // Function creates scroll view and puts stack view in it.
    private func setupStackView() {
        let scroll = UIScrollView()
        scroll.backgroundColor = .white
        scroll.alwaysBounceVertical = true
        self.view.addSubview(scroll)
        scroll.pinTop(to: self.view.safeAreaLayoutGuide.topAnchor)
        scroll.pinBottom(to: self.view.safeAreaLayoutGuide.bottomAnchor)
        scroll.pin(to: self.view, .left, .right)
        
        let stack = UIStackView()
        stack.axis = .vertical
        scroll.addSubview(stack)
        stack.pinTop(to: scroll.contentLayoutGuide.topAnchor)
        stack.pinLeft(to: scroll.contentLayoutGuide.leadingAnchor)
        stack.pinWidth(to: scroll.widthAnchor)
        
        self.scroll = scroll
        self.stack = stack
    }

}

// MARK: - StackDisplayLogic implementation
extension StackViewController: StackDisplayLogic {
    func displayUpdatedAlarms(alarms: [TextAlarmModel]) {
        if let subviews = self.stack?.arrangedSubviews {
            for view in subviews {
                view.removeFromSuperview()
            }
        }
        for alarm in alarms {
            let alarmView = StackAlarmView(alarm: alarm)
            alarmView.delegate = self
            self.stack?.addArrangedSubview(alarmView)
        }
    }
}


// MARK: - StackAlarmViewDelegate implementation
extension StackViewController: StackAlarmViewDelegate {
    func processSwitchActionFrom(id: UUID, with activity: Bool) {
        self.interactor.changeActivityIndicatorAt(id: id, with: activity)
    }
    
    func processTapOnAlarmWith(id: UUID) {
        self.router.routeToEditAlarmScene(alarmId: id)
    }
}


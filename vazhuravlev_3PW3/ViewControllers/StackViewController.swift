//
//  StackViewController.swift
//  vazhuravlev_3PW3
//
//  Created by Валерий Журавлев on 13.03.2022.
//

import Foundation
import UIKit

class StackViewController: UIViewController {
    private var scroll: UIScrollView?
    private var stack: UIStackView?
        
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .lightGray
        setupStackView()
    }
        
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        // Adjusting scroll view content size.
        if let scroll = self.scroll,
            let stack = self.stack {
            scroll.contentSize = CGSize(width: scroll.frame.width, height: stack.frame.height)
        }
    }
        
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
        stack.pin(to: scroll, .top, .left, .right, .bottom)
        
        self.scroll = scroll
        self.stack = stack
    }
}

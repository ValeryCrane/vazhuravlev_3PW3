//
//  EyeCell.swift
//  vazhuravlev_3PW3
//
//  Created by Валерий Журавлев on 14.03.2022.
//

import Foundation
import UIKit

final class EyeCell: UITableViewCell {
    func setupEye() {
        self.setHeight(to: 50)
        let image = UIImageView()
        image.image = UIImage(named: "eye")
        self.addSubview(image)
        image.pinLeft(to: self, Double.random(in: 0...400))
        image.pinTop(to: self, Double.random(in: -20...40))
        image.setHeight(to: 20)
        image.setWidth(to: 30)
    }
}

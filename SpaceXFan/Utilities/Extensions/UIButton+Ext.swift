//
//  UIButton+Ext.swift
//  SpaceXFan
//
//  Created by Adem Kaya
//

import UIKit

extension UIButton {
    func forceImageToRightSide() {
        let newTransform = CGAffineTransform(scaleX: -1.0, y: 1.0)
        transform = newTransform
        titleLabel?.transform = newTransform
        imageView?.transform = newTransform
    }
}

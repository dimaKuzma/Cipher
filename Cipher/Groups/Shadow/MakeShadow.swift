//
//  MakeShadow.swift
//  Cipher
//
//  Created by Дмитрий on 5/13/21.
//  Copyright © 2021 DK. All rights reserved.
//

import UIKit

extension UIView {
    // - Make shadow for UI Element
    func makeShadow() {
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowRadius = 7.0
        layer.shadowOpacity = 0.7
        layer.shadowOffset = CGSize(width: 2.5, height: 2.5)
        clipsToBounds = false
        layer.masksToBounds = false
    }
}

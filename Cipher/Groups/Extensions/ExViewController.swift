//
//  ExtensionViewController.swift
//  Cipher
//
//  Created by Дмитрий on 5/14/21.
//  Copyright © 2021 DK. All rights reserved.
//

import UIKit

extension UIViewController {
    // setup background image
    func setupBackground(containerView: UIView, image: String) {
        let shadowView = ShadowView()
        containerView.addSubview(shadowView)
        shadowView.image = UIImage(named: image)
        shadowView.cornerRadius = 0.0
        shadowView.translatesAutoresizingMaskIntoConstraints = false
        shadowView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor).isActive = true
        shadowView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor).isActive = true
        shadowView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        shadowView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor).isActive = true
    }
    
    // Configure now date
    func configureDate() -> String {
        let date = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd.MM.YY HH:mm"
        let fullDate = dateFormatter.string(from: date)
        return fullDate
    }
}

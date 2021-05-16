//
//  MainTableViewCell.swift
//  Cipher
//
//  Created by Дмитрий on 5/13/21.
//  Copyright © 2021 DK. All rights reserved.
//

import UIKit

class MainTableViewCell: UITableViewCell {
    // - UI
    @IBOutlet weak var mainLabel: UILabel!
    @IBOutlet weak var containerView: UIView!
    private let shadowView = ShadowView()
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        mainLabel.makeShadow()
    }
    
    func setup(image: UIImage, text: String) {
        containerView.addSubview(shadowView)
        shadowView.image = image
        shadowView.translatesAutoresizingMaskIntoConstraints = false
        shadowView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor).isActive = true
        shadowView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor).isActive = true
        shadowView.topAnchor.constraint(equalTo: containerView.topAnchor).isActive = true
        shadowView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor).isActive = true
        mainLabel.text = text
    }
}

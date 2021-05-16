//
//  ShadowView.swift
//  Cipher
//
//  Created by Дмитрий on 5/13/21.
//  Copyright © 2021 DK. All rights reserved.
//

import UIKit

class ShadowView: UIView {
    var image: UIImage? {
        didSet {
            imageView.image = image
        }
    }
    
    var cornerRadius: CGFloat = 10.0 {
        didSet {
            imageView.layer.cornerRadius = cornerRadius
        }
    }
    
    var shadowColor: UIColor = .black {
        didSet {
            layer.shadowColor = shadowColor.cgColor
        }
    }
    
    var shadowOpacity: Float = 0.7 {
        didSet {
            layer.shadowOpacity = shadowOpacity
        }
    }
    
    var shadowOffset = CGSize(width: 2.5, height: 2.5) {
        didSet {
            layer.shadowOffset = shadowOffset
        }
    }
    
    var shadowRadius: CGFloat = 7.0 {
        didSet {
            layer.shadowRadius = shadowRadius
        }
    }
    
    private let imageView = UIImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        setupShadow()
    }
    
    private func setupShadow() {
        layer.shadowColor = shadowColor.cgColor
        layer.shadowRadius = shadowRadius
        layer.shadowOpacity = shadowOpacity
        layer.shadowOffset = shadowOffset
        
        let cgPath = UIBezierPath(roundedRect: bounds, byRoundingCorners: [.allCorners], cornerRadii: CGSize(width: cornerRadius, height: cornerRadius)).cgPath
        layer.shadowPath = cgPath
    }
    
    private func setup() {
        addSubview(imageView)
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        imageView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        imageView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        imageView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        imageView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        
        imageView.layer.cornerRadius = cornerRadius
        imageView.clipsToBounds = true
    }
}

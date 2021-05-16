//
//  TableViewCell.swift
//  Cipher
//
//  Created by Дмитрий on 5/12/21.
//  Copyright © 2021 DK. All rights reserved.
//

import UIKit

class EncryptTableViewCell: UITableViewCell {
    // - UI
    @IBOutlet weak var originalLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var keyLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        originalLabel.makeShadow()
        keyLabel.makeShadow()
    }
    

}

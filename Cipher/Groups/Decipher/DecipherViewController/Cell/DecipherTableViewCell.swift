//
//  DecipherTableViewCell.swift
//  Cipher
//
//  Created by Дмитрий on 5/13/21.
//  Copyright © 2021 DK. All rights reserved.
//

import UIKit

class DecipherTableViewCell: UITableViewCell {
    // - UI
    @IBOutlet weak var cipherLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var keyLabel: UILabel!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        cipherLabel.makeShadow()
        keyLabel.makeShadow()
    }

}

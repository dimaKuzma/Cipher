//
//  Translation.swift
//  Cipher
//
//  Created by Дмитрий on 5/12/21.
//  Copyright © 2021 DK. All rights reserved.
//

import UIKit
import RealmSwift

class Translation: Object {
    @objc dynamic var original: String!
    @objc dynamic var cipher: String!
    @objc dynamic var key = 0
    @objc dynamic var date: String!
}

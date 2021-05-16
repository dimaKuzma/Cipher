//
//  CipherViewController.swift
//  Cipher
//
//  Created by Дмитрий on 5/13/21.
//  Copyright © 2021 DK. All rights reserved.
//

import UIKit
import RealmSwift

class CipherViewController: UIViewController {
    // - UI
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var textLabel: UILabel!
    @IBOutlet weak var stepper: UIStepper!
    @IBOutlet weak var keyLabel: UILabel!
    @IBOutlet weak var decipherButton: UIButton!
    @IBOutlet weak var discriptionTextViewLabel: UILabel!
    @IBOutlet weak var discriptionKeyLabel: UILabel!
    @IBOutlet weak var discriptionTextLabel: UILabel!
    
    // - Data
    var key:Int!  = 0
    
    // - Realm
    let realm = try! Realm()
    
    // - ViewController
    weak var decipherVC: DecipherViewController!
    
    // - Constraints
    @IBOutlet weak var widthDecipherButtonConstraint: NSLayoutConstraint!
    
    // - DataForSelectedCell
    var original = ""
    var cipher = ""
    var cell = false
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
    
    @IBAction func decipherButtonAction(_ sender: Any) {
        if let message = textView.text {
            decipher(messageToDecipher: message, key: key)
        }
    }
    
    @IBAction func stepperAction(_ sender: Any) {
        let key = Int(stepper.value)
        if key < 1 {
            keyLabel.text = "\(key)"
        } else {
            keyLabel.text = "+\(key)"
        }
        self.key = key
    }
}

// MARK: -
// MARK: Configure
extension CipherViewController {
    func configure() {
        setupBackground(containerView: containerView, image: "background")
        setupShadow()
        configureConstraint()
        if cell {
            configureDataFromCell()
            cell = false
        } else {
            configureSaveButton()
        }
    }
    
    func setupShadow() {
        keyLabel.makeShadow()
        stepper.makeShadow()
        textLabel.makeShadow()
        decipherButton.makeShadow()
        textView.makeShadow()
        discriptionKeyLabel.makeShadow()
        discriptionTextLabel.makeShadow()
        discriptionTextViewLabel.makeShadow()
    }
    
    func configureConstraint() {
        widthDecipherButtonConstraint.constant = decipherButton.frame.height
    }
    
    func addToRealm(original: String, cipherr: String, key: Int, date: String){
        let cipher = Cipher()
        cipher.original = original
        cipher.cipher = cipherr
        cipher.key = key
        cipher.date = date
        try! realm.write {
            realm.add(cipher)
        }
    }
    
    func configureDataFromCell() {
        textView.text = cipher
        textLabel.text = original
        if let key = key {
            if key != 0 {
                keyLabel.text = "+\(key)"
            } else {
                keyLabel.text = "\(key)"
            }
        }
    }
    
    func configureSaveButton() {
        let rightButton = UIBarButtonItem.init(image: UIImage(named: "save"), style: .done, target: self, action: #selector(self.handleTap(_:)))
        let backButton = UIBarButtonItem()
        backButton.tintColor = .white
        self.navigationItem.rightBarButtonItem = rightButton
        self.navigationItem.rightBarButtonItem?.tintColor = .white
        self.navigationItem.backBarButtonItem = backButton
    }
    
    @objc func handleTap(_ sender: UITapGestureRecognizer) {
        if let cipher = textView.text, let original = textLabel.text {
            addToRealm(original: original, cipherr: cipher, key: key, date: configureDate())
            decipherVC.configure()
            decipherVC.tableView.reloadData()
            navigationController?.popViewController(animated: true)
        }
    }
}

// MARK: -
// MARK: Cipher method
private extension CipherViewController {
    func decipher(messageToDecipher: String, key: Int) {
        var deciphredMessage = ""
        for char in messageToDecipher.unicodeScalars {
            // convert to `Int`
            var unicode = Int(char.value)
            if unicode > 64 && unicode < 123 {
                var modifiedShift = key
                if unicode >= 65 && unicode <= 90 {
                    while unicode + modifiedShift > 90 {
                        //return to A
                        modifiedShift -= 26
                    }
                } else if unicode >= 97 && unicode <= 122 {
                    while unicode + modifiedShift > 122 {
                        //return to a
                        modifiedShift -= 26
                    }
                }
                unicode -= modifiedShift
            } else if unicode > 1039 && unicode < 1104 {
                var modifiedShift = key
                if unicode >= 1040 && unicode <= 1071 {
                    while unicode + modifiedShift > 1071 {
                        //return to A
                        modifiedShift -= 32
                    }
                } else if unicode >= 1072 && unicode <= 1103 {
                    while unicode + modifiedShift > 1103 {
                        //return to a
                        modifiedShift -= 32
                    }
                }
                unicode -= modifiedShift
            }
            deciphredMessage += String(UnicodeScalar(unicode)!)
        }
        textLabel.text = deciphredMessage
    }
}

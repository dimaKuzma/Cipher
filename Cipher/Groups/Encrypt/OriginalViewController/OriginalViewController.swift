//
//  OriginalViewController.swift
//  Cipher
//
//  Created by Дмитрий on 5/12/21.
//  Copyright © 2021 DK. All rights reserved.
//

import UIKit
import RealmSwift

class OriginalViewController: UIViewController {
    // - UI
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var cipherLabel: UILabel!
    @IBOutlet weak var stepper: UIStepper!
    @IBOutlet weak var keyLabel: UILabel!
    @IBOutlet weak var cipherButton: UIButton!
    @IBOutlet weak var discriptionTextViewLabel: UILabel!
    @IBOutlet weak var discriptionKeyLabel: UILabel!
    @IBOutlet weak var discriptionCipherLabel: UILabel!
    
    
    // - Data
    var key = 0
    
    // - Realm
    let realm = try! Realm()
    
    // - Constraints
    @IBOutlet weak var bottomCipherButtonConstraint: NSLayoutConstraint!
    
    // - DataFromCell
    var original = ""
    var cipher = ""
    var cell = false
    
    
    // - ViewController
    weak var encryptVC: EncryptViewController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
    
    @IBAction func cipherButtonAction(_ sender: Any) {
        if let message = textView.text {
            cipher(messageToCipher: message, key: key)
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
private extension OriginalViewController {
    func configure() {
        setupBackground(containerView: containerView, image: "background")
        configureConstraint()
        setupShadow()
        if cell {
            configureDataFromCell()
            cell = false
        } else {
            configureSaveButton()
        }
    }
    
    func configureDataFromCell() {
        textView.text = original
        cipherLabel.text = cipher
            if key != 0 {
                keyLabel.text = "+\(key)"
            } else {
                keyLabel.text = "\(key)"
            }
    }
    
    func setupShadow() {
        keyLabel.makeShadow()
        stepper.makeShadow()
        cipherLabel.makeShadow()
        cipherButton.makeShadow()
        textView.makeShadow()
        discriptionKeyLabel.makeShadow()
        discriptionCipherLabel.makeShadow()
        discriptionTextViewLabel.makeShadow()
        
    }
    
    func configureConstraint() {
        bottomCipherButtonConstraint.constant = cipherButton.frame.height
    }
//    func configureDate() -> String {
//        let date = Date()
//        let dateFormatter = DateFormatter()
//        dateFormatter.dateFormat = "dd.MM.YY HH:mm"
//        let fullDate = dateFormatter.string(from: date)
//        return fullDate
//    }
    
    func addToRealm(original: String, cipher: String, key: Int, date: String){
        let translation = Translation()
        translation.original = original
        translation.cipher = cipher
        translation.key = key
        translation.date = date
        try! realm.write {
            realm.add(translation)
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
        if let original = textView.text, let cipher = cipherLabel.text {
            addToRealm(original: original, cipher: cipher, key: key, date: configureDate())
            encryptVC.configure()
            encryptVC.tableView.reloadData()
            navigationController?.popViewController(animated: true)
        }
    }
}

// MARK: -
// MARK: Cipher method
 private extension OriginalViewController {
    func cipher(messageToCipher: String, key: Int) {
        var ciphredMessage = ""

        for char in messageToCipher.unicodeScalars {
            // convert to `Int`
            var unicode = Int(char.value)
            print(unicode)

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

                unicode += modifiedShift
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

                unicode += modifiedShift
            }

            ciphredMessage += String(UnicodeScalar(unicode)!)
        }

        cipherLabel.text = ciphredMessage
    }
}

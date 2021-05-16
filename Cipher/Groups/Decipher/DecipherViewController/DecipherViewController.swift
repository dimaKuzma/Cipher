//
//  DecipherViewController.swift
//  Cipher
//
//  Created by Дмитрий on 5/13/21.
//  Copyright © 2021 DK. All rights reserved.
//

import UIKit
import RealmSwift

class DecipherViewController: UIViewController {
    // - UI
    @IBOutlet weak var tableView: UITableView!
    
    // - Data
    var ciphers = [Cipher]()
    
    // - Realm
    let realm = try! Realm()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }

}

// MARK: -
// MARK: Configure
extension DecipherViewController {
    func configure() {
        configureTableView()
        configureAddButton()
        configureRealm()
    }
    
    func configureRealm() {
        ciphers = Array(realm.objects(Cipher.self))
    }
    
    func configureAddButton() {
        let rightButton = UIBarButtonItem.init(image: UIImage(named: "add"), style: .done, target: self, action: #selector(self.handleTap(_:)))
        let backButton = UIBarButtonItem()
        backButton.tintColor = .white
        rightButton.tintColor = .white
        self.navigationItem.rightBarButtonItem = rightButton
        self.navigationItem.rightBarButtonItem?.tintColor = .white
        self.navigationItem.backBarButtonItem = backButton
    }
    
    @objc func handleTap(_ sender: UITapGestureRecognizer) {
        let cipherVC = UIStoryboard(name: "Cipher", bundle: nil).instantiateInitialViewController() as! CipherViewController
        cipherVC.decipherVC = self
        navigationController?.pushViewController(cipherVC, animated: true)
    }
    
    func configureTableView() {
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.tableFooterView = UIView()
    }
    
    func deleteFromRealm(index: Int) {
        let object = realm.objects(Cipher.self)[index]
        try! realm.write {
            realm.delete(object)
        }
        configureRealm()
        tableView.reloadData()
    }
}

// MARK: -
// MARK: TableView DataSource
extension DecipherViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ciphers.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DecipherTableViewCell", for: indexPath) as! DecipherTableViewCell
        cell.cipherLabel.text = ciphers[indexPath.row].cipher
        cell.dateLabel.text = ciphers[indexPath.row].date
        cell.keyLabel.text = "+\(ciphers[indexPath.row].key)"
        print(ciphers[indexPath.row].cipher)
        return cell
    }
    
    
}

// MARK: -
// MARK: TableView Delegate
extension DecipherViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            deleteFromRealm(index: indexPath.row)
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cipherVC = UIStoryboard(name: "Cipher", bundle: nil).instantiateInitialViewController() as! CipherViewController
        cipherVC.decipherVC = self
        cipherVC.key = ciphers[indexPath.row].key
        cipherVC.cipher = ciphers[indexPath.row].cipher
        cipherVC.original = ciphers[indexPath.row].original
        cipherVC.cell = true
        navigationController?.pushViewController(cipherVC, animated: true)
    }
}

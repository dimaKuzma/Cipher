//
//  ViewController.swift
//  Cipher
//
//  Created by Дмитрий on 5/12/21.
//  Copyright © 2021 DK. All rights reserved.
//

import UIKit
import RealmSwift

class EncryptViewController: UIViewController {
    // - UI
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var tableView: UITableView!
    // - Data
    var translations = [Translation]()
    
    // - Realm
    let realm = try! Realm()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
}

// MARK: -
// MARK: Configure
extension EncryptViewController {
    func configure() {
        configureTableView()
        configureAddButton()
        configureRealm()
    }
    
    func configureRealm() {
        translations = Array(realm.objects(Translation.self))
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
        let originalVC = UIStoryboard(name: "Original", bundle: nil).instantiateInitialViewController() as! OriginalViewController
        originalVC.encryptVC = self
        navigationController?.pushViewController(originalVC, animated: true)
    }
    
    func configureTableView() {
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.tableFooterView = UIView()
    }
    
    func deleteFromRealm(index: Int) {
        let object = realm.objects(Translation.self)[index]
        try! realm.write {
            realm.delete(object)
        }
        configureRealm()
        tableView.reloadData()
    }
}

// MARK: -
// MARK: TableView DataSource
extension EncryptViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return translations.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "EncryptTableViewCell", for: indexPath) as! EncryptTableViewCell
        cell.originalLabel.text = translations[indexPath.row].original
        cell.dateLabel.text = translations[indexPath.row].date
        cell.keyLabel.text = "+\(translations[indexPath.row].key)"
        return cell
    }
}

// MARK: -
// MARK: TableView Delegate
extension EncryptViewController: UITableViewDelegate {
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
        let originalVC = UIStoryboard(name: "Original", bundle: nil).instantiateInitialViewController() as! OriginalViewController
        originalVC.encryptVC = self
        originalVC.key = translations[indexPath.row].key
        originalVC.cipher = translations[indexPath.row].cipher
        originalVC.original = translations[indexPath.row].original
        originalVC.cell = true
        navigationController?.pushViewController(originalVC, animated: true)
    }
}


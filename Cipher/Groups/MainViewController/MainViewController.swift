//
//  FirstViewController.swift
//  Cipher
//
//  Created by Дмитрий on 5/12/21.
//  Copyright © 2021 DK. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {
    // - UI
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var tableView: UITableView!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
}

// MARK: -
// MARK: Configure
private extension MainViewController {
    func configure() {
        configureBackButton()
        configureTableView()
        setupBackground(containerView: containerView, image: "background")
    }
    
    func configureBackButton() {
        let backButton = UIBarButtonItem()
        backButton.tintColor = .white
        self.navigationItem.backBarButtonItem = backButton
    }
    
    func configureTableView() {
        tableView.dataSource = self
        tableView.delegate = self
    }
}

// MARK: -
// MARK: TableView DataSource
extension MainViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MainTableViewCell", for: indexPath) as! MainTableViewCell
        cell.selectionStyle = .none
        if indexPath.row == 0 {
            cell.setup(image: UIImage(named: "lock")!,text: "Зашифровать")
        } else {
            cell.setup(image: UIImage(named: "unlock")!, text: "Расшифровать")
        }
        return cell
    }
}

// MARK: -
// MARK: TableView Delegate
extension MainViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let height = CGFloat(tableView.frame.height/2)
        return height
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0 {
            let encryptVC = UIStoryboard(name: "Encrypt", bundle: nil).instantiateInitialViewController() as! EncryptViewController
            navigationController?.pushViewController(encryptVC, animated: true)
        } else {
            let decipherVC = UIStoryboard(name: "Decipher", bundle: nil).instantiateInitialViewController() as! DecipherViewController
            navigationController?.pushViewController(decipherVC, animated: true)
        }
    }
}

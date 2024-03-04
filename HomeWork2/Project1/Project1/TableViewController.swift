//
//  TableViewController.swift
//  Project1
//
//  Created by Денис Шакуров on 04.03.2024.
//

import UIKit

final class TableViewController: UITableViewController {
    
    override func viewDidLoad() {        
        super.viewDidLoad()
        tableView.backgroundColor = .orange
        navigationController?.navigationBar.tintColor = .black
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        5
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        CustomTableViewCell()
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        navigationController?.pushViewController(ChatViewController(), animated: true)
    }
}


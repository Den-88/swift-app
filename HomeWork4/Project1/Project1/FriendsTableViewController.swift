//
//  FriendsTableViewController.swift
//  Project1
//
//  Created by Денис Шакуров on 05.03.2024.
//

import UIKit

final class FriendsTableViewController: UITableViewController {
    var token: String
    lazy private var networkService = NetworkService(token: token)
    private var models: [Friends] = []

    init(token: String) {
        self.token = token
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
            
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(red: 0.8, green: 0.9, blue: 1.0, alpha: 1.0) 
        
        tableView.register(FriendsCustomTableViewCell.self, forCellReuseIdentifier: "Cell")
        
        networkService.getFriends() { [self] friends in
            self.models = friends
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        models.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        guard let cell = cell as? FriendsCustomTableViewCell else {
            return UITableViewCell()
        }
        let model = models[indexPath.row]
        cell.setupFriends(friend: model)
        return cell
    }
}

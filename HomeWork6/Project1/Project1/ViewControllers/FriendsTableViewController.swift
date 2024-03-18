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
    private var dataService = DataService()

    init(token: String) {
        self.token = token
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
            
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = Theme.currentTheme.backgroundColor
        navigationController?.navigationBar.tintColor = Theme.currentTheme.textColor
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: Theme.currentTheme.textColor]
        
        tableView.register(FriendsCustomTableViewCell.self, forCellReuseIdentifier: "Cell")
        
        models = dataService.getFriendsData()
        tableView.reloadData()

        networkLoad(sender: nil)
        
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(refreshData(_:)), for: .valueChanged)
        tableView.refreshControl = refreshControl
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        view.backgroundColor = Theme.currentTheme.backgroundColor
        navigationController?.navigationBar.tintColor = Theme.currentTheme.textColor
        FriendsViewController.titleLabel.textColor = Theme.currentTheme.textColor
        self.tableView.reloadData()
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
        let recognizer = UITapGestureRecognizer(target: self, action: #selector(tapFriend))
        cell.addGestureRecognizer(recognizer)
        return cell
    }
    
    func networkLoad(sender: UIRefreshControl?) {
        networkService.getFriends(completion: { [self] friends in
            self.models = friends
            self.dataService.putFriendsData(friends: friends)

            DispatchQueue.main.async {
                FriendsViewController.friendsTitle = "Друзья"
                FriendsViewController.titleLabel.text = FriendsViewController.friendsTitle
                FriendsViewController.titleLabel.sizeToFit()
                self.tableView.reloadData()
                guard let refreshControl = sender else {
                    return
                }
                refreshControl.endRefreshing()
            }
        }, onError: { error in
            self.showAlert(error: error)
            self.setTitle()
        })
    }
    
    func showAlert(error: Error) {
        DispatchQueue.main.async {
            let alertController = UIAlertController(title: "Ошибка", message: "При загрузке данных из сети произошла ошибка.\n" + error.localizedDescription, preferredStyle: .alert)
            alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alertController, animated: true, completion: nil)
        }
    }
    
    func setTitle() {
        if let syncTime = dataService.getFriendsSyncTime() {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "dd.MM.yyyy в HH:mm"
            let formattedSyncTime = dateFormatter.string(from: syncTime)
            FriendsViewController.friendsTitle = "Друзья\nобновлено \(formattedSyncTime)"
            
        } else {
            FriendsViewController.friendsTitle = "Друзья"
        }
        DispatchQueue.main.async {
            FriendsViewController.titleLabel.text = FriendsViewController.friendsTitle
            FriendsViewController.titleLabel.sizeToFit()
        }
    }
    
    @objc private func refreshData(_ sender: UIRefreshControl) {
        networkLoad(sender: sender)
    }
    
    @objc func tapFriend(sender: UITapGestureRecognizer) {
        guard let cell = sender.view as? FriendsCustomTableViewCell else {
                return
            }

        guard let indexPath = tableView.indexPath(for: cell) else {
            return
        }
        let selectedFriend = models[indexPath.row]
        let profileFriend = FriendViewController(friend: selectedFriend)

        profileFriend.hidesBottomBarWhenPushed = true
        navigationController?.pushViewController(profileFriend, animated: false)
        
        profileFriend.view.transform = CGAffineTransform(scaleX: 0.1, y: 0.1)
        UIView.animate(withDuration: 1, delay: 0, options: .curveEaseInOut, animations: {
            profileFriend.view.transform = .identity
        }, completion: nil)
    }
}

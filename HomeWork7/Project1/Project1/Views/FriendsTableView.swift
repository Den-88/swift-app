//
//  FriendsTableView.swift
//  Project1
//
//  Created by Денис Шакуров on 22.03.2024.
//

import UIKit

protocol FriendsTableViewDelegate: AnyObject {
    func didSelectFriend(_ friend: Friends)
}

class FriendsTableView: UITableView, UITableViewDataSource, UITableViewDelegate {
    weak var friendsDelegate: FriendsTableViewDelegate?
    var models: [Friends] = []
    override init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: frame, style: style)
        dataSource = self
        delegate = self
        register(FriendsCustomTableViewCell.self, forCellReuseIdentifier: "Cell")
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func setFriends(_ friends: [Friends]) {
        DispatchQueue.main.async { [weak self] in
            self?.models = friends
            self?.reloadData()
        }
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return models.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        guard let friendCell = cell as? FriendsCustomTableViewCell else {
            return UITableViewCell()
        }
        let friend = models[indexPath.row]
        friendCell.setupFriends(friend: friend)
        return friendCell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedFriend = models[indexPath.row]
        friendsDelegate?.didSelectFriend(selectedFriend)
    }
}

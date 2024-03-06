//
//  FriendsViewController.swift
//  Project1
//
//  Created by Денис Шакуров on 07.03.2024.
//

import UIKit

final class FriendsViewController: UIViewController {
    var token: String

    init(token: String) {
        self.token = token
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Друзья"
        NetworkService(token: token).getFriends()
        let childController = FriendsTableViewController()
        addChild(childController)
        view.addSubview(childController.view)
        childController.didMove(toParent: self)
        childController.view.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            childController.view.topAnchor.constraint(equalTo: view.topAnchor),
            childController.view.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            childController.view.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            childController.view.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}

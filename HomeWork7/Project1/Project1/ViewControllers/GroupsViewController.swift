//
//  GroupsViewController.swift
//  Project1
//
//  Created by Денис Шакуров on 07.03.2024.
//

import UIKit

final class GroupsViewController: UIViewController {
    var token: String
    public static var groupsTitle = "Группы"
    public static let titleLabel = UILabel()

    init(token: String) {
        self.token = token
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        GroupsViewController.titleLabel.numberOfLines = 0
        GroupsViewController.titleLabel.text = GroupsViewController.groupsTitle
        GroupsViewController.titleLabel.textAlignment = .center
        GroupsViewController.titleLabel.font = UIFont.boldSystemFont(ofSize: 17)
        navigationItem.titleView = GroupsViewController.titleLabel

        let childController = GroupsTableViewController(token: token)
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

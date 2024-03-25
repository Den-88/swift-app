//
//  FriendViewController.swift
//  Project1
//
//  Created by Денис Шакуров on 18.03.2024.
//

import UIKit

final class FriendViewController: UIViewController {
    let friend: Friends
    private var friendView: FriendView!

    init(friend: Friends) {
        self.friend = friend
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
        title = "Профиль"
        setupFriendView()
    }

    private func setupFriendView() {
        friendView = FriendView(frame: view.bounds)
        view.addSubview(friendView)
        friendView.configure(with: friend)
    }
}

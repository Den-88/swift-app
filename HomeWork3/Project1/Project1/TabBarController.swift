//
//  TabBarController.swift
//  Project1
//
//  Created by Денис Шакуров on 05.03.2024.
//

import UIKit

final class TabBarController: UITabBarController {
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

        let firstViewController = FriendsViewController(token: token)
        let secondViewController = GroupsViewController(token: token)
        let thirdViewController = PhotosViewController(token: token)
        
        let firstNavigationController = UINavigationController(rootViewController: firstViewController)
        let secondNavigationController = UINavigationController(rootViewController: secondViewController)
        let thirdNavigationController = UINavigationController(rootViewController: thirdViewController)

        firstViewController.tabBarItem = UITabBarItem(title: "Друзья", image: UIImage(systemName: "person.2"), tag: 0)
        secondViewController.tabBarItem = UITabBarItem(title: "Группы", image: UIImage(systemName: "person.3"), tag: 1)
        thirdViewController.tabBarItem = UITabBarItem(title: "Фото", image: UIImage(systemName: "photo"), tag: 2)

        tabBar.unselectedItemTintColor = .gray
        tabBar.tintColor = .black
        
        viewControllers = [firstNavigationController, secondNavigationController, thirdNavigationController]
    }
}

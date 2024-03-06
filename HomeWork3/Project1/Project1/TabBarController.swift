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

        let firstViewController = FirstViewController(token: token)
        let secondViewController = SecondViewController(token: token)
        let thirdViewController = ThirdViewController(token: token)
        
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
final class FirstViewController: UIViewController {
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
        let url = URL(string: "https://api.vk.com/method/friends.get?fields=first_name,last_name&access_token=\(token)&v=5.131")!
        getAnyData(URLRequest: url)
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

final class SecondViewController: UIViewController {
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
        view.backgroundColor = UIColor(red: 0.8, green: 0.9, blue: 1.0, alpha: 1.0)
        title = "Группы"
        let url = URL(string: "https://api.vk.com/method/groups.get?access_token=\(token)&extended=1&v=5.131")!
        getAnyData(URLRequest: url)
        let childController = GroupsTableViewController()
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

final class ThirdViewController: UIViewController {
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
        view.backgroundColor = UIColor(red: 0.8, green: 0.9, blue: 1.0, alpha: 1.0)
        title = "Фото"
        let url = URL(string: "https://api.vk.com/method/photos.get?access_token=\(token)&album_id=wall&v=5.131")!
        getAnyData(URLRequest: url)
        let childController = PhotoViewController()
        addChild(childController)
        view.addSubview(childController.view)
        childController.didMove(toParent: self)
    }
}

func getAnyData(URLRequest url: URL) -> Void {

    print(url)
    
    let task = URLSession.shared.dataTask(with: url) { data, response, error in
        if let error = error {
            print(error)
        } else {
            print(data ?? [])
            do {
                if let json = try JSONSerialization.jsonObject(with: data!, options: []) as? [String: Any] {
                    print(json)
                }
            } catch {
                print(error)
            }
        }
    }
    task.resume()
}


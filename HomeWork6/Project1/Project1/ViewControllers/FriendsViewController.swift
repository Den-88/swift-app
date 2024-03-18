//
//  FriendsViewController.swift
//  Project1
//
//  Created by Денис Шакуров on 07.03.2024.
//

import UIKit

final class FriendsViewController: UIViewController {
    var token: String
    public static var friendsTitle = "Друзья"
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

        FriendsViewController.titleLabel.numberOfLines = 0
        FriendsViewController.titleLabel.text = FriendsViewController.friendsTitle
        FriendsViewController.titleLabel.textAlignment = .center
        FriendsViewController.titleLabel.font = UIFont.boldSystemFont(ofSize: 17)
        navigationItem.titleView = FriendsViewController.titleLabel
        
        let imageView = UIImageView(image: UIImage(systemName: "person"))
        let barButtonItem = UIBarButtonItem(customView: imageView)
        navigationItem.rightBarButtonItem = barButtonItem
        let recognizer = UITapGestureRecognizer(target: self, action: #selector(tapProfile))
        imageView.addGestureRecognizer(recognizer)

        
        let childController = FriendsTableViewController(token: token)
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
    
    
    
    @objc func tapProfile() {
        let profileVC = ProfileViewController(token: token)
        profileVC.hidesBottomBarWhenPushed = true
        navigationController?.pushViewController(profileVC, animated: false)
        
        profileVC.view.transform = CGAffineTransform(scaleX: 0.1, y: 0.1).concatenating(CGAffineTransform(rotationAngle: -CGFloat.pi))
        UIView.animate(withDuration: 1, delay: 0, usingSpringWithDamping: 0.6, initialSpringVelocity: 0.8, options: [], animations: {
            profileVC.view.transform = .identity
        }, completion: nil)
    }
}

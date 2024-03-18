//
//  FriendViewController.swift
//  Project1
//
//  Created by Денис Шакуров on 18.03.2024.
//

import UIKit

final class FriendViewController: UIViewController {
    let friend: Friends

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
        
        DispatchQueue.main.async {
            self.setupViews()
            self.photo.downloadImage(url: self.friend.photoBig)
        }
    }
    
    lazy private var label: UILabel = {
        let label = UILabel()
        label.text = friend.name + " " + friend.surname
        label.textAlignment = .center
        label.textColor = Theme.currentTheme.textColor
        label.backgroundColor = Theme.currentTheme.textBackground
        return label
    }()
    
    private var photo: UIImageView = {
        let image = UIImage(systemName: "person")
        let photo = UIImageView(image: image)
        photo.contentMode = .scaleAspectFit
        photo.layer.masksToBounds = true
        return photo
    }()
    
    private func setupViews() {
        view.addSubview(label)
        view.addSubview(photo)
        setupConstraints()
    }
    
    private func setupConstraints() {
        label.translatesAutoresizingMaskIntoConstraints = false
        photo.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            label.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            label.widthAnchor.constraint(equalToConstant: view.frame.size.width/1.5),
            label.heightAnchor.constraint(equalToConstant: 40),
            
            photo.topAnchor.constraint(equalTo: label.bottomAnchor, constant: 20),
            photo.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            photo.widthAnchor.constraint(equalToConstant: view.frame.size.width - 50),
            photo.heightAnchor.constraint(equalToConstant: view.frame.size.width - 50),
        ])
    }
}



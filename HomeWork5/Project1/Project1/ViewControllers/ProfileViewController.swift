//
//  ProfileViewController.swift
//  Project1
//
//  Created by Денис Шакуров on 12.03.2024.
//

import UIKit

final class ProfileViewController: UIViewController {
    var token: String
    lazy private var networkService = NetworkService(token: token)
    private var model = Profile(name: "", surname: "", photo: "")

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
        title = "Профиль"

        networkService.getProfile() { [weak self] profile in
            guard let self = self else { return }
            self.model = profile
            print(model)
            DispatchQueue.main.async {
                self.setupViews()
                self.photo.downloadImage(url: self.model.photo)
            }
        }
    }
    
    lazy private var label: UILabel = {
        let label = UILabel()
        label.text = model.name + " " + model.surname
        label.textAlignment = .center
        label.textColor = .white
        label.backgroundColor = .blue
        return label
    }()
    
    private var photo: UIImageView = {
        let image = UIImage(systemName: "person")
        let photo = UIImageView(image: image)
        photo.backgroundColor = .blue
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

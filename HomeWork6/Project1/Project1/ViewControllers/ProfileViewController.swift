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
        view.backgroundColor = Theme.currentTheme.backgroundColor
        navigationController?.navigationBar.tintColor = Theme.currentTheme.textColor
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: Theme.currentTheme.textColor]

        title = "Профиль"
        
        button1.addTarget(self, action: #selector(tap1), for: .touchUpInside)
        button2.addTarget(self, action: #selector(tap2), for: .touchUpInside)
        button3.addTarget(self, action: #selector(tap3), for: .touchUpInside)

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
        label.textColor = Theme.currentTheme.textColor
        label.backgroundColor = Theme.currentTheme.textBackground
        return label
    }()
    
    private var photo: UIImageView = {
        let image = UIImage(systemName: "person")
        let photo = UIImageView(image: image)
        photo.backgroundColor = .blue
        photo.layer.masksToBounds = true
        return photo
    }()
    
    private var text: UILabel = {
        let text = UILabel()
        text.textColor = Theme.currentTheme.textColor
        text.text = "Выберите тему"
        text.textAlignment = .center
        return text
    }()
    
    private var button1: UIButton = {
        var buttonConfiguration = UIButton.Configuration.bordered()
        buttonConfiguration.baseBackgroundColor = LightTheme().backgroundColor
        buttonConfiguration.baseForegroundColor = .darkText
        buttonConfiguration.title = "Светлая тема"
        buttonConfiguration.contentInsets = .init(top: 10, leading: 20, bottom: 10, trailing: 20)

        let button = UIButton(configuration: buttonConfiguration)
        button.layer.borderColor = UIColor.black.cgColor
        button.layer.borderWidth = 1
        button.layer.cornerRadius = 5
        return button
    }()
    
    private var button2: UIButton = {
        var buttonConfiguration = UIButton.Configuration.bordered()
        buttonConfiguration.baseBackgroundColor = BlueTheme().backgroundColor
        buttonConfiguration.baseForegroundColor = .orange
        buttonConfiguration.title = "Синяя тема"
        buttonConfiguration.contentInsets = .init(top: 10, leading: 20, bottom: 10, trailing: 20)

        let button = UIButton(configuration: buttonConfiguration)
        button.layer.borderColor = UIColor.black.cgColor
        button.layer.borderWidth = 1
        button.layer.cornerRadius = 5
        return button
    }()
    
    private var button3: UIButton = {
        var buttonConfiguration = UIButton.Configuration.bordered()
        buttonConfiguration.baseBackgroundColor = BlackTheme().backgroundColor
        buttonConfiguration.baseForegroundColor = .lightText
        buttonConfiguration.title = "Тёмная тема"
        buttonConfiguration.contentInsets = .init(top: 10, leading: 20, bottom: 10, trailing: 20)

        let button = UIButton(configuration: buttonConfiguration)
        button.layer.borderColor = UIColor.black.cgColor
        button.layer.borderWidth = 1
        button.layer.cornerRadius = 5
        return button
    }()

    private func setupViews() {
        view.addSubview(label)
        view.addSubview(photo)
        view.addSubview(text)
        view.addSubview(button1)
        view.addSubview(button2)
        view.addSubview(button3)
        setupConstraints()
    }
    
    private func setupConstraints() {
        label.translatesAutoresizingMaskIntoConstraints = false
        photo.translatesAutoresizingMaskIntoConstraints = false
        text.translatesAutoresizingMaskIntoConstraints = false
        button1.translatesAutoresizingMaskIntoConstraints = false
        button2.translatesAutoresizingMaskIntoConstraints = false
        button3.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            label.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            label.widthAnchor.constraint(equalToConstant: view.frame.size.width/1.5),
            label.heightAnchor.constraint(equalToConstant: 40),
            
            photo.topAnchor.constraint(equalTo: label.bottomAnchor, constant: 20),
            photo.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            photo.widthAnchor.constraint(equalToConstant: view.frame.size.width - 50),
            photo.heightAnchor.constraint(equalToConstant: view.frame.size.width - 50),
            
            text.topAnchor.constraint(equalTo: photo.bottomAnchor, constant: 20),
            text.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            button1.centerYAnchor.constraint(equalTo: text.bottomAnchor, constant: 30),
            button1.centerXAnchor.constraint(equalTo: view.centerXAnchor),

            button2.centerYAnchor.constraint(equalTo: button1.bottomAnchor, constant: 30),
            button2.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            button2.widthAnchor.constraint(equalTo: button1.widthAnchor),
            
            button3.centerYAnchor.constraint(equalTo: button2.bottomAnchor, constant: 30),
            button3.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            button3.widthAnchor.constraint(equalTo: button1.widthAnchor),

        ])
    }
}

private extension ProfileViewController {
    
    @objc func tap1() {
        Theme.currentTheme = LightTheme()
        view.backgroundColor = Theme.currentTheme.backgroundColor
        text.textColor = Theme.currentTheme.textColor
        label.textColor = Theme.currentTheme.textColor
        label.backgroundColor = Theme.currentTheme.textBackground
        UINavigationBar.appearance().tintColor = Theme.currentTheme.textColor
        navigationController?.navigationBar.tintColor = Theme.currentTheme.textColor
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: Theme.currentTheme.textColor]

    }
    
    @objc func tap2() {
        Theme.currentTheme = BlueTheme()
        view.backgroundColor = Theme.currentTheme.backgroundColor
        text.textColor = Theme.currentTheme.textColor
        label.textColor = Theme.currentTheme.textColor
        label.backgroundColor = Theme.currentTheme.textBackground
        UINavigationBar.appearance().tintColor = Theme.currentTheme.textColor
        navigationController?.navigationBar.tintColor = Theme.currentTheme.textColor
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: Theme.currentTheme.textColor]
    }
    
    @objc func tap3() {
        Theme.currentTheme = BlackTheme()
        view.backgroundColor = Theme.currentTheme.backgroundColor
        text.textColor = Theme.currentTheme.textColor
        label.textColor = Theme.currentTheme.textColor
        label.backgroundColor = Theme.currentTheme.textBackground
        navigationController?.navigationBar.tintColor = Theme.currentTheme.textColor
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: Theme.currentTheme.textColor]

    }
}

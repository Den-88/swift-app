//
//  ViewController.swift
//  Project1
//
//  Created by Денис Шакуров on 27.02.2024.
//

import UIKit

final class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .orange
        view.addSubview(imageView)
        view.addSubview(label)
        view.addSubview(login)
        view.addSubview(password)
        view.addSubview(button)
        button.addTarget(self, action: #selector(tap), for: .touchUpInside)
        setupConstraints()
    }

    private var imageView: UIImageView = {
        let image = UIImage(named: "cat")
        let imageView = UIImageView(image: image)
        imageView.backgroundColor = .yellow
        return imageView
    }()
    
    private var label: UILabel = {
        let label = UILabel()
        label.text = "Авторизация"
        label.textAlignment = .center
        label.textColor = .black
        label.backgroundColor = .green
        return label
    }()
    
    private var login: UITextField = {
        let login = UITextField()
        login.text = "Логин"
        login.textAlignment = .left
        login.textColor = .black
        login.backgroundColor = .yellow
        return login
    }()
    
    private var password: UITextField = {
        let password = UITextField()
        password.text = "Пароль"
        password.textAlignment = .left
        password.textColor = .black
        password.backgroundColor = .yellow
        return password
    }()
    
    private var button: UIButton = {
        let button = UIButton()
        button.setTitle("Войти", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.setTitleColor(.yellow, for: .highlighted)
        button.backgroundColor = .blue
        return button
    }()
    
    private func setupConstraints() {
        imageView.translatesAutoresizingMaskIntoConstraints = false
        label.translatesAutoresizingMaskIntoConstraints = false
        login.translatesAutoresizingMaskIntoConstraints = false
        password.translatesAutoresizingMaskIntoConstraints = false
        button.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            imageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 30),
            imageView.widthAnchor.constraint(equalToConstant: view.frame.size.width/1.4),
            imageView.heightAnchor.constraint(equalToConstant: 120),

            label.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            label.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 30),
            label.widthAnchor.constraint(equalToConstant: view.frame.size.width/1.1),
            
            login.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            login.topAnchor.constraint(equalTo: label.bottomAnchor, constant: 60),
            login.widthAnchor.constraint(equalToConstant: view.frame.size.width/1.5),
            
            password.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            password.topAnchor.constraint(equalTo: login.bottomAnchor, constant: 30),
            password.widthAnchor.constraint(equalToConstant: view.frame.size.width/1.5),

            button.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            button.topAnchor.constraint(equalTo: password.bottomAnchor, constant: 60),
            button.widthAnchor.constraint(equalToConstant: view.frame.size.width/1.1),
        ])
    }
}

private extension ViewController {
    @objc func tap() {
        navigationController?.pushViewController(TabBarController(), animated: true)
    }
}

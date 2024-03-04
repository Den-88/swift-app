//
//  ChatViewController.swift
//  Project1
//
//  Created by Денис Шакуров on 04.03.2024.
//

import UIKit

final class ChatViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Текст"
        view.backgroundColor = .orange
        view.addSubview(text1)
        view.addSubview(text2)
        view.addSubview(text3)
        view.addSubview(view1)
        view1.addSubview(text4)
        view1.addSubview(button)
        setupConstraints()
    }

    private var text1: UITextField = {
        let textView = UITextField()
        textView.text = "Текст"
        textView.isUserInteractionEnabled = false
        textView.backgroundColor = .yellow
        textView.borderStyle = .roundedRect
        textView.textColor = .black
        return textView
    }()
    
    private var text2: UITextField = {
        let textView = UITextField()
        textView.text = "Текст"
        textView.isUserInteractionEnabled = false
        textView.backgroundColor = .blue
        textView.borderStyle = .roundedRect
        textView.textColor = .white
        return textView
    }()
    
    private var text3: UITextField = {
        let textView = UITextField()
        textView.text = "Текст"
        textView.isUserInteractionEnabled = false
        textView.backgroundColor = .yellow
        textView.borderStyle = .roundedRect
        textView.textColor = .black
        return textView
    }()
    
    private var view1: UIView = {
        let bottomView = UIView()
        bottomView.backgroundColor = .yellow
        return bottomView
    }()
    
    private var text4: UITextField = {
        let textView = UITextField()
        textView.text = "Текст"
        textView.backgroundColor = .white
        textView.borderStyle = .roundedRect
        textView.textColor = .black
        return textView
    }()
    
    private var button: UIButton = {
        let button = UIButton()
        button.setTitle("Отправить", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.setTitleColor(.yellow, for: .highlighted)
        button.backgroundColor = .blue
        return button
    }()
    
    private func setupConstraints() {
        text1.translatesAutoresizingMaskIntoConstraints = false
        text2.translatesAutoresizingMaskIntoConstraints = false
        text3.translatesAutoresizingMaskIntoConstraints = false
        view1.translatesAutoresizingMaskIntoConstraints = false
        text4.translatesAutoresizingMaskIntoConstraints = false
        button.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            text1.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 30),
            text1.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),

            text2.topAnchor.constraint(equalTo: text1.bottomAnchor, constant: 30),
            text2.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            
            text3.topAnchor.constraint(equalTo: text2.bottomAnchor, constant: 30),
            text3.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            
//            view1.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: 70),
//            view1.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
//            view1.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            view1.widthAnchor.constraint(equalToConstant: view.frame.size.width),
            view1.heightAnchor.constraint(equalToConstant: 120),
            view1.bottomAnchor.constraint(equalTo: view.bottomAnchor),

            
            text4.topAnchor.constraint(equalTo: view1.topAnchor, constant: 30),
            text4.leadingAnchor.constraint(equalTo: view1.leadingAnchor, constant: 10),
            text4.trailingAnchor.constraint(equalTo: view1.leadingAnchor, constant: 200),

            button.topAnchor.constraint(equalTo: view1.topAnchor, constant: 30),
            button.leadingAnchor.constraint(equalTo: text4.trailingAnchor, constant: 20),
            button.trailingAnchor.constraint(equalTo: view1.trailingAnchor, constant: -10),

//            text2.widthAnchor.constraint(equalToConstant: view.frame.size.width/1.1),
            
//            text3.centerXAnchor.constraint(equalTo: view.centerXAnchor),
//            text3.topAnchor.constraint(equalTo: text2.bottomAnchor, constant: 60),
//            text3.widthAnchor.constraint(equalToConstant: view.frame.size.width/1.5),
            
//            password.centerXAnchor.constraint(equalTo: view.centerXAnchor),
//            password.topAnchor.constraint(equalTo: login.bottomAnchor, constant: 30),
//            password.widthAnchor.constraint(equalToConstant: view.frame.size.width/1.5),
//
//            button.centerXAnchor.constraint(equalTo: view.centerXAnchor),
//            button.topAnchor.constraint(equalTo: password.bottomAnchor, constant: 60),
//            button.widthAnchor.constraint(equalToConstant: view.frame.size.width/1.1),
        ])
    }
}

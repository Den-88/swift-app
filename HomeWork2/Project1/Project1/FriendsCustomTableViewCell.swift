//
//  FriendsCustomTableViewCell.swift
//  Project1
//
//  Created by Денис Шакуров on 05.03.2024.
//

import UIKit

final class FriendsCustomTableViewCell: UITableViewCell {
    private var circle: UIImageView = {
        let image = UIImage(named: "cat2")
        let circle = UIImageView(image: image)
        circle.backgroundColor = .yellow
        circle.layer.cornerRadius = 35
        return circle
    }()
    
    private var text1: UITextField = {
        let textView = UITextField()
        textView.text = "Имя"
        textView.isUserInteractionEnabled = false
        textView.backgroundColor = .yellow
        textView.borderStyle = .roundedRect
        textView.textColor = .black
        return textView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = .clear
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        contentView.addSubview(circle)
        contentView.addSubview(text1)
        setupConstraints()
    }
    
    private func setupConstraints() {
        circle.translatesAutoresizingMaskIntoConstraints = false
        text1.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            circle.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            circle.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            circle.heightAnchor.constraint(equalToConstant: 70),
            circle.widthAnchor.constraint(equalTo: circle.heightAnchor),
            
            text1.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 30),
            text1.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -30),
            text1.leadingAnchor.constraint(equalTo: circle.trailingAnchor, constant: 30),
            text1.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -30),
        ])
    }
}

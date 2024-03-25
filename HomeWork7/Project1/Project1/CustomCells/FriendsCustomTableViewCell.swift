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
        circle.layer.masksToBounds = true
        return circle
    }()

    private var text1: UITextField = {
        let textView = UITextField()
        textView.isUserInteractionEnabled = false
        textView.backgroundColor = Theme.currentTheme.textBackground
        textView.borderStyle = .roundedRect
        textView.textColor = Theme.currentTheme.textColor
        return textView
    }()

    private var textOnline: UILabel = {
        let textView = UILabel()
        textView.font = UIFont.systemFont(ofSize: 12)
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
        contentView.addSubview(textOnline)
        setupConstraints()
    }

    func setupFriends (friend: Friends) {
        text1.text = friend.name + " " + friend.surname
        if friend.online == 0 {
            textOnline.text = "Offline"
            textOnline.textColor = Theme.currentTheme.textOfflineColor
        } else {
            textOnline.text = "Online"
            textOnline.textColor = Theme.currentTheme.textOnlineColor
        }
        circle.downloadImage(url: friend.photo)
    }

    private func setupConstraints() {
        circle.translatesAutoresizingMaskIntoConstraints = false
        text1.translatesAutoresizingMaskIntoConstraints = false
        textOnline.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            circle.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            circle.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            circle.heightAnchor.constraint(equalToConstant: 70),
            circle.widthAnchor.constraint(equalTo: circle.heightAnchor),

            text1.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 30),
            text1.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -30),
            text1.leadingAnchor.constraint(equalTo: circle.trailingAnchor, constant: 30),
            text1.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -30),

            textOnline.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            textOnline.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20)
        ])
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        text1.backgroundColor = Theme.currentTheme.textBackground
        text1.textColor = Theme.currentTheme.textColor
    }
}

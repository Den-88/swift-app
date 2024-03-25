//
//  FriendView.swift
//  Project1
//
//  Created by Денис Шакуров on 25.03.2024.
//

import UIKit

class FriendView: UIView {
    let label: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = Theme.currentTheme.textColor
        label.backgroundColor = Theme.currentTheme.textBackground
        return label
    }()

    let photoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.layer.masksToBounds = true
        return imageView
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupViews() {
        addSubview(label)
        addSubview(photoImageView)
        setupConstraints()
    }

    private func setupConstraints() {
        label.translatesAutoresizingMaskIntoConstraints = false
        photoImageView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 20),
            label.centerXAnchor.constraint(equalTo: centerXAnchor),
            label.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.size.width / 1.5),
            label.heightAnchor.constraint(equalToConstant: 40),

            photoImageView.topAnchor.constraint(equalTo: label.bottomAnchor, constant: 20),
            photoImageView.centerXAnchor.constraint(equalTo: centerXAnchor),
            photoImageView.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.size.width - 50),
            photoImageView.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.size.width - 50)
        ])
    }

    func configure(with friend: Friends) {
        label.text = friend.name + " " + friend.surname
        if let url = URL(string: friend.photoBig) {
            downloadImage(from: url)
        } else {
            print("Invalid URL:", friend.photoBig)
        }
    }

    private func downloadImage(from url: URL) {
        URLSession.shared.dataTask(with: url) { [weak self] data, _, error in
            guard let data = data, let image = UIImage(data: data), error == nil else {
                print("Failed to load image from \(url):", error?.localizedDescription ?? "Unknown error")
                return
            }
            DispatchQueue.main.async {
                self?.photoImageView.image = image
            }
        }.resume()
    }
}

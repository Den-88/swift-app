//
//  ProfileView.swift
//  Project1
//
//  Created by Денис Шакуров on 25.03.2024.
//

import UIKit

class ProfileView: UIView {
    let label: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        return label
    }()

    let photoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.layer.masksToBounds = true
        return imageView
    }()

    let textLabel: UILabel = {
        let label = UILabel()
        label.textColor = Theme.currentTheme.textColor
        label.text = "Выберите тему"
        label.textAlignment = .center
        return label
    }()

    let lightThemeButton: UIButton = {
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

    let blueThemeButton: UIButton = {
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

    let darkThemeButton: UIButton = {
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
        addSubview(textLabel)
        addSubview(lightThemeButton)
        addSubview(blueThemeButton)
        addSubview(darkThemeButton)
        setupConstraints()
    }

    func configure(with profile: Profile) {
        label.text = profile.name + " " + profile.surname
        if let url = URL(string: profile.photo) {
            downloadImage(from: url)
        } else {
            print("Invalid URL:", profile.photo)
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

    private func setupConstraints() {
        label.translatesAutoresizingMaskIntoConstraints = false
        photoImageView.translatesAutoresizingMaskIntoConstraints = false
        textLabel.translatesAutoresizingMaskIntoConstraints = false
        lightThemeButton.translatesAutoresizingMaskIntoConstraints = false
        blueThemeButton.translatesAutoresizingMaskIntoConstraints = false
        darkThemeButton.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 20),
            label.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            label.widthAnchor.constraint(equalToConstant: self.frame.size.width/1.5),
            label.heightAnchor.constraint(equalToConstant: 40),

            photoImageView.topAnchor.constraint(equalTo: label.bottomAnchor, constant: 20),
            photoImageView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            photoImageView.widthAnchor.constraint(equalToConstant: self.frame.size.width - 50),
            photoImageView.heightAnchor.constraint(equalToConstant: self.frame.size.width - 50),

            textLabel.topAnchor.constraint(equalTo: photoImageView.bottomAnchor, constant: 20),
            textLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),

            lightThemeButton.centerYAnchor.constraint(equalTo: textLabel.bottomAnchor, constant: 30),
            lightThemeButton.centerXAnchor.constraint(equalTo: self.centerXAnchor),

            blueThemeButton.centerYAnchor.constraint(equalTo: lightThemeButton.bottomAnchor, constant: 30),
            blueThemeButton.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            blueThemeButton.widthAnchor.constraint(equalTo: lightThemeButton.widthAnchor),

            darkThemeButton.centerYAnchor.constraint(equalTo: blueThemeButton.bottomAnchor, constant: 30),
            darkThemeButton.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            darkThemeButton.widthAnchor.constraint(equalTo: lightThemeButton.widthAnchor)

        ])
    }
}

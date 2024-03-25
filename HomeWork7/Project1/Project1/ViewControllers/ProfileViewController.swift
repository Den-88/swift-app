//
//  ProfileViewController.swift
//  Project1
//
//  Created by Денис Шакуров on 12.03.2024.
//

import UIKit

final class ProfileViewController: UIViewController {
    let token: String
    var profileView: ProfileView!
    lazy var networkService = NetworkService(token: token)
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
        setupProfileView()
        fetchProfile()
        applyTheme()
    }

    private func setupProfileView() {
        profileView = ProfileView(frame: view.bounds)
        view.addSubview(profileView)
        profileView.configure(with: model)
        profileView.lightThemeButton.addTarget(self, action: #selector(lightThemeButtonTapped), for: .touchUpInside)
        profileView.blueThemeButton.addTarget(self, action: #selector(blueThemeButtonTapped), for: .touchUpInside)
        profileView.darkThemeButton.addTarget(self, action: #selector(darkThemeButtonTapped), for: .touchUpInside)
    }

    private func fetchProfile() {
        networkService.getProfile { [weak self] profile in
            guard let self = self else { return }
            self.model = profile
            DispatchQueue.main.async {
                self.profileView.configure(with: profile)
            }
        }
    }

    @objc private func lightThemeButtonTapped() {
        Theme.currentTheme = LightTheme()
        applyTheme()
    }

    @objc private func blueThemeButtonTapped() {
        Theme.currentTheme = BlueTheme()
        applyTheme()
    }

    @objc private func darkThemeButtonTapped() {
        Theme.currentTheme = BlackTheme()
        applyTheme()
    }
    func applyTheme() {
        view.backgroundColor = Theme.currentTheme.backgroundColor
        profileView.textLabel.textColor = Theme.currentTheme.textColor
        profileView.label.textColor = Theme.currentTheme.textColor
        profileView.label.backgroundColor = Theme.currentTheme.textBackground

        let navBarAppearance = UINavigationBarAppearance()
        navBarAppearance.titleTextAttributes = [NSAttributedString.Key.foregroundColor: Theme.currentTheme.textColor]
        navBarAppearance.buttonAppearance.normal.titleTextAttributes = [NSAttributedString.Key.foregroundColor: Theme.currentTheme.textColor]

        navigationController?.navigationBar.tintColor = Theme.currentTheme.textColor
        navigationController?.navigationBar.standardAppearance = navBarAppearance
        navigationController?.navigationBar.compactAppearance = navBarAppearance
        navigationController?.navigationBar.scrollEdgeAppearance = navBarAppearance
    }
}

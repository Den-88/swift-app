//
//  AuthViewController.swift
//  Project1
//
//  Created by Денис Шакуров on 27.02.2024.
//

import UIKit
import WebKit

class AuthViewController: UIViewController {

  private let webView: VKAuthView

  init() {
    self.webView = VKAuthView()
    super.init(nibName: nil, bundle: nil)
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  override func viewDidLoad() {
    super.viewDidLoad()
    view.addSubview(webView)
    setupConstraints()
    navigationController?.navigationBar.isHidden = true

    guard let url = URL(string: "https://oauth.vk.com/authorize?client_id=51878127&display=mobile&redirect_uri=https://oauth.vk.com/blank.html&response_type=token") else {
      fatalError("URL is not valid")
    }
    webView.load(URLRequest(url: url))
    webView.delegate = self
  }

  private func setupConstraints() {
    webView.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      webView.topAnchor.constraint(equalTo: view.topAnchor),
      webView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
      webView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
      webView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
    ])
  }
}

extension AuthViewController: AuthViewDelegate {
  func didAuthorize(with data: AuthModel) {
    print("Access Token:", data.accessToken)
    print("User ID:", data.userID)
    let tabBarController = TabBarController(token: data.accessToken)
    navigationController?.pushViewController(tabBarController, animated: true)
  }
}

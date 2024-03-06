//
//  ViewController.swift
//  Project1
//
//  Created by Денис Шакуров on 27.02.2024.
//

import UIKit
import WebKit

final class ViewController: UIViewController, WKNavigationDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(webView)
        let url = URL(string: "https://oauth.vk.com/authorize?client_id=51870034&display=mobile&redirect_uri=https://oauth.vk.com/blank.html&response_type=token")!
        webView.load(URLRequest(url: url))
        setupConstraints()
    }

    private lazy var webView: WKWebView = {
        let webView = WKWebView()
        webView.navigationDelegate = self
        return webView
    }()
    
    func webView(_ webView: WKWebView, decidePolicyFor navigationResponse: WKNavigationResponse, decisionHandler: @escaping (WKNavigationResponsePolicy) -> Void) {
        guard let url = navigationResponse.response.url, url.path == "/blank.html", let fragment = url.fragment else {
            decisionHandler(.allow)
            return
        }
        let params = fragment
            .components(separatedBy: "&")
            .map { $0.components(separatedBy: "=") }
            .reduce([String: String]()) { result, param in
                var dict = result
                let key = param[0]
                let value = param[1]
                dict[key] = value
                return dict
            }
        let token = params ["access_token" ]
        let userID = params ["user_id"]
        print(token!)
        print(userID!)
        decisionHandler(.cancel)
        webView.removeFromSuperview()
        navigationController?.pushViewController(TabBarController(token: token!), animated: true)
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

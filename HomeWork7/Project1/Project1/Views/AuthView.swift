//
//  VKAuthView.swift
//  Project1
//
//  Created by Денис Шакуров on 22.03.2024.
//

import WebKit

protocol AuthViewDelegate: AnyObject {
  func didAuthorize(with data: AuthModel)
}

class VKAuthView: WKWebView {
  weak var delegate: AuthViewDelegate?

  override init(frame: CGRect, configuration: WKWebViewConfiguration) {
    super.init(frame: frame, configuration: configuration)
    navigationDelegate = self
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}

extension VKAuthView: WKNavigationDelegate {
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

    guard let token = params["access_token"], let userID = params["user_id"] else {
      decisionHandler(.allow)
      return
    }

    let authData = AuthModel(accessToken: token, userID: userID)
    delegate?.didAuthorize(with: authData)
    decisionHandler(.cancel)
    removeFromSuperview()
  }
}

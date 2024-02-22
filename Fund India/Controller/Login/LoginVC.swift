//
//  LoginVC.swift
//  Fund India
//
//  Created by Monish M on 22/02/24.
//

import UIKit
import WebKit

class LoginVC: UIViewController {
    
    @IBOutlet weak var loginWebview: WKWebView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        loginWebview.navigationDelegate = self
        let webUrl = "\(APIManager.shared.loginURL)\(API.githubOauthApi)?client_id=\(NetworkManager.shared.clientID)"
        let url = URL(string: webUrl)!
        loginWebview.load(URLRequest(url: url))
        activityIndicator.startAnimating()
        activityIndicator.hidesWhenStopped = true
    }
    
    func handleAuthorizationCode(url: URL) {
        if let code = url.valueOf("code") {
            exchangeCodeForToken(code: code)
        } else {
            // Handle error
        }
    }
    
    
    func exchangeCodeForToken(code: String) {
        
        print("normalcodeeeeeeeee",code)
        let loginData = LoginModel(client_id: NetworkManager.shared.clientID, client_secret: NetworkManager.shared.clientSecret, code: code)
        print("params",loginData.toDictionary())
        NetworkManager.shared.postApiRequest(url: APIManager.shared.loginURL + API.getAcessToken, parameters: loginData.toDictionary()) { (response) in
            switch(response?.result) {
            case .success(_):
                guard let data = response?.data else { return }
                let decoder = JSONDecoder()
                    do {
                        let tokenData = try decoder.decode(TokenData.self, from: data)
                        NetworkManager.shared.tokenValue = tokenData.accessToken ?? ""
                        
                        let repositoryListVC = RepositoryListVC()
                        self.navigationController?.pushViewController(repositoryListVC, animated: true)
                    } catch {
                        print(error)
                    }
            case .failure(let error):
                print(error.localizedDescription)
            case .none:
                print("server timeout")
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
}

extension LoginVC: WKNavigationDelegate {
    
    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        print(error)
        activityIndicator.stopAnimating()
    }
    
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        if let url = navigationAction.request.url, url.absoluteString.hasPrefix("https://api.github.com/") {
            // Extract the authorization code from the URL and proceed with token exchange
            decisionHandler(.cancel)
            handleAuthorizationCode(url: url)
        } else {
            decisionHandler(.allow)
        }
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        activityIndicator.stopAnimating()
    }
}

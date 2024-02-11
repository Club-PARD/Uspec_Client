//
//  LoginViewController.swift
//  Uspec_Client
//
//  Created by 김하람 on 2/9/24.
//

import UIKit
import AuthenticationServices
import SnapKit
import Then

class LoginViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        setUi()
    }
    
    private func setUi() {
        let loginButton = UIButton().then {
            $0.setTitle("Login with Apple", for: .normal)
            $0.backgroundColor = .systemBlue
            $0.setTitleColor(.white, for: .normal)
        }
        
        self.view.addSubview(loginButton)
        
        loginButton.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.width.equalTo(200)
            make.height.equalTo(50)
        }
    }
}

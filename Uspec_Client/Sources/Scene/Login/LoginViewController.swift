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
    let authorizationAppleIDButton = ASAuthorizationAppleIDButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setComponents()
        configureUI()
    }
    
    private func setComponents() {
        let logoImage = UIImageView()
        view.addSubview(logoImage)
        logoImage.image = UIImage(named: "splash_logo")
        logoImage.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
        
        let splashImage = UIImageView()
        view.addSubview(splashImage)
        splashImage.image = UIImage(named: "splash")
        splashImage.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview()
            make.width.equalToSuperview()
        }
        
        let joinLabel = UILabel()
        joinLabel.text = "어스펙이 처음이신가요?"
        joinLabel.textColor = UIColor(resource: .textBlack)
        
        let joinButton = UIButton()
        joinButton.setTitle("|  회원가입", for: .normal)
        joinButton.setTitleColor(UIColor(resource: .textBlack), for: .normal)
        joinButton.addTarget(self, action: #selector(joinButtonTapped), for: .touchUpInside)
        
        let stackView = UIStackView(arrangedSubviews: [joinLabel, joinButton])
        view.addSubview(stackView)
        stackView.spacing = 10
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalTo(-30)
        }
    }
    
    @objc private func joinButtonTapped() {
       
        let profileVC = ProfileViewController()
        self.navigationController?.pushViewController(profileVC, animated: true)
        print(self.navigationController)
        print("회원가입 tapped")
    }
    
    private func configureUI() {
        view.backgroundColor = UIColor(resource: .backgroundWhite)
        setAdditionalPropertyAttributes()
        setConstraints()
    }
    
    private func setAdditionalPropertyAttributes() {
        authorizationAppleIDButton.addTarget(self, action: #selector(handleAuthorizationAppleIDButton(_:)), for: .touchUpInside)
    }
    
    private func setConstraints() {
        view.addSubview(authorizationAppleIDButton)
        authorizationAppleIDButton.translatesAutoresizingMaskIntoConstraints = false
        authorizationAppleIDButton.snp.makeConstraints { make in
            make.bottom.equalTo(-75)
            make.centerX.equalToSuperview()
            make.width.equalTo(268)
            make.height.equalTo(55)
        }
    }
    
    @objc private func handleAuthorizationAppleIDButton(_ sender: ASAuthorizationAppleIDButton) {
        let provider = ASAuthorizationAppleIDProvider()
        let request = provider.createRequest()
        request.requestedScopes = [.fullName, .email]
        let controller = ASAuthorizationController(authorizationRequests: [request])
        controller.performRequests()
        controller.delegate = self
        controller.presentationContextProvider = self
    }
}


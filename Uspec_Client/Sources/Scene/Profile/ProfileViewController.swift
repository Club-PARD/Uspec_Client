//
//  ProfileViewController.swift
//  Uspec_Client
//
//  Created by 김하람 on 2/9/24.
//

import UIKit

class ProfileViewController: UIViewController {
    private var scrollView: UIScrollView!
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .backgroundWhite
        navigationUI()
        setupScrollView()
        setupUI()
    }
    
    @objc func backButtonTapped() {
        self.navigationController?.popViewController(animated: true)
    }
    
    private func setupScrollView() {
        scrollView = UIScrollView()
        scrollView.backgroundColor = .clear
        view.addSubview(scrollView)
        scrollView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    private func navigationUI() {
        let backButton = UIBarButtonItem(image: UIImage(systemName: "chevron.backward"), style: .plain, target: self, action: #selector(backButtonTapped))
        backButton.tintColor = UIColor(resource: .textBlack)
        let textButton = UIBarButtonItem(title: "회원가입", style: .plain, target: self, action: #selector(backButtonTapped))
        textButton.tintColor = UIColor(resource: .textBlack)
        
        let appearance = UINavigationBarAppearance()
        appearance.backgroundColor = .backgroundWhite
        appearance.shadowImage = UIImage(named: "line0")
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
        
        self.navigationItem.leftBarButtonItems = [backButton, textButton]
    }
    
    private func setupUI() {
        let welcomeLabel = UILabel()
        welcomeLabel.text = "USPEC에 오신 것을 환영합니다."
        welcomeLabel.textColor = .primaryYellow
        welcomeLabel.textAlignment = .left
        scrollView.addSubview(welcomeLabel)
        welcomeLabel.snp.makeConstraints { make in
            make.top.equalTo(32)
            make.left.equalTo(26)
        }
        
        let content1Label = UILabel()
        content1Label.text = "전국의 대학생들의 데이터를 비교하고\n나만의 스펙을 쌓아갈 수 있는 이 곳, USPEC에서\n여러분의 미래를 그려나가길 응원합니다."
        content1Label.numberOfLines = 3
        content1Label.textColor = .textBlack
        content1Label.textAlignment = .left
        scrollView.addSubview(content1Label)
        content1Label.snp.makeConstraints { make in
            make.top.equalTo(welcomeLabel.snp.bottom).offset(8)
            make.left.equalTo(26)
        }
        
        let content2Label = UILabel()
        content2Label.text = "시작하기 전, 여러분의 정보를 알려주세요."
        content2Label.textColor = .textBlack
        content2Label.textAlignment = .left
        scrollView.addSubview(content2Label)
        content2Label.snp.makeConstraints { make in
            make.top.equalTo(content1Label.snp.bottom).offset(8)
            make.left.equalTo(26)
        }
        
        let imageView = UIImageView()
        view.addSubview(imageView)
        imageView.image = UIImage(named: "splash")
        imageView.contentMode = .scaleAspectFill
        imageView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview()
            make.width.equalToSuperview()
        }
        
        let nextButton = NextButton(backgroundColor: .gray7, titleText: "정보 입력하기", left: 16, right: 16, bottom: 14)
        view.addSubview(nextButton)
    }
}

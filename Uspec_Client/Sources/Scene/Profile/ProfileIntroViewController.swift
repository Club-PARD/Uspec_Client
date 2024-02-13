//
//  ProfileViewController.swift
//  Uspec_Client
//
//  Created by 김하람 on 2/9/24.
//

import UIKit

class ProfileIntroViewController: ProfileViewController {
    override func viewDidLoad() {
    
        super.viewDidLoad()
        view.backgroundColor = .backgroundWhite

        setupUI()
    }
    private func setupUI() {
        mainLabel.text = "USPEC에 오신 것을 환영합니다."
        
        
        let content1Label = UILabel()
        content1Label.setTextWithLineHeight(text: "전국의 대학생들의 데이터를 비교하고\n나만의 스펙을 쌓아갈 수 있는 이 곳, USPEC에서\n여러분의 미래를 그려나가길 응원합니다.", lineHeight: 20)
        content1Label.numberOfLines = 3
        content1Label.textColor = .textBlack
        content1Label.font = UIFont.body1(size: 15)
        content1Label.textAlignment = .left
        scrollView.addSubview(content1Label)
        content1Label.snp.makeConstraints { make in
            make.top.equalTo(67)
            make.left.equalTo(26)
        }
        
        let content2Label = UILabel()
        content2Label.text = "시작하기 전, 여러분의 정보를 알려주세요."
        content2Label.textColor = .textBlack
        content2Label.font = UIFont.body1(size: 15)
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
        
        let nextButton = NextButton(titleText: "정보 입력하기")
        nextButton.backgroundColor = .gray7
        view.addSubview(nextButton)
        nextButton.snp.makeConstraints { make in
            make.left.equalTo(16)
            make.right.equalTo(-16)
            make.bottom.equalTo(-48)
            make.height.equalTo(45)
        }
        nextButton.layer.cornerRadius = 4
        nextButton.addTarget(self, action: #selector(nextButtonTapped), for: .touchUpInside)
    }
    
    @objc func nextButtonTapped() {
        print("tapped")
        let nickNameVC = NickNameViewController(currentStep: .step1)
        self.navigationController?.pushViewController(nickNameVC, animated: true)
        print(self.navigationController as Any)
    }
}

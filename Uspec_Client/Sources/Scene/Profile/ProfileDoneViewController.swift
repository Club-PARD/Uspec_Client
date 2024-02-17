//
//  ProfileDoneViewController.swift
//  Uspec_Client
//
//  Created by 김하람 on 2/16/24.
//

import UIKit

class ProfileDoneViewController: ProfileViewController{
    let userName = UserDefaults.standard.string(forKey: "nickName") ?? "null"
    let appearance = UINavigationBarAppearance()
    let notYetButton = NextButton(titleText: "지금은 건너뛰기")
    let doneButton = NextButton(titleText: "이력 입력하기")
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationUI()
        setUi()
        setBottomButtons()
    }
    
    private func navigationUI() {
        let backButton = UIBarButtonItem(image: UIImage(systemName: "chevron.backward"), style: .plain, target: self, action: #selector(backButtonTapped))
        backButton.tintColor = UIColor(resource: .textBlack)
        let textButton = UIBarButtonItem(title: "이력 입력", style: .plain, target: self, action: #selector(backButtonTapped))
        let attributes = [NSAttributedString.Key.font: UIFont.header2(size: 20)]
        textButton.tintColor = UIColor(resource: .textBlack)
        textButton.setTitleTextAttributes(attributes, for: .normal)
        
        appearance.backgroundColor = .backgroundWhite
        appearance.shadowImage = UIImage(named: "line0")
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
        self.navigationItem.leftBarButtonItems = [backButton, textButton]
    }
    
    private func setUi() {
        let logo = UIImageView().then{
            $0.image = UIImage(named: "logo")
        }
        view.addSubview(logo)
        logo.snp.makeConstraints{ make in
            make.top.equalTo(205)
            make.centerX.equalToSuperview()
            make.width.equalTo(115.08)
            make.height.equalTo(121.32)
        }
        
        let welcomeLabel = UILabel().then{
            $0.text = "\(userName)님 안녕하세요!"
            $0.textColor = .primaryYellow
            $0.font = .header3(size: 18)
        }
        view.addSubview(welcomeLabel)
        welcomeLabel.snp.makeConstraints{ make in
            make.top.equalTo(logo.snp.bottom).offset(20)
            make.centerX.equalToSuperview()
        }
        
        let mainLabel = UILabel().then{
            $0.textColor = .textBlack
            $0.setTextWithLineHeight(text: "USPEC은 다양한 정보\n통합해 비교 분석을 진행해요.\n\(userName)님에게 더 정확한 데이터 분석을\n제공할 수 있도록 이력을 입력해주세요.", lineHeight: 20)
            $0.textAlignment = .center
            $0.numberOfLines = 0
            $0.font = .body2(size: 14)
        }
        view.addSubview(mainLabel)
        mainLabel.snp.makeConstraints{ make in
            make.top.equalTo(welcomeLabel.snp.bottom).offset(24)
            make.centerX.equalToSuperview()
        }
        
        let subLabel = UILabel().then{
            $0.setTextWithLineHeight(text: "아직 정보 공개를 희망하지 않으신다면 추후에 입력 가능해요\n다만 이후 서비스 이용 시 제한이 걸릴 수 있습니다.", lineHeight: 15)
            $0.textAlignment = .center
            $0.numberOfLines = 0
            $0.textColor = .gray4
            $0.font = .caption2(size: 11)
        }
        view.addSubview(subLabel)
        subLabel.snp.makeConstraints{ make in
            make.top.equalTo(mainLabel.snp.bottom).offset(16)
            make.centerX.equalToSuperview()
        }
    }
    
    private func setBottomButtons() {
        view.addSubview(notYetButton)
        view.addSubview(doneButton)
        doneButton.snp.makeConstraints { make in
            make.left.equalTo(16)
            make.right.equalTo(-16)
            make.bottom.equalTo(-48)
            make.height.equalTo(45)
        }
        notYetButton.snp.makeConstraints { make in
            make.left.equalTo(16)
            make.right.equalTo(-16)
            make.bottom.equalTo(doneButton.snp.top).offset(-4)
            make.height.equalTo(45)
        }
        
        notYetButton.backgroundColor = .white
        notYetButton.setTitleColor(.textBlack, for: .normal)
        notYetButton.layer.borderWidth = 1
        notYetButton.layer.borderColor = UIColor.gray3.cgColor
        notYetButton.layer.cornerRadius = 4
        notYetButton.addTarget(self, action: #selector(notYetButtonTapped), for: .touchUpInside)
        
        doneButton.backgroundColor = .gray7
        doneButton.layer.cornerRadius = 4
        doneButton.addTarget(self, action: #selector(doneButtonTapped), for: .touchUpInside)
    }
    
    @objc func notYetButtonTapped() {
        let homeVC = HomeViewController()
        self.navigationController?.pushViewController(homeVC, animated: true)
        print(self.navigationController as Any)
    }
    @objc func doneButtonTapped() {
        let careerVC = CareerIntroViewController(currentStep: .step1)
        self.navigationController?.pushViewController(careerVC, animated: true)
        print(self.navigationController as Any)
    }
    
}

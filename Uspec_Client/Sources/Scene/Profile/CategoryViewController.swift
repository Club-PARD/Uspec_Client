//
//  CategoryViewController.swift
//  Uspec_Client
//
//  Created by 김하람 on 2/15/24.
//

import UIKit

class CategoryViewController: ProfileViewController {
    let notYetButton = NextButton(titleText: "아직 진로 방향을 정하지 못했어요.")
    let doneButton = NextButton(titleText: "회원가입 완료")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUi()
        setBottomButtons()
    }
    
    private func setUi() {
        mainLabel.setTextWithLineHeight(text: "마지막으로 여러분들의\n자세한 진로 분야를 알려주세요.", lineHeight: 24)
        let title = UILabel().then {
            $0.text = "진학/취업하고자 하는 분야를 입력해주세요."
            $0.font = .body1(size: 15)
            $0.textColor = .textBlack
        }
        view.addSubview(title)
        title.snp.makeConstraints{ make in
            make.top.equalTo(mainLabel.snp.bottom).offset(32)
            make.left.equalTo(16)
        }
        let subTitle = UILabel().then {
            $0.text = "희망하는 분야가 여러개일 경우 모두 선택하여 주세요."
            $0.font = .body3(size: 13)
            $0.textColor = .gray4
        }
        view.addSubview(subTitle)
        subTitle.snp.makeConstraints{ make in
            make.top.equalTo(title.snp.bottom).offset(6)
            make.left.equalTo(16)
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
        
        doneButton.backgroundColor = .gray2
        doneButton.layer.cornerRadius = 4
        doneButton.addTarget(self, action: #selector(doneButtonTapped), for: .touchUpInside)
    }
    @objc func notYetButtonTapped() {
        let categoryVC = CategoryViewController(currentStep: .step4)
        self.navigationController?.pushViewController(categoryVC, animated: true)
        print(self.navigationController as Any)
    }
    @objc func doneButtonTapped() {
        let categoryVC = CategoryViewController(currentStep: .step4)
        self.navigationController?.pushViewController(categoryVC, animated: true)
        print(self.navigationController as Any)
    }
    
}

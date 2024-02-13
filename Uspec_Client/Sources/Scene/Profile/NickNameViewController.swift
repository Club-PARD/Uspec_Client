//
//  NickNameViewController.swift
//  Uspec_Client
//
//  Created by 김하람 on 2/13/24.
//

import UIKit

class NickNameViewController: ProfileViewController, UISearchTextFieldDelegate {
    let nickNameField = UITextField()
    let buttonBackgroundColor = UIColor()
    let nextButton = NextButton(titleText: "다음")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUi()
        setButton()
        nextButton.isEnabled = false
        nickNameField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
    }

    private func setUi() {
        mainLabel.setTextWithLineHeight(text: "USPEC에서 사용할\n당신의 이름을 알려주세요.", lineHeight: 24)
        
        let fieldLabel = UILabel()
        view.addSubview(fieldLabel)
        fieldLabel.text = "닉네임을 입력해주세요."
        fieldLabel.font = .body1(size: 15)
        fieldLabel.textColor = .textBlack
        fieldLabel.snp.makeConstraints{ make in
            make.top.equalTo(mainLabel.snp.bottom).offset(32)
            make.left.equalTo(26)
        }
        
        view.addSubview(nickNameField)
        nickNameField.delegate = self
        nickNameField.font = .body1(size: 15)
        nickNameField.placeholder = "닉네임 (8자 이내)"
        nickNameField.textColor = .textBlack
        nickNameField.layer.cornerRadius = 20
        nickNameField.layer.borderWidth = 1
        nickNameField.setPlaceholder(color: .gray4)
        nickNameField.addLeftPadding(width: 16)
        nickNameField.layer.borderColor = UIColor.gray3.cgColor
        nickNameField.snp.makeConstraints{ make in
            make.top.equalTo(fieldLabel.snp.bottom).offset(12)
            make.centerX.equalToSuperview()
            make.height.equalTo(48)
            make.left.equalTo(26)
            make.right.equalTo(-26)
        }
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        nickNameField.layer.borderColor = UIColor.secondaryYellow.cgColor
    }
    
    @objc func textFieldDidChange(_ textField: UITextField) {
        let isTextEmpty = textField.text?.isEmpty ?? true
        nextButton.isEnabled = !isTextEmpty
        updateButtonColorBasedOnTextField()
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        updateButtonColorBasedOnTextField()
    }
    
    private func updateButtonColorBasedOnTextField() {
        if nextButton.isEnabled {
            nextButton.backgroundColor = .gray7
        } else {
            nextButton.backgroundColor = .gray2
        }
    }
    
    private func setButton() {
        view.addSubview(nextButton)
        nextButton.snp.makeConstraints { make in
            make.left.equalTo(16)
            make.right.equalTo(-16)
            make.bottom.equalTo(-48)
            make.height.equalTo(45)
        }
        nextButton.backgroundColor = .gray2
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

//
//  NickNameViewController.swift
//  Uspec_Client
//
//  Created by 김하람 on 2/13/24.
//

import UIKit

class NickNameViewController: ProfileViewController, UISearchTextFieldDelegate {
    let nextButton = NextButton(titleText: "다음")
    let nickNameField = ProfileTextField(
        placeholder: "닉네임 (8자 이내)",
        fontSize: 15,
        textColor: .textBlack,
        borderColor: UIColor.gray3,
        cornerRadius: 20,
        borderWidth: 1,
        leftPadding: 16,
        rightPadding: -16
    )
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUi()
        setButton()
        nextButton.isEnabled = false
        nickNameField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        hideKeyboardWhenTappedAround()
    }
    
    private func setUi() {
        mainLabel.setTextWithLineHeight(text: "USPEC에서 사용할\n당신의 이름을 알려주세요.", lineHeight: 24)
        
        let fieldLabel = profileFieldLabel(text: "닉네임을 입력해주세요.", fontSize: 15, textColor: .textBlack)
        view.addSubview(fieldLabel)
        fieldLabel.snp.makeConstraints{ make in
            make.top.equalTo(mainLabel.snp.bottom).offset(32)
            make.left.equalTo(16)
        }
        
        view.addSubview(nickNameField)
        nickNameField.delegate = self
        nickNameField.snp.makeConstraints{ make in
            make.top.equalTo(fieldLabel.snp.bottom).offset(12)
            make.centerX.equalToSuperview()
            make.height.equalTo(48)
            make.left.equalTo(16)
            make.right.equalTo(-16)
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
        let univVC = UniversityViewController(currentStep: .step2)
        self.navigationController?.pushViewController(univVC, animated: true)
        
        guard let nickName = nickNameField.text else { return }
        UserDefaults.standard.set(nickName, forKey: "nickName")
    }
}

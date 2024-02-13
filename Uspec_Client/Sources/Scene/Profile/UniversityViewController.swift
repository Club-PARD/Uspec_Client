//
//  UniversityViewController.swift
//  Uspec_Client
//
//  Created by 김하람 on 2/14/24.
//

import UIKit

class UniversityViewController: ProfileViewController, UITextFieldDelegate {
    let nextButton = NextButton(titleText: "다음")
    let univField = profileTextField(
        placeholder: "대학교",
        fontSize: 15,
        textColor: .textBlack,
        borderColor: UIColor.gray3,
        cornerRadius: 20,
        borderWidth: 1,
        leftPadding: 16,
        rightPadding: 16
    )
    let majorField = profileTextField(
        placeholder: "학부 또는 학과",
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
        searchUnivButton()
    }
    
    private func searchUnivButton() {
        let searchButton = UIButton(type: .system)
        searchButton.setImage(UIImage(systemName: "magnifyingglass"), for: .normal)
        univField.addSubview(searchButton)
        searchButton.addTarget(self, action: #selector(searchButtonTapped), for: .touchUpInside)
        searchButton.isEnabled = false
        
        univField.rightView = searchButton
        univField.rightViewMode = .always
        univField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
    }
    
    @objc func searchButtonTapped() {
        print("Search button tapped")
    }
    
    private func setUi(){
        mainLabel.setTextWithLineHeight(text: "정확한 정보 비교를 위해\n여러분의 대학교와 학부를 작성해주세요.", lineHeight: 24)
        
        // MARK: - 대학교 텍스트 필드
        let univFieldLabel = profileFieldLabel(text: "대학교 이름을 입력 후 검색을 눌러 학교를 찾아주세요.", fontSize: 15, textColor: .textBlack)
        view.addSubview(univFieldLabel)
        univFieldLabel.snp.makeConstraints{ make in
            make.top.equalTo(mainLabel.snp.bottom).offset(32)
            make.left.equalTo(16)
        }
        
        view.addSubview(univField)
        univField.delegate = self
        univField.snp.makeConstraints{ make in
            make.top.equalTo(univFieldLabel.snp.bottom).offset(12)
            make.centerX.equalToSuperview()
            make.height.equalTo(48)
            make.left.equalTo(16)
            make.right.equalTo(-16)
        }
        
        // MARK: - 학부, 학과 텍스트 필드
        let majorFieldLabel = profileFieldLabel(text: "본인의 학부/학과 이름을 작성해주세요.", fontSize: 15, textColor: .textBlack)
        view.addSubview(majorFieldLabel)
        majorFieldLabel.snp.makeConstraints{ make in
            make.top.equalTo(univField.snp.bottom).offset(32)
            make.left.equalTo(16)
        }
        
        view.addSubview(majorField)
        majorField.delegate = self
        majorField.snp.makeConstraints{ make in
            make.top.equalTo(majorFieldLabel.snp.bottom).offset(12)
            make.centerX.equalToSuperview()
            make.height.equalTo(48)
            make.left.equalTo(16)
            make.right.equalTo(-16)
        }
    }
    
    @objc func textFieldDidChange(_ textField: UITextField) {
        if let searchButton = univField.rightView as? UIButton {
            searchButton.isEnabled = !(univField.text?.isEmpty ?? true) // univField에 대한 검사만 여기서 수행
        }
        updateButtonStatus()
    }
    
    private func updateButtonStatus() {
        let isBothFieldsFilled = !(univField.text?.isEmpty ?? true) && !(majorField.text?.isEmpty ?? true)
        nextButton.isEnabled = isBothFieldsFilled
        updateButtonColorBasedOnTextField()
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField == univField {
            univField.layer.borderColor = UIColor.secondaryYellow.cgColor
            univField.layer.borderWidth = 1
        } else if textField == majorField {
            majorField.layer.borderColor = UIColor.secondaryYellow.cgColor
            majorField.layer.borderWidth = 1
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
    
    @objc func nextButtonTapped() {
        let infoVC = StatusInfoViewController(currentStep: .step3)
        self.navigationController?.pushViewController(infoVC, animated: true)
        print(self.navigationController as Any)
    }
}

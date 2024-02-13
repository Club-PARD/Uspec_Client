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
        leftPadding: 16
    )
    let majorField = profileTextField(
        placeholder: "학부 또는 학과",
        fontSize: 15,
        textColor: .textBlack,
        borderColor: UIColor.gray3,
        cornerRadius: 20,
        borderWidth: 1,
        leftPadding: 16
    )
    override func viewDidLoad() {
        super.viewDidLoad()
        setUi()
        setButton()
    }
    
    private func setUi(){
        mainLabel.setTextWithLineHeight(text: "정확한 정보 비교를 위해\n여러분의 대학교와 학부를 작성해주세요.", lineHeight: 24)
        
        // MARK: - 대학교 텍스트 필드
        let univFieldLabel = profileFieldLabel(text: "대학교 이름을 입력 후 검색을 눌러 학교를 찾아주세요.", fontSize: 15, textColor: .textBlack)
        view.addSubview(univFieldLabel)
        univFieldLabel.snp.makeConstraints{ make in
            make.top.equalTo(mainLabel.snp.bottom).offset(32)
            make.left.equalTo(26)
        }
        
        view.addSubview(univField)
        univField.delegate = self
        univField.snp.makeConstraints{ make in
            make.top.equalTo(univFieldLabel.snp.bottom).offset(12)
            make.centerX.equalToSuperview()
            make.height.equalTo(48)
            make.left.equalTo(26)
            make.right.equalTo(-26)
        }
        
        // MARK: - 학부, 학과 텍스트 필드
        let majorFieldLabel = profileFieldLabel(text: "본인의 학부/학과 이름을 작성해주세요.", fontSize: 15, textColor: .textBlack)
        view.addSubview(majorFieldLabel)
        majorFieldLabel.snp.makeConstraints{ make in
            make.top.equalTo(univField.snp.bottom).offset(32)
            make.left.equalTo(26)
        }
        
        view.addSubview(majorField)
        majorField.delegate = self
        majorField.snp.makeConstraints{ make in
            make.top.equalTo(majorFieldLabel.snp.bottom).offset(12)
            make.centerX.equalToSuperview()
            make.height.equalTo(48)
            make.left.equalTo(26)
            make.right.equalTo(-26)
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
        print(self.navigationController as Any)
    }
    
}

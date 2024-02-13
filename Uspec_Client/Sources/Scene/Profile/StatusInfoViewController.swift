//
//  StatusInfoViewController.swift
//  Uspec_Client
//
//  Created by 김하람 on 2/14/24.
//

import UIKit

class StatusInfoViewController: ProfileViewController {
    let nextButton = NextButton(titleText: "다음")
    let statusLabel = profileFieldLabel(text: "현재 대학교 등록 상태를 알려주세요.", fontSize: 15, textColor: .textBlack)
    let ageLabel = profileFieldLabel(text: "현재 나이와 학기 수를 입력해주세요.", fontSize: 15, textColor: .textBlack)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUi()
        setStatusButtons()
    }
    
    private func setUi() {
        mainLabel.setTextWithLineHeight(text: "여러분과 비슷한 학생들을 찾기 위해\n조금 더 자세한 학기 정보를 알려주세요.", lineHeight: 24)
        
        view.addSubview(statusLabel)
        statusLabel.snp.makeConstraints{ make in
            make.top.equalTo(mainLabel.snp.bottom).offset(32)
            make.left.equalTo(16)
        }
        
        view.addSubview(ageLabel)
        ageLabel.snp.makeConstraints{ make in
            make.top.equalTo(statusLabel.snp.bottom).offset(73)
            make.left.equalTo(16)
        }
    }
    
    private func setStatusButtons(){
        let underGraduate = NormalButton(titleText: "재학/휴학")
        underGraduate.backgroundColor = .red
        let graduate = NormalButton(titleText: "졸업/취업준비")
        graduate.backgroundColor = .green
        let statusButtons = UIStackView(arrangedSubviews: [underGraduate, graduate])
        
        statusButtons.spacing = 16
        statusButtons.distribution = .fillEqually
        statusButtons.axis = .horizontal
        view.addSubview(statusButtons)
        statusButtons.snp.makeConstraints{ make in
            make.top.equalTo(statusLabel.snp.bottom).offset(12)
            make.left.equalTo(16)
            make.right.equalTo(-16)
            make.height.equalTo(37)
        }
        
        
    }
    
}

//
//  StatusInfoViewController.swift
//  Uspec_Client
//
//  Created by 김하람 on 2/14/24.
//

import UIKit
import DLRadioButton

class StatusInfoViewController: ProfileViewController {
    let nextButton = NextButton(titleText: "다음")
    let statusLabel = profileFieldLabel(text: "현재 대학교 등록 상태를 알려주세요.", fontSize: 15, textColor: .textBlack)
    let ageLabel = profileFieldLabel(text: "현재 나이와 학기 수를 입력해주세요.", fontSize: 15, textColor: .textBlack)
    let scoreLabel = profileFieldLabel(text: "현재까지 평균 학점을 입력해주세요.", fontSize: 15, textColor: .textBlack)
    let ageField = profileTextField(
        placeholder: "나이(만)",
        fontSize: 15,
        textColor: .textBlack,
        borderColor: UIColor.gray3,
        cornerRadius: 20,
        borderWidth: 1,
        leftPadding: 16,
        rightPadding: 16
    )
    let semesterField = profileTextField(
        placeholder: "학기 수",
        fontSize: 15,
        textColor: .textBlack,
        borderColor: UIColor.gray3,
        cornerRadius: 20,
        borderWidth: 1,
        leftPadding: 16,
        rightPadding: 16
    )
    let scoreField = profileTextField(
        placeholder: "학점",
        fontSize: 15,
        textColor: .textBlack,
        borderColor: UIColor.gray3,
        cornerRadius: 20,
        borderWidth: 1,
        leftPadding: 16,
        rightPadding: 16
    )
    var score4_3 = DLRadioButton()
    var score4_5 = DLRadioButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUi()
        ageSemesterSection()
        statusSection()
        scoreSection()
        setNextButton()
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
        view.addSubview(scoreLabel)
        scoreLabel.snp.makeConstraints{ make in
            make.top.equalTo(ageLabel.snp.bottom).offset(84)
            make.left.equalTo(16)
        }
    }
    
    private func statusSection(){
        let underGraduate = NormalButton(titleText: "재학/휴학")
        underGraduate.backgroundColor = .red
        let graduate = NormalButton(titleText: "졸업/취업준비")
        graduate.backgroundColor = .green
        let statusButtons = UIStackView(arrangedSubviews: [underGraduate, graduate])
        underGraduate.layer.cornerRadius = 4
        graduate.layer.cornerRadius = 4
        
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
    
    private func ageSemesterSection() {
        let agefieldLabel = UILabel()
        agefieldLabel.text = "세    "
        agefieldLabel.textColor = .textBlack
        ageField.addSubview(agefieldLabel)
        ageField.rightView = agefieldLabel
        ageField.rightViewMode = .always
        ageField.addLeftPadding(width: 75)
        
        let semesterLabel = UILabel()
        semesterLabel.text = "학기   "
        semesterLabel.textColor = .textBlack
        semesterField.addSubview(semesterLabel)
        semesterField.rightView = semesterLabel
        semesterField.rightViewMode = .always
        semesterField.addLeftPadding(width: 70)
        
        let ageSemesterStackView = UIStackView(arrangedSubviews: [ageField, semesterField])
        view.addSubview(ageSemesterStackView)
        ageSemesterStackView.axis = .horizontal
        ageSemesterStackView.spacing = 16
        ageSemesterStackView.distribution = .fillEqually
        ageSemesterStackView.snp.makeConstraints{ make in
            make.top.equalTo(ageLabel.snp.bottom).offset(12)
            make.left.equalTo(16)
            make.right.equalTo(-16)
            make.height.equalTo(48)
        }
    }
    
    private func scoreSection() {
        let description = UILabel()
        description.text = "학점은 데이터 분석용으로 사용되며, 비공개 선택 시 프로필에서\n공개되지 않습니다."
        description.numberOfLines = 0
        description.textColor = .gray4
        description.font = .body3(size: 13)
        view.addSubview(description)
        description.snp.makeConstraints{ make in
            make.top.equalTo(scoreLabel.snp.bottom).offset(4)
            make.left.equalTo(16)
        }
        
        score4_3.setTitle("4.3 만점", for: .normal)
        score4_3.setTitleColor( .textBlack , for: .normal)
        score4_3.iconSize = 20
        score4_3.marginWidth = 10
        score4_3.titleLabel?.font = .body1(size: 15)
        score4_3.titleLabel?.lineBreakMode = .byWordWrapping
        score4_3.iconStrokeWidth = 1
        
        score4_5.setTitle("4.5 만점", for: .normal)
        score4_5.setTitleColor( .textBlack , for: .normal)
        score4_5.iconSize = 20
        score4_5.marginWidth = 10
        score4_5.titleLabel?.font = .body1(size: 15)
        score4_5.titleLabel?.lineBreakMode = .byWordWrapping
        score4_5.iconStrokeWidth = 1
        score4_3.otherButtons.append(score4_5)
        
        let scoreRadioStackView = UIStackView(arrangedSubviews: [score4_3, score4_5])
        self.view.addSubview(scoreRadioStackView)
        scoreRadioStackView.axis = .horizontal
        scoreRadioStackView.distribution = .fillEqually
        scoreRadioStackView.snp.makeConstraints{ make in
            make.top.equalTo(description.snp.bottom).offset(12)
            make.left.equalTo(6)
            make.width.equalTo(198)
        }
        
        view.addSubview(scoreField)
        scoreField.snp.makeConstraints{ make in
            make.top.equalTo(scoreRadioStackView.snp.bottom).offset(9)
            make.left.equalTo(16)
            make.right.equalTo(-16)
            make.height.equalTo(48)
        }
    }
    
    @objc func btnTouch(_ sender:DLRadioButton) {
        print(sender.currentTitle!)
    }
    
    private func setNextButton() {
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
        let infoVC = StatusInfoViewController(currentStep: .step3)
        self.navigationController?.pushViewController(infoVC, animated: true)
        print(self.navigationController as Any)
    }
}

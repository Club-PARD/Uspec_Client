//
//  CertifivateCollectionViewCell.swift
//  Uspec_Client
//
//  Created by 진세진 on 2/16/24.
//

import UIKit
import SnapKit
import Then
import FSCalendar

let nickName = UserDefaults.standard.string(forKey: "nickName") ?? "null"

class CertifivateCollectionViewCell: UICollectionViewCell ,UITextFieldDelegate {
    weak var delegate : InputCareerCollectionViewCellDelegate?
    weak var delegateValid : InputCareerValidCheckDelegate?
    var isBothFieldsFilled = false
    var selectedDateStringStart = String()
    private let shadowView = UIView()
    var isselectedStartButton = false
    private let calendarView = CalendarView()
    
    private let certifiCateNameText = UILabel().then { label in
        label.text = "\(nickName)님의 자격증 취득 내역을 입력해주세요."
        label.font = UIFont.body1(size: 15)
        label.textColor = .gray7
    }
    
    private let gettingCertificateDateText = UILabel().then { label in
        label.text = "자격증 취득 일자를 선택해주세요."
        label.font = UIFont.body1(size: 15)
        label.textColor = .gray7
    }
    
    let calderbutton = CertificationCalendarButton(
        titleText: "취득일자",
        image: "defalutcalendar"
    ).then { button in
        button.setTitleColor(.gray3, for: .normal)
    }
    
    private lazy var deleteButton = UIButton().then { button in
        button.setImage(UIImage(named: "delete_Icon"), for: .normal)
        button.addTarget(self, action: #selector(deleteButtonTapped), for: .touchUpInside)
    }
    
    @objc func deleteButtonTapped() {
        delegate?.inputCareerCellDidRequestDelete(self)
    }
    
    let CertificateTextField = ProfileTextField(
        placeholder: "자격증 이름",
        fontSize: 15,
        textColor: .textBlack,
        borderColor: UIColor.gray3,
        cornerRadius: 20,
        borderWidth: 1,
        leftPadding: 16,
        rightPadding: -16
    )
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayout()
        backgroundColor = .white
    }
    
    func setupLayout() {
        addSubview(shadowView)
        shadowView.addSubview(certifiCateNameText)
        shadowView.addSubview(CertificateTextField)
        shadowView.addSubview(gettingCertificateDateText)
        shadowView.addSubview(deleteButton)
        shadowView.addSubview(calderbutton)
        
        self.setViewShadow(backView: shadowView)
        
        validateNextButton()
        CertificateTextField.delegate = self
        calendarView.delegate = self
        
        calderbutton.addTarget(self, action: #selector(showCaledar), for: .touchUpInside)
        
        certifiCateNameText.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(20)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-40)
            make.height.equalTo(21)
        }
        
        CertificateTextField.snp.makeConstraints { make in
            make.top.equalTo(certifiCateNameText.snp.bottom).offset(12)
            make.leading.equalToSuperview().inset(20)
            make.width.equalTo(303)
            make.height.equalTo(43)
        }
        
        deleteButton.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(20)
            make.leading.equalTo(certifiCateNameText.snp.trailing).offset(10)
            make.width.equalTo(16)
            make.height.equalTo(16)
        }
        
        gettingCertificateDateText.snp.makeConstraints { make in
            make.top.equalTo(CertificateTextField.snp.bottom).offset(16)
            make.leading.trailing.equalToSuperview().inset(20)
            make.height.equalTo(21)
        }
        
        calderbutton.snp.makeConstraints { make in
            make.top.equalTo(gettingCertificateDateText.snp.bottom).offset(12)
            make.leading.equalToSuperview().offset(20)
            make.width.equalTo(303)
            make.height.equalTo(43)
        }
        
        shadowView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    @objc func showCaledar() {
        isselectedStartButton.toggle()
        
        calderbutton.layer.borderColor = isselectedStartButton ? UIColor.secondaryYellow.cgColor : UIColor.gray3.cgColor
        calderbutton.setTitleColor(
            (isselectedStartButton ? .secondaryYellow: .gray3),
            for: .normal
        )
        calderbutton.setImage(
            UIImage(named: isselectedStartButton ? "selectedcalendar" : "defalutcalendar"),
            for: .normal
        )
        
        if !isselectedStartButton {
            calendarView.removeFromSuperview()
            calendarView.isHidden = true
        } else {
            calendarView.isHidden = false
            if let visibleWindow = UIWindow.visibleWindow() {
                if !(visibleWindow.subviews.contains(calendarView)) {
                    visibleWindow.addSubview(calendarView)
                    calendarView.snp.makeConstraints({ make in
                        make.top.equalTo(calderbutton.snp.top).offset(50)
                        make.leading.equalToSuperview().offset(140)
                        make.width.equalTo(222)
                        make.height.equalTo(218)
                    })
                }
            }
        }
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        CertificateTextField.layer.borderColor = UIColor.secondaryYellow.cgColor
        validateNextButton()
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        validateNextButton()
        return true
    }
}


extension CertifivateCollectionViewCell: DropdownButtonDelegate{
    func dropdownButton(_ button: DropdownButton, didSelectOption isSelected: Bool) {
        if isSelected {
            UpDateDatavalidation()
            validateNextButton()
        } else {
            UpDateDatavalidation()
            validateNextButton()
        }
    }
    
    func UpDateDatavalidation() -> Bool {
        var wholevalid : Bool = false
        let activityName = CertificateTextField.text ?? ""
        let textFieldNameValid = !(activityName.isEmpty)
        let selectDate = !(selectedDateStringStart.isEmpty)

        return textFieldNameValid == true && selectDate == true
        
    }
    
    func validateNextButton() {
        isBothFieldsFilled = UpDateDatavalidation()
        delegateValid?.inputCareerCell(self, didChangeFieldsFilledStatus: isBothFieldsFilled)
    }
}

extension CertifivateCollectionViewCell : CalendarViewDelegate {
    func didSelectDate(_ calendar: CalendarView,_ date: String) {
        selectedDateStringStart = date
        if !(selectedDateStringStart.isEmpty) {
            calderbutton.setTitle(selectedDateStringStart, for: .normal)
            calderbutton.setTitleColor(.black1, for: .normal)
        } else {
            calderbutton.setTitleColor(.gray3, for: .normal)
        }
        validateNextButton()
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder() // 키보드 내리기
        return true
    }

}

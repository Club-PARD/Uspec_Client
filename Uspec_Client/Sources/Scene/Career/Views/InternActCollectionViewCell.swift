//
//  InternActCollectionViewCell.swift
//  Uspec_Client
//
//  Created by 진세진 on 2/16/24.
//
import UIKit
import SnapKit
import Then
import DLRadioButton
import FSCalendar

class InternActCollectionViewCell: UICollectionViewCell , UITextFieldDelegate {
    weak var delegate : InputCareerCollectionViewCellDelegate?
    weak var delegateValid : InputCareerValidCheckDelegate?
    private var selectedDateStringStart = String()
    private var selectedDateStringLast = String()
    private let shadowView = UIView()
    
    var isBothFieldsFilled = false
    var isScoreVisibleRadioButton = false
    
    var isselectedStartButton = false
    var isselectedlastButton = false
    
    private let companyText = UILabel().then { label in
        label.text = "근무하신 회사의 이름을 적어주세요."
        label.font = UIFont.body1(size: 15)
    }
    
    private let workingDateText = UILabel().then { label in
        label.text = "인턴 근무 기간을 선택해주세요."
        label.font = UIFont.body1(size: 15)
    }
    
    private let activityDateText = UILabel().then { label in
        label.text = "회사에서 맡으신 직무를 작성해주세요.."
        label.font = UIFont.body1(size: 15)
    }
    
    private lazy var deleteButton = UIButton().then { button in
        button.setImage(UIImage(named: "delete_Icon"), for: .normal)
        button.addTarget(self, action: #selector(deleteButtonTapped), for: .touchUpInside)
    }
    
    private let dividerInDateView = UIView().then { view in
        view.layer.cornerRadius = 3
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.gray3.cgColor
        view.layer.masksToBounds = true
        view.backgroundColor = .gray3
    }
    
    private lazy var selectWorking = DLRadioButton().then { radio in
        radio.setTitle("재직중", for: .normal)
        radio.titleLabel?.font = UIFont.body1(size: 15)
        radio.setTitleColor(.gray7, for: .normal)
        radio.setImage(UIImage(named: "selected"), for: .normal)
        if let unSelectedImage = UIImage(named: "unSelected")?.resized(toWidth: 20) {
            radio.icon = unSelectedImage
        }
        if let selectedImage = UIImage(named: "selected")?.resized(toWidth: 20) {
            radio.iconSelected = selectedImage
        }
        radio.addTarget(self, action: #selector(isScoreVisibleTapped), for: .touchUpInside)
    }
    
    //캘린더 두개(시작)
    var startCalendar = CalendarView()
    var lastcalendar = CalendarView()

    let startInternButton = CalendarButton(
        titleText: "시작 일자",
        image: "defalutcalendar"
    ).then { button in
        button.setTitleColor(.gray3, for: .normal)
    }
    
    let lastInternButton = CalendarButton(
        titleText: "종료 일자",
        image: "defalutcalendar"
    ).then { button in
        button.setTitleColor(.gray3, for: .normal)
    }
    
    @objc func deleteButtonTapped() {
        delegate?.inputCareerCellDidRequestDelete(self)
    }
    
    let companyNametextField = profileTextField(
        placeholder: "회사 이름",
        fontSize: 15,
        textColor: .textBlack,
        borderColor: UIColor.gray3,
        cornerRadius: 20,
        borderWidth: 1,
        leftPadding: 16,
        rightPadding: -16
    )
    
    let jobNametextField = profileTextField(
        placeholder: "직무 이름",
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
        shadowView.addSubview(companyText)
        shadowView.addSubview(companyNametextField)
        shadowView.addSubview(workingDateText)
        shadowView.addSubview(activityDateText)
        shadowView.addSubview(deleteButton)
        shadowView.addSubview(startInternButton)
        shadowView.addSubview(jobNametextField)
        shadowView.addSubview(dividerInDateView)
        shadowView.addSubview(lastInternButton)
        shadowView.addSubview(selectWorking)
        self.setViewShadow(backView: shadowView)
        validateNextButton()
        companyNametextField.delegate = self
        jobNametextField.delegate = self
        startCalendar.delegate = self
        lastcalendar.delegate = self
        startInternButton.addTarget(self, action: #selector(showCaledarStart), for: .touchUpInside)
        lastInternButton.addTarget(self, action: #selector(showCaledarLast), for: .touchUpInside)
        companyText.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(20)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-40)
            make.height.equalTo(21)
        }
        
        deleteButton.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(20)
            make.leading.equalTo(companyText.snp.trailing).offset(10)
            make.width.equalTo(16)
            make.height.equalTo(16)
        }
        
        companyNametextField.snp.makeConstraints { make in
            make.top.equalTo(companyText.snp.bottom).offset(12)
            make.leading.equalToSuperview().inset(20)
            make.width.equalTo(303)
            make.height.equalTo(43)
        }
        
        workingDateText.snp.makeConstraints { make in
            make.top.equalTo(companyNametextField.snp.bottom).offset(16)
            make.leading.trailing.equalToSuperview().inset(20)
            make.height.equalTo(21)
        }
        
        startInternButton.snp.makeConstraints { make in
            make.top.equalTo(workingDateText.snp.bottom).offset(8)
            make.leading.equalToSuperview().offset(20)
            make.width.equalTo(144)
            make.height.equalTo(48)
        }
        
        dividerInDateView.snp.makeConstraints { make in
            make.top.equalTo(startInternButton.snp.top).offset(20)
            make.leading.equalTo(startInternButton.snp.trailing).offset(5)
            make.width.equalTo(10)
            make.height.equalTo(3)
        }
        
        lastInternButton.snp.makeConstraints { make in
            make.top.equalTo(workingDateText.snp.bottom).offset(8)
            make.leading.equalTo(dividerInDateView.snp.trailing).offset(5)
            make.width.equalTo(144)
            make.height.equalTo(48)
        }
        
        selectWorking.snp.makeConstraints { make in
            make.top.equalTo(lastInternButton.snp.bottom).offset(8)
            make.trailing.equalToSuperview().offset(-20)
            make.width.equalTo(80)
            make.height.equalTo(25)
        }
        
        activityDateText.snp.makeConstraints { make in
            make.top.equalTo(startInternButton.snp.bottom).offset(46)
            make.leading.trailing.equalToSuperview().inset(20)
            make.height.equalTo(21)
        }
        
        jobNametextField.snp.makeConstraints { make in
            make.top.equalTo(activityDateText.snp.bottom).offset(12)
            make.width.equalTo(303)
            make.height.equalTo(43)
            make.leading.equalToSuperview().offset(20)
        }
        
        shadowView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }

    private func showDropdownMenu(for isDropdownVisble : Bool ,with dropdownMenu : DropdownMenu, button selectedButton : UIButton) {
           
        UIView.animate(withDuration: 0.3) { [weak self] in
            if isDropdownVisble {
                selectedButton.layer.borderColor = UIColor.secondaryYellow.cgColor
                dropdownMenu.snp.updateConstraints { make in
                    dropdownMenu.updateHeight()
                }
            } else {
                selectedButton.layer.borderColor = UIColor.gray3.cgColor
                dropdownMenu.snp.updateConstraints { make in
                    make.height.equalTo(0)
                }
            }
            self?.layoutIfNeeded()
        }
    }
    
    @objc func showCaledarStart() {
        isselectedStartButton.toggle()
        
        startInternButton.layer.borderColor = isselectedStartButton ? UIColor.secondaryYellow.cgColor : UIColor.gray3.cgColor
        startInternButton.setTitleColor(
            (isselectedStartButton ? .secondaryYellow: .gray3),
            for: .normal
        )
        startInternButton.setImage(UIImage(named: isselectedStartButton ? "selectedcalendar" : "defalutcalendar"), for: .normal)
        
        if !isselectedStartButton {
            startCalendar.removeFromSuperview()
            startCalendar.isHidden = true
        } else {
            startCalendar.isHidden = false
            if let visibleWindow = UIWindow.visibleWindow() {
                if !(visibleWindow.subviews.contains(startCalendar)) {
                    visibleWindow.addSubview(startCalendar)
                    startCalendar.setViewShadow(backView: shadowView)
                    startCalendar.snp.makeConstraints({ make in
                        make.top.equalTo(startInternButton.snp.top).offset(50)
                        make.leading.equalToSuperview().offset(20)
                        make.width.equalTo(222)
                        make.height.equalTo(218)
                    })
                    
                }
            }
        }
    }

    @objc func showCaledarLast() {
        isselectedlastButton.toggle()
        
        lastInternButton.layer.borderColor = isselectedlastButton ? UIColor.secondaryYellow.cgColor : UIColor.gray3.cgColor
        lastInternButton.setTitleColor(
            (isselectedlastButton ? .secondaryYellow: .gray3),
            for: .normal
        )
        lastInternButton.setImage(UIImage(named: isselectedlastButton ? "selectedcalendar" : "defalutcalendar"), for: .normal)
        
        if !isselectedlastButton {
            lastcalendar.removeFromSuperview()
            lastcalendar.isHidden = true
        } else {
            lastcalendar.isHidden = false
            if let visibleWindow = UIWindow.visibleWindow() {
                if !(visibleWindow.subviews.contains(lastcalendar)) {
                    visibleWindow.addSubview(lastcalendar)
                    lastcalendar.snp.makeConstraints({ make in
                        make.top.equalTo(startInternButton.snp.top).offset(50)
                        make.trailing.equalToSuperview().offset(-20)
                        make.width.equalTo(222)
                        make.height.equalTo(218)
                    })
                }
            }
        }
    }
    
    @objc func isScoreVisibleTapped(_ sender: DLRadioButton) {
        isScoreVisibleRadioButton.toggle()
        sender.isSelected = isScoreVisibleRadioButton
    }
        
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField == companyNametextField {
            companyNametextField.layer.borderColor = UIColor.secondaryYellow.cgColor
        } else {
            jobNametextField.layer.borderColor = UIColor.secondaryYellow.cgColor
        }
        validateNextButton()
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        validateNextButton()
        return true
    }
}


extension InternActCollectionViewCell {
    
    func UpDateDatavalidation() -> Bool {
        
        let companyName = companyNametextField.text ?? ""
        let jopName = jobNametextField.text ?? ""
        let textFieldNameValid = !(companyName.isEmpty)
        let textFieldjopNameValid = !(jopName.isEmpty)
        let startDate = !(selectedDateStringStart.isEmpty)
        let lastDate = !(selectedDateStringLast.isEmpty)

        return textFieldNameValid == true  && textFieldjopNameValid == true 
                && startDate == true && lastDate == true
    }
    
    func validateNextButton() {
        isBothFieldsFilled = UpDateDatavalidation()
        delegateValid?.inputCareerCell(self, didChangeFieldsFilledStatus: isBothFieldsFilled)
    }
}


extension InternActCollectionViewCell : CalendarViewDelegate {
    func didSelectDate(_ calendar: CalendarView,_ date: String) {
        if calendar == startCalendar {
            selectedDateStringStart = date
            if !(selectedDateStringStart.isEmpty) {
                startInternButton.setTitle(selectedDateStringStart, for: .normal)
                startInternButton.setTitleColor(.black1, for: .normal)
            } else {
                startInternButton.setTitleColor(.gray3, for: .normal)
            }
            
        } else if calendar == lastcalendar {
            selectedDateStringLast = date
            if !(selectedDateStringStart.isEmpty) {
                lastInternButton.setTitle(selectedDateStringLast, for: .normal)
                lastInternButton.setTitleColor(.black1, for: .normal)
            } else {
                lastInternButton.setTitleColor(.gray3, for: .normal)
            }
        }
        validateNextButton()
    }
}


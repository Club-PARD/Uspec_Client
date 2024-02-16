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
    private let shadowView = UIView()
    var isBothFieldsFilled = false
    var isScoreVisibleRadioButton = false
    
    var isselectedStartButton = false
    var isselectedlastButton = false
    var categories1 = ["Category 1-1", "Category 1-2", "Category 1-3", "Category 1-4", "Category 1-8","Category 1-5"]
    var categories2 = ["Category 2-1", "Category 2-2", "Category 2-3", "Category 2-4"]
    var categories3 = ["Category 3-1", "Category 3-2", "Category 3-3", "Category 3-4"]
    
    private let companyText = UILabel().then { label in
        label.text = "근무하신 회사의 이름을 적어주세요."
        label.font = UIFont.body1(size: 15)
    }
    private let calendarView = CalendarView()
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
    
    let dividerInDateView = UIView().then { view in
        view.layer.cornerRadius = 3
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.gray3.cgColor
        view.layer.masksToBounds = true
        view.backgroundColor = .gray3
    }
    
    let selectWorking = DLRadioButton().then { radio in
        radio.setTitle("재직중", for: .normal)
        radio.titleLabel?.font = UIFont.body1(size: 15)
        radio.setTitleColor(.gray7, for: .normal)
        radio.setImage(UIImage(named: "selected"), for: .normal)
    }
    //캘린더 두개(시작)
    var startCalendar = CalendarView()
    var lastcalendar = CalendarView()

    let startInternButton = CalendarButton(titleText: "시작 일자", image: "defalutcalendar")
    
    let lastInternButton = CalendarButton(titleText: "종료 일자", image: "defalutcalendar")
    
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
    
    let jobPartTextFiedl = profileTextField(
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
    }
    
    
    func setupLayout() {
        addSubview(shadowView)
        shadowView.addSubview(companyText)
        shadowView.addSubview(companyNametextField)
        shadowView.addSubview(workingDateText)
        shadowView.addSubview(activityDateText)
        shadowView.addSubview(deleteButton)
        shadowView.addSubview(startInternButton)
        shadowView.addSubview(jobPartTextFiedl)
        shadowView.addSubview(dividerInDateView)
        shadowView.addSubview(lastInternButton)
        shadowView.addSubview(selectWorking)
        
        validateNextButton()
        companyNametextField.delegate = self
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
        
        jobPartTextFiedl.snp.makeConstraints { make in
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
        print("캘린더 뷰 보임")
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
        print("캘린더 뷰 보임")
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
        
        
    private func SeleceddropdownMenu(for selectButton : UIButton) -> DropdownMenu {
        let collectionViewLayout = UICollectionViewFlowLayout()
        collectionViewLayout.scrollDirection = .vertical
        let dropdownMenu = DropdownMenu(frame: .zero)
        dropdownMenu.backgroundColor = .secondaryYellow
        dropdownMenu.options = categories1
        dropdownMenu.didSelectOption = { selectedOptions in
            let selectedTitles = selectedOptions.joined(separator : " ")
            selectButton.setTitle(selectedTitles, for: .normal)
        }

        return dropdownMenu
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        companyNametextField.layer.borderColor = UIColor.secondaryYellow.cgColor
        validateNextButton()
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        validateNextButton()
        return true
    }
}


extension InternActCollectionViewCell: DropdownButtonDelegate{
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
        let activityName = companyNametextField.text ?? ""
        let activityNameValid = !(activityName.isEmpty)
        
        if activityNameValid == true {
            wholevalid = true
            return wholevalid
        } else {
            wholevalid = false
            return wholevalid
        }
        
    }
    
    func validateNextButton() {
        isBothFieldsFilled = UpDateDatavalidation()
        print("isBothFieldsFilled = \(isBothFieldsFilled)")
        delegateValid?.inputCareerCell(self, didChangeFieldsFilledStatus: isBothFieldsFilled)
    }
}

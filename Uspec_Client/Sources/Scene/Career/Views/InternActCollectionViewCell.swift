//
//  InternActCollectionViewCell.swift
//  Uspec_Client
//
//  Created by 진세진 on 2/16/24.
//

import UIKit

class InternActCollectionViewCell: UICollectionViewCell , UITextFieldDelegate {
    weak var delegate : InputCareerCollectionViewCellDelegate?
    weak var delegateValid : InputCareerValidCheckDelegate?
    var isBothFieldsFilled = false
    
    var categories1 = ["Category 1-1", "Category 1-2", "Category 1-3", "Category 1-4", "Category 1-8","Category 1-5"]
    var categories2 = ["Category 2-1", "Category 2-2", "Category 2-3", "Category 2-4"]
    var categories3 = ["Category 3-1", "Category 3-2", "Category 3-3", "Category 3-4"]
    
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
    
    @objc func deleteButtonTapped() {
        delegate?.inputCareerCellDidRequestDelete(self)
    }
    
    let companyNametextField = profileTextField(
        placeholder: "대외활동 이름",
        fontSize: 15,
        textColor: .textBlack,
        borderColor: UIColor.gray3,
        cornerRadius: 20,
        borderWidth: 1,
        leftPadding: 16,
        rightPadding: -16
    )
    
    let jobPartTextFiedl = profileTextField(
        placeholder: "대외활동 이름",
        fontSize: 15,
        textColor: .textBlack,
        borderColor: UIColor.gray3,
        cornerRadius: 20,
        borderWidth: 1,
        leftPadding: 16,
        rightPadding: -16
    )
    
    private lazy var selectButton1: DropdownButton = {
        let button = DropdownButton()
        button.setupDropdownMenu(options: categories1, selectedvalue: true)
        return button
    }()

    private lazy var selectButton2: DropdownButton = {
        let button = DropdownButton()
        button.setupDropdownMenu(options: categories2, selectedvalue: true)
       return button
    }()
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayout()
    }
    
    func setupLayout() {
        addSubview(companyText)
        addSubview(companyNametextField)
        addSubview(workingDateText)
        addSubview(activityDateText)
        addSubview(deleteButton)
        addSubview(selectButton1)
        addSubview(selectButton2)
        addSubview(jobPartTextFiedl)
        
        validateNextButton()
        companyNametextField.delegate = self
        selectButton1.DropButtondelegate = self
        selectButton2.DropButtondelegate = self
        
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
        
        selectButton1.snp.makeConstraints { make in
            make.top.equalTo(workingDateText.snp.bottom).offset(12)
            make.width.equalTo(303)
            make.height.equalTo(43)
            make.leading.equalToSuperview().offset(20)
        }
        
        
        activityDateText.snp.makeConstraints { make in
            make.top.equalTo(selectButton1.snp.bottom).offset(16)
            make.leading.trailing.equalToSuperview().inset(20)
            make.height.equalTo(21)
        }
        
        jobPartTextFiedl.snp.makeConstraints { make in
            make.top.equalTo(activityDateText.snp.bottom).offset(12)
            make.width.equalTo(303)
            make.height.equalTo(43)
            make.leading.equalToSuperview().offset(20)
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
        
        let activityValid : Bool = selectButton1.isSelectedOption
        let interestingValid : Bool = selectButton2.isSelectedOption
        if activityValid == true &&
            interestingValid == true &&
            activityNameValid == true {
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

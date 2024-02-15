//
//  CompetitionCollectionViewCell.swift
//  Uspec_Client
//
//  Created by 진세진 on 2/15/24.
//

import UIKit
import SnapKit
import Then

protocol InputCareerCollectionViewCellDelegate: AnyObject {
    func inputCareerCellDidRequestDelete(_ cell: UICollectionViewCell)
}

protocol InputCareerValidCheckDelegate: AnyObject {
    func inputCareerCell(_ cell: UICollectionViewCell, didChangeFieldsFilledStatus isFilled: Bool) -> Bool
}

class CompetitionCollectionViewCell: UICollectionViewCell , UITextFieldDelegate {
    weak var delegate : InputCareerCollectionViewCellDelegate?
    weak var delegateValid : InputCareerValidCheckDelegate?
    var isBothFieldsFilled = false
    
    var categories1 = ["Category 1-1", "Category 1-2", "Category 1-3", "Category 1-4", "Category 1-8","Category 1-5"]
    var categories2 = ["Category 2-1", "Category 2-2", "Category 2-3", "Category 2-4"]
    var categories3 = ["Category 3-1", "Category 3-2", "Category 3-3", "Category 3-4"]

    private let nameText = UILabel().then { label in
        label.text = "공모전의 이름을 구체적으로 입력해주세요."
        label.font = UIFont.body1(size: 15)
    }
    
    private let competitionPartText = UILabel().then { label in
        label.text = "공모전의 공모 분야를 모두 정해주세요."
        label.font = UIFont.body1(size: 15)
    }
    
    private let interestsText = UILabel().then { label in
        label.text = "공모전의 시상규모를 선택해주세요."
        label.font = UIFont.body1(size: 15)
    }
    
    private lazy var deleteButton = UIButton().then { button in
        button.setImage(UIImage(named: "delete_Icon"), for: .normal)
        button.addTarget(self, action: #selector(deleteButtonTapped), for: .touchUpInside)
    }
    
    @objc func deleteButtonTapped() {
        delegate?.inputCareerCellDidRequestDelete(self)
    }
    
    let activeNametextField = profileTextField(
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
        button.setupDropdownMenu(options: categories2, selectedvalue: false)
       return button
    }()
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayout()
    }
    
    override func willMove(toSuperview newSuperview: UIView?) {
        super.willMove(toSuperview: newSuperview)
        // 새로운 부모 뷰가 nil이면(화면에서 pop될 때)
        if newSuperview == nil {
            selectButton1.hideDropdownMenu()
            selectButton2.hideDropdownMenu()
        }
    }
    
    func setupLayout() {
        addSubview(nameText)
        addSubview(activeNametextField)
        addSubview(competitionPartText)
        addSubview(interestsText)
        addSubview(deleteButton)
        addSubview(selectButton1)
        addSubview(selectButton2)
        
        activeNametextField.delegate = self
        selectButton1.DropButtondelegate = self
        selectButton2.DropButtondelegate = self
        
        nameText.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(20)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-40)
            make.height.equalTo(21)
        }
        
        deleteButton.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(20)
            make.leading.equalTo(nameText.snp.trailing).offset(10)
            make.width.equalTo(16)
            make.height.equalTo(16)
        }
        
        activeNametextField.snp.makeConstraints { make in
            make.top.equalTo(nameText.snp.bottom).offset(12)
            make.leading.equalToSuperview().inset(20)
            make.width.equalTo(303)
            make.height.equalTo(43)
        }
        
        competitionPartText.snp.makeConstraints { make in
            make.top.equalTo(activeNametextField.snp.bottom).offset(16)
            make.leading.trailing.equalToSuperview().inset(20)
            make.height.equalTo(21)
        }
        
        selectButton1.snp.makeConstraints { make in
            make.top.equalTo(competitionPartText.snp.bottom).offset(12)
            make.width.equalTo(303)
            make.height.equalTo(43)
            make.leading.equalToSuperview().offset(20)
        }
        
        interestsText.snp.makeConstraints { make in
            make.top.equalTo(selectButton1.snp.bottom).offset(16)
            make.leading.trailing.equalToSuperview().inset(20)
            make.height.equalTo(21)
        }
        
        selectButton2.snp.makeConstraints { make in
            make.top.equalTo(interestsText.snp.bottom).offset(12)
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
        activeNametextField.layer.borderColor = UIColor.secondaryYellow.cgColor
        validateNextButton()
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        validateNextButton()
        return true
    }
}

extension CompetitionCollectionViewCell : DropdownButtonDelegate {
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
        let activityName = activeNametextField.text ?? ""
        let activityNameValid = !(activityName.isEmpty)
        print(selectButton1.isSelectedOption)
        print(selectButton2.isSelectedOption)
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



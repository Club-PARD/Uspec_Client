//
//  InputCareerTableViewCell.swift
//  Uspec_Client
//
//  Created by 진세진 on 2/13/24.
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

class InputCareerCollectionViewCell: UICollectionViewCell , UITextFieldDelegate {
    weak var delegate : InputCareerCollectionViewCellDelegate?
    weak var delegateValid : InputCareerValidCheckDelegate?
    private let shadowView = UIView()
    var isBothFieldsFilled = false
    var datas : SeveralOutignActPart?

    let nameText = UILabel().then { label in
        label.text = "대외활동의 이름을 구체적으로 입력해주세요."
        label.font = UIFont.body1(size: 15)
        label.textColor = .gray7
    }
    
    let activityPartText = UILabel().then { label in
        label.text = "대외활동의 활동 분야를 모두 정해주세요."
        label.font = UIFont.body1(size: 15)
        label.textColor = .gray7
    }
    
    let interestsText = UILabel().then { label in
        label.text = "대외활동의 관심분야를 모두 정해주세요."
        label.font = UIFont.body1(size: 15)
        label.textColor = .gray7
    }
    
    let activityDateText = UILabel().then { label in
        label.text = "대외활동의 활동기간을 정해주세요."
        label.font = UIFont.body1(size: 15)
        label.textColor = .gray7
    }
    private lazy var deleteButton = UIButton().then { button in
        button.setImage(UIImage(named: "delete_Icon"), for: .normal) 
        button.addTarget(self, action: #selector(deleteButtonTapped), for: .touchUpInside)
    }
    
    @objc func deleteButtonTapped() {
        selectButton1.hideDropdownMenu()
        selectButton2.hideDropdownMenu()
        selectButton3.hideDropdownMenu()
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
    
    lazy var selectButton1: DropdownButton = {
        let button = DropdownButton()
        button.setupDropdownMenu(options: SelectCategoryInCareer().actingPart, selectedvalue: true)
        return button
    }()

    lazy var selectButton2: DropdownButton = {
        let button = DropdownButton()
        button.setupDropdownMenu(options: SelectCategoryInCareer().inTerestingPart, selectedvalue: true)
       return button
    }()

    lazy var selectButton3: DropdownButton = {
        let button = DropdownButton()
        button.setupDropdownMenu(options: SelectCategoryInCareer().actingDate , selectedvalue: false)
        return button
    }()
    
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
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white
        setupLayout()
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

extension InputCareerCollectionViewCell: DropdownButtonDelegate{
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
        let activityValid : Bool = selectButton1.isSelectedOption
        let interestingValid : Bool = selectButton2.isSelectedOption
        let activityDateValid : Bool = selectButton3.isSelectedOption
        
        return activityValid == true && interestingValid == true && activityDateValid == true && activityNameValid == true
    }
    
    func validateNextButton() {
        isBothFieldsFilled = UpDateDatavalidation()
        delegateValid?.inputCareerCell(self, didChangeFieldsFilledStatus: isBothFieldsFilled)
    }
}

extension InputCareerCollectionViewCell: DropdownMenuDelegate {
    func dropdownMenu(_ dropdownMenu: DropdownMenu, didSelectOption option: String) {
        if dropdownMenu == selectButton3.dropDownMenu {
            datas?.interestDate = option
        }
    }
    
    func dropdownMenu(_ dropdownMenu: DropdownMenu, didSelectOptions options: [String]) {
        if dropdownMenu == selectButton1.dropDownMenu {
            // selectButton1에 대한 처리
            datas?.outingActPart = options
        } else if dropdownMenu == selectButton2.dropDownMenu {
            // selectButton2에 대한 처리
            datas?.interestPart = options
        }
        
        // 선택된 옵션을 확인하고 다른 처리를 수행할 수 있음
        // 예를 들어, validateNextButton()을 호출하여 다른 필수 입력란을 확인할 수 있음
        validateNextButton()
    }
}

extension InputCareerCollectionViewCell {
   
    func setupLayout() {
        addSubview(shadowView)
        shadowView.addSubview(nameText)
        shadowView.addSubview(activeNametextField)
        shadowView.addSubview(activityDateText)
        shadowView.addSubview(activityPartText)
        shadowView.addSubview(interestsText)
        shadowView.addSubview(deleteButton)
        shadowView.addSubview(selectButton1)
        shadowView.addSubview(selectButton2)
        shadowView.addSubview(selectButton3)
        
        
        validateNextButton()
        activeNametextField.delegate = self
        selectButton1.DropButtondelegate = self
        selectButton2.DropButtondelegate = self
        selectButton3.DropButtondelegate = self
        self.setViewShadow(backView: shadowView)
        
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
        
        activityPartText.snp.makeConstraints { make in
            make.top.equalTo(activeNametextField.snp.bottom).offset(16)
            make.leading.trailing.equalToSuperview().inset(20)
            make.height.equalTo(21)
        }
        
        selectButton1.snp.makeConstraints { make in
            make.top.equalTo(activityPartText.snp.bottom).offset(12)
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
        
        activityDateText.snp.makeConstraints { make in
            make.top.equalTo(selectButton2.snp.bottom).offset(16)
            make.leading.trailing.equalToSuperview().inset(20)
            make.height.equalTo(21)
        }
        
        selectButton3.snp.makeConstraints { make in
            make.top.equalTo(activityDateText.snp.bottom).offset(12)
            make.width.equalTo(303)
            make.height.equalTo(43)
            make.leading.equalToSuperview().offset(20)
        }
        shadowView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }

}


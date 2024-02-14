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
    func inputCareerCell(_ cell: InputCareerCollectionViewCell, didChangeFieldsFilledStatus isFilled: Bool) -> Bool
}

class InputCareerCollectionViewCell: UICollectionViewCell , UITextFieldDelegate{
    
    weak var delegate : InputCareerCollectionViewCellDelegate?
//    override func delete(_ sender: Any?) {
//        <#code#>
//    }
    var isBothFieldsFilled = false
    var categories1 = ["Category 1-1", "Category 1-2", "Category 1-3", "Category 1-4", "Category 1-8","Category 1-5"]
    var categories2 = ["Category 2-1", "Category 2-2", "Category 2-3", "Category 2-4"]
    var categories3 = ["Category 3-1", "Category 3-2", "Category 3-3", "Category 3-4"]
    
    private let nameText = UILabel().then { label in
        label.text = "대외활동의 이름을 구체적으로 입력해주세요."
        label.font = UIFont.body1(size: 15)
    }
    
    private let activityPartText = UILabel().then { label in
        label.text = "대외활동의 활동 분야를 모두 정해주세요."
        label.font = UIFont.body1(size: 15)
    }
    
    private let interestsText = UILabel().then { label in
        label.text = "대외활동의 관심분야를 모두 정해주세요."
        label.font = UIFont.body1(size: 15)
    }
    
    private let activityDateText = UILabel().then { label in
        label.text = "대외활동의 활동기간을 정해주세요."
        label.font = UIFont.body1(size: 15)
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
        button.setupDropdownMenu(options: categories1)
        return button
    }()

    private lazy var selectButton2: DropdownButton = {
        let button = DropdownButton()
        button.setupDropdownMenu(options: categories2)
       return button
    }()

    private lazy var selectButton3: DropdownButton = {
        let button = DropdownButton()
        button.setupDropdownMenu(options: categories3)
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
        addSubview(nameText)
        addSubview(activeNametextField)
        addSubview(activityDateText)
        addSubview(activityPartText)
        addSubview(interestsText)
        addSubview(selectButton1)
        addSubview(selectButton2)
        addSubview(selectButton3)
        
        activeNametextField.delegate = self
        nameText.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(20)
            make.leading.trailing.equalToSuperview().inset(20)
            make.height.equalTo(21)
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
    }
}

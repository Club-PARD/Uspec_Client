//
//  InputCareerTableViewCell.swift
//  Uspec_Client
//
//  Created by 진세진 on 2/13/24.
//

import UIKit
import SnapKit
import Then

class InputCareerCollectionViewCell: UICollectionViewCell {
    var isDropdownMenu1Visible = false
    var isDropdownMenu2Visible = false
    var isDropdownMenu3Visible = false
    
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
    
    private let activeNametextField = UITextField().then { text in
        text.font = UIFont.body1()
        text.placeholder = "대외활동 이름"
        text.layer.cornerRadius = 20
        text.layer.borderWidth = 1
        text.layer.borderColor = UIColor.gray3.cgColor

    }

    private lazy var dropdownMenu1: DropdownMenu = {
        return SeleceddropdownMenu(for : selectButton1)
    }()
    
    private lazy var dropdownMenu2: DropdownMenu = {
        return SeleceddropdownMenu(for : selectButton2)
    }()
    
    private lazy var dropdownMenu3: DropdownMenu = {
        return SeleceddropdownMenu(for : selectButton3)
    }()
    
    private func ButtonShareAttribute(for button : UIButton) {
        button.setTitle("선택하기", for: .normal)
        button.titleLabel?.font = UIFont.body1()
        button.setTitleColor(.gray2, for: .normal)
        button.layer.cornerRadius = 20
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.gray2.cgColor
        button.contentHorizontalAlignment = .left
        button.titleEdgeInsets = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 0)
    }
    
    private lazy var selectButton1 = UIButton().then { button in
        ButtonShareAttribute(for : button)
        button.addTarget(self, action: #selector(showDropdownMenu1), for: .touchUpInside)
    }
    
    private lazy var selectButton2 = UIButton().then { button in
        ButtonShareAttribute(for : button)
        button.addTarget(self, action: #selector(showDropdownMenu2), for: .touchUpInside)
    }
    
    private lazy var selectButton3 = UIButton().then { button in
        ButtonShareAttribute(for : button)
        button.addTarget(self, action: #selector(showDropdownMenu3), for: .touchUpInside)
    }
    
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
        addSubview(dropdownMenu1)
        addSubview(dropdownMenu2)
        addSubview(dropdownMenu3)
        
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
        
        dropdownMenu1.snp.makeConstraints { make in
            make.top.equalTo(selectButton1.snp.bottom).offset(10)
            make.leading.trailing.equalToSuperview().inset(20)
            make.height.equalTo(0)
        }
        
        dropdownMenu2.snp.makeConstraints { make in
            make.top.equalTo(selectButton2.snp.bottom).offset(10)
            make.leading.trailing.equalToSuperview().inset(20)
            make.height.equalTo(0)
        }
        
        dropdownMenu3.snp.makeConstraints { make in
            make.top.equalTo(selectButton3.snp.bottom).offset(10)
            make.leading.trailing.equalToSuperview().inset(20)
            make.height.equalTo(0)
        }
    }

    @objc private func showDropdownMenu1() {
        isDropdownMenu1Visible.toggle()
        showDropdownMenu(for: isDropdownMenu1Visible, with: dropdownMenu1)
    }
    
    @objc private func showDropdownMenu2() {
        isDropdownMenu2Visible.toggle()
        showDropdownMenu(for: isDropdownMenu2Visible, with: dropdownMenu2)
    }
    
    @objc private func showDropdownMenu3() {
        isDropdownMenu3Visible.toggle()
        showDropdownMenu(for: isDropdownMenu3Visible, with: dropdownMenu3)
    }
    
    private func showDropdownMenu(for isDropdownVisble : Bool ,with dropdownMenu : DropdownMenu) {
        UIView.animate(withDuration: 0.3) { [weak self] in
            if isDropdownVisble {
                    dropdownMenu.snp.updateConstraints { make in
                        make.height.equalTo(dropdownMenu.collectionViewLayout.collectionViewContentSize.height)
                    }
                } else {
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
        let dropdownMenu = DropdownMenu(frame: .zero, collectionViewLayout: collectionViewLayout)
        dropdownMenu.backgroundColor = .secondaryYellow
        dropdownMenu.options = categories1
        dropdownMenu.didSelectOption = { selectedoption in
            let selectedTitles = selectedoption.joined(separator : ",")
            selectButton.setTitle(selectedTitles, for: .normal)
        }
        return dropdownMenu
    }
}

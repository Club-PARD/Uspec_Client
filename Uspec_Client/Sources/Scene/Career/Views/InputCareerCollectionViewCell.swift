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
        label.font = UIFont.body1()
    }
    
    private let activityPartText = UILabel().then { label in
        label.text = "대외활동의 활동 분야를 모두 정해주세요."
        label.font = UIFont.body1()
    }
    
    private let interestsText = UILabel().then { label in
        label.text = "대외활동의 관심분야를 모두 정해주세요."
        label.font = UIFont.body1()
    }
    
    private let activityDateText = UILabel().then { label in
        label.text = "대외활동의 활동기간을 정해주세요."
        label.font = UIFont.body1()
    }
    
    private let activeNametextField = UITextField().then { text in
        text.font = UIFont.body1()
        text.placeholder = "대외활동 이름"
        text.layer.cornerRadius = 20
        text.layer.borderWidth = 1
        text.layer.borderColor = UIColor.gray3.cgColor

    }
    
    // Dropdown menus
    private lazy var dropdownMenu1: DropdownMenu = {
        let collectionViewLayout = UICollectionViewFlowLayout()
        collectionViewLayout.scrollDirection = .vertical
        let dropdownMenu = DropdownMenu(frame: .zero, collectionViewLayout: collectionViewLayout)
        dropdownMenu.backgroundColor = .secondaryYellow
        dropdownMenu.options = categories1
        dropdownMenu.didSelectOption = { [weak self] selectedoption in
            let selectedTitles = selectedoption.joined(separator : ",")
            self?.selectButton1.setTitle(selectedTitles, for: .normal)
        }
        return dropdownMenu
    }()
    
    private lazy var dropdownMenu2: DropdownMenu = {
        let collectionViewLayout = UICollectionViewFlowLayout()
        collectionViewLayout.scrollDirection = .vertical
        let dropdownMenu = DropdownMenu(frame: .zero, collectionViewLayout: collectionViewLayout)
        dropdownMenu.backgroundColor = .secondaryYellow
        dropdownMenu.options = categories2
        dropdownMenu.didSelectOption = { [weak self] selectedOptions in
            let selectedTitles = selectedOptions.joined(separator: ", ")
            self?.selectButton2.setTitle(selectedTitles, for: .normal)
        }
        return dropdownMenu
    }()
    
    private lazy var dropdownMenu3: DropdownMenu = {
        let collectionViewLayout = UICollectionViewFlowLayout()
        collectionViewLayout.scrollDirection = .vertical
        let dropdownMenu = DropdownMenu(frame: .zero, collectionViewLayout: collectionViewLayout)
        dropdownMenu.backgroundColor = .secondaryYellow
        dropdownMenu.options = categories3
        dropdownMenu.didSelectOption = { [weak self] selectedoption in
            let selectedTitles = selectedoption.joined(separator : ",")
            self?.selectButton3.setTitle(selectedTitles, for: .normal)
        }
        return dropdownMenu
    }()

    private lazy var selectButton1: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Select Category 1", for: .normal)
        button.addTarget(self, action: #selector(showDropdownMenu1), for: .touchUpInside)
        return button
    }()
    
    private lazy var selectButton2: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Select Category 2", for: .normal)
        button.addTarget(self, action: #selector(showDropdownMenu2), for: .touchUpInside)
        return button
    }()
    
    private lazy var selectButton3: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Select Category 3", for: .normal)
        button.addTarget(self, action: #selector(showDropdownMenu3), for: .touchUpInside)
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
        addSubview(dropdownMenu1)
        addSubview(dropdownMenu2)
        addSubview(dropdownMenu3)
        
        nameText.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(10)
            make.leading.equalToSuperview().offset(20)
        }
        
        activeNametextField.snp.makeConstraints { make in
            make.top.equalTo(nameText.snp.bottom).offset(10)
            make.leading.trailing.equalToSuperview().inset(20)
            make.height.equalTo(40)
        }
        
        activityPartText.snp.makeConstraints { make in
            make.top.equalTo(activeNametextField.snp.bottom).offset(10)
            make.leading.trailing.equalToSuperview().inset(20)
            make.height.equalTo(40)
        }
        
        selectButton1.snp.makeConstraints { make in
            make.top.equalTo(activityPartText.snp.bottom).offset(15)
            make.centerX.equalToSuperview()
        }
        
        interestsText.snp.makeConstraints { make in
            make.top.equalTo(selectButton1.snp.bottom).offset(20)
            make.leading.trailing.equalToSuperview().inset(20)
            make.height.equalTo(40)
        }
        
        selectButton2.snp.makeConstraints { make in
            make.top.equalTo(interestsText.snp.bottom).offset(20)
            make.centerX.equalToSuperview()
        }
        
        activityDateText.snp.makeConstraints { make in
            make.top.equalTo(selectButton2.snp.bottom).offset(20)
            make.leading.trailing.equalToSuperview().inset(20)
            make.height.equalTo(40) // height 제약 추가
        }
        
        selectButton3.snp.makeConstraints { make in
            make.top.equalTo(activityDateText.snp.bottom).offset(20) // activityDateText와 연결
            make.centerX.equalToSuperview()
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
        UIView.animate(withDuration: 0.3) { [weak self] in
            if self?.isDropdownMenu1Visible ?? false {
                self?.dropdownMenu1.snp.updateConstraints { make in
                    make.height.equalTo(self?.dropdownMenu1.collectionViewLayout.collectionViewContentSize.height ?? 0)
                }
            } else {
                self?.dropdownMenu1.snp.updateConstraints { make in
                    make.height.equalTo(0)
                }
            }
            self?.layoutIfNeeded()
        }
    }
    
    @objc private func showDropdownMenu2() {
        isDropdownMenu2Visible.toggle()
        UIView.animate(withDuration: 0.3) { [weak self] in
            if self?.isDropdownMenu2Visible ?? false {
                self?.dropdownMenu2.snp.updateConstraints { make in
                    make.height.equalTo(self?.dropdownMenu2.collectionViewLayout.collectionViewContentSize.height ?? 0)
                }
            } else {
                self?.dropdownMenu2.snp.updateConstraints { make in
                    make.height.equalTo(0)
                }
            }
            self?.layoutIfNeeded()
        }
    }
    
    @objc private func showDropdownMenu3() {
        isDropdownMenu3Visible.toggle()
        UIView.animate(withDuration: 0.3) { [weak self] in
            if self?.isDropdownMenu3Visible ?? false {
                    self?.dropdownMenu3.snp.updateConstraints { make in
                        make.height.equalTo(self?.dropdownMenu3.collectionViewLayout.collectionViewContentSize.height ?? 0)
                    }
                } else {
                    self?.dropdownMenu3.snp.updateConstraints { make in
                        make.height.equalTo(0)
                    }
                }
                self?.layoutIfNeeded()
        }
    }
}

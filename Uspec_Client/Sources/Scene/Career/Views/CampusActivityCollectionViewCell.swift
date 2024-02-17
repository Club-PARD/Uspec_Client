//
//  CampusActivityCollectionViewCell.swift
//  Uspec_Client
//
//  Created by 진세진 on 2/17/24.
//

import UIKit
import SnapKit
import Then

class CampusActivityCollectionViewCell: UICollectionViewCell , UITextFieldDelegate {
    weak var delegate : InputCareerCollectionViewCellDelegate?
    weak var delegateValid : InputCareerValidCheckDelegate?
    var isBothFieldsFilled = false
    private let shadowView = UIView()
    var datas : SeveralCompetitionPart?
    
    private let nameText = UILabel().then { label in
        label.text = "교내활동의 이름을 구체적으로 입력해주세요."
        label.font = UIFont.body1(size: 15)
    }
    
    private let campusActPartText = UILabel().then { label in
        label.text = "교내활동의 활동 분야를 설정해주세요."
        label.font = UIFont.body1(size: 15)
    }
    
    private let actingContentText = UILabel().then { label in
        label.text = "세부적인 활동 내용을 설명해주세요."
        label.font = UIFont.body1(size: 15)
    }
    
    private let actingContentTextField = profileTextField (
        placeholder: "활동 내용 설명",
        fontSize: 15,
        textColor: .textBlack,
        borderColor: UIColor.gray3,
        cornerRadius: 20,
        borderWidth: 1,
        leftPadding: 16,
        rightPadding: -16
    )
    
    private lazy var deleteButton = UIButton().then { button in
        button.setImage(UIImage(named: "delete_Icon"), for: .normal)
        button.addTarget(self, action: #selector(deleteButtonTapped), for: .touchUpInside)
    }
    
    @objc func deleteButtonTapped() {
        delegate?.inputCareerCellDidRequestDelete(self)
    }
    
    let activeNametextField = profileTextField(
        placeholder: "교내활동 이름",
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
        button.setupDropdownMenu(options: SelectCategoryInCareer().campushActivities, selectedvalue: true)
        return button
    }()

    private lazy var selectButton2: DropdownButton = {
        let button = DropdownButton()
        button.setupDropdownMenu(options: SelectCategoryInCareer().actingDate , selectedvalue: false)
       return button
    }()
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        setupLayout()
        self.setViewShadow(backView: self)
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
        addSubview(shadowView)
        shadowView.addSubview(nameText)
        shadowView.addSubview(activeNametextField)
        shadowView.addSubview(campusActPartText)
        shadowView.addSubview(actingContentText)
        shadowView.addSubview(deleteButton)
        shadowView.addSubview(selectButton1)
        shadowView.addSubview(actingContentTextField)
        
        activeNametextField.delegate = self
        selectButton1.DropButtondelegate = self
        
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
        
        campusActPartText.snp.makeConstraints { make in
            make.top.equalTo(activeNametextField.snp.bottom).offset(16)
            make.leading.trailing.equalToSuperview().inset(20)
            make.height.equalTo(21)
        }
        
        selectButton1.snp.makeConstraints { make in
            make.top.equalTo(campusActPartText.snp.bottom).offset(12)
            make.width.equalTo(303)
            make.height.equalTo(43)
            make.leading.equalToSuperview().offset(20)
        }
        
        actingContentText.snp.makeConstraints { make in
            make.top.equalTo(selectButton1.snp.bottom).offset(16)
            make.leading.trailing.equalToSuperview().inset(20)
            make.height.equalTo(21)
        }
        actingContentTextField.snp.makeConstraints { make in
            make.top.equalTo(actingContentText.snp.bottom).offset(12)
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
        
    func textFieldDidBeginEditing(_ textField: UITextField) {
        activeNametextField.layer.borderColor = UIColor.secondaryYellow.cgColor
        validateNextButton()
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        validateNextButton()
        return true
    }
}

extension CampusActivityCollectionViewCell : DropdownButtonDelegate {
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
        delegateValid?.inputCareerCell(self, didChangeFieldsFilledStatus: isBothFieldsFilled)
    }
}

// MARK: - 드랍다운에서 선택한 데이터 전달!! 부분

extension CampusActivityCollectionViewCell: DropdownMenuDelegate {
    
    func dropdownMenu(_ dropdownMenu: DropdownMenu, didSelectOption option: String) {
        if dropdownMenu == selectButton2.dropDownMenu {
            datas?.awardScalePart = option
        }
        validateNextButton()
    }
    
    func dropdownMenu(_ dropdownMenu: DropdownMenu, didSelectOptions options: [String]) {
        if dropdownMenu == selectButton1.dropDownMenu {
            // selectButton1에 대한 처리
            datas?.competitionPart = options
        }
        validateNextButton()
    }
}

//
//  CertifivateCollectionViewCell.swift
//  Uspec_Client
//
//  Created by 진세진 on 2/16/24.
//

import UIKit

class CertifivateCollectionViewCell: UICollectionViewCell ,UITextFieldDelegate {
    weak var delegate : InputCareerCollectionViewCellDelegate?
    weak var delegateValid : InputCareerValidCheckDelegate?
    var isBothFieldsFilled = false
    private let shadowView = UIView()
    
    var categories1 = ["Category 1-1", "Category 1-2", "Category 1-3", "Category 1-4", "Category 1-8","Category 1-5"]
    var categories2 = ["Category 2-1", "Category 2-2", "Category 2-3", "Category 2-4"]
    var categories3 = ["Category 3-1", "Category 3-2", "Category 3-3", "Category 3-4"]
    
    private let certifiCateNameText = UILabel().then { label in
        label.text = "짱구님의 자격증 취득 내역을 입력해주세요."
        label.font = UIFont.body1(size: 15)
    }
    
    private let gettingCertificateDateText = UILabel().then { label in
        label.text = "자격증 취득 일자를 선택해주세요."
        label.font = UIFont.body1(size: 15)
    }
    
    let Calderbutton = CertificationCalendarButton(titleText: "취득일자", image: "defalutcalendar")
    
    private lazy var deleteButton = UIButton().then { button in
        button.setImage(UIImage(named: "delete_Icon"), for: .normal)
        button.addTarget(self, action: #selector(deleteButtonTapped), for: .touchUpInside)
    }
    
    @objc func deleteButtonTapped() {
        delegate?.inputCareerCellDidRequestDelete(self)
    }
    
    let CertificateTextField = profileTextField(
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
    }
    
    func setupLayout() {
        addSubview(shadowView)
        shadowView.addSubview(certifiCateNameText)
        shadowView.addSubview(CertificateTextField)
        shadowView.addSubview(gettingCertificateDateText)
        shadowView.addSubview(deleteButton)
        shadowView.addSubview(Calderbutton)
        
        validateNextButton()
        CertificateTextField.delegate = self
        
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
        
        Calderbutton.snp.makeConstraints { make in
            make.top.equalTo(gettingCertificateDateText.snp.bottom).offset(12)
            make.leading.equalToSuperview().offset(20)
            make.width.equalTo(303)
            make.height.equalTo(43)
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
        let activityNameValid = !(activityName.isEmpty)
        if  activityNameValid == true {
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

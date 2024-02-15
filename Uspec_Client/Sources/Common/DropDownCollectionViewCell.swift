//
//  CollectionViewCell.swift
//  Uspec_Client
//
//  Created by 진세진 on 2/15/24.
//

import UIKit
import Then
import SnapKit

class DropDownCollectionViewCell: UICollectionViewCell {
    private let categoryLabel = UILabel().then { label in
        label.font = UIFont.body3(size: 13)
        label.layer.cornerRadius = 15
        label.layer.borderWidth = 1
        label.clipsToBounds = true
        label.sizeToFit()
        label.textAlignment = .center
    
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayout()
        layer.cornerRadius = contentView.layer.cornerRadius
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
       
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setupLayout()
    }
        
    private func setupLayout() {
        if categoryLabel.superview == nil {
            addSubview(categoryLabel)
            categoryLabel.snp.makeConstraints { make in
                make.edges.equalToSuperview()
            }
        }
    }
    
    func configureIncategory(with text : String, isSelected isSelectedCell : Bool) {
        categoryLabel.text = text
        categoryLabel.textColor = .gray3
        if isSelectedCell {
            categoryLabel.backgroundColor = .secondaryYellow
            categoryLabel.textColor = .white
            categoryLabel.layer.borderColor = UIColor.secondaryYellow.cgColor
        } else {
            categoryLabel.backgroundColor = .white
            categoryLabel.textColor = .gray3
            categoryLabel.layer.borderColor = UIColor.gray3.cgColor
        }
                
    }
}




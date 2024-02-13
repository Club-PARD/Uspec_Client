//
//  CollectionViewCell.swift
//  Uspec_Client
//
//  Created by 진세진 on 2/14/24.
//

import UIKit


class AddActivityCollectionViewCell: UICollectionViewCell {
    private let titleLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(title: String) {
        titleLabel.text = title
    }
}


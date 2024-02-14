//
//  CollectionViewCell.swift
//  Uspec_Client
//
//  Created by 진세진 on 2/14/24.
//

import UIKit
import Then
import SnapKit

class AddActivityCollectionViewCell: UICollectionViewCell {
    private let titleLabel = UILabel()
    
    private let plusimageView = UIImageView().then { image in
        image.image = UIImage(systemName: "plus")
        image.tintColor = .gray4
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUplayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(title: String) {
        titleLabel.text = title
    }
    
    func setUplayout() {
        addSubview(titleLabel)
        addSubview(plusimageView)
        
        titleLabel.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
        plusimageView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.trailing.equalTo(titleLabel.snp.leading).offset(-12)
        }
    }
}


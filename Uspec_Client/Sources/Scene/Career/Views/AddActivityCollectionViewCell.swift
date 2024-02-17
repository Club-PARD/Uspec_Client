//
//  CollectionViewCell.swift
//  Uspec_Client
//
//  Created by 진세진 on 2/14/24.
//

import UIKit

class AddActivityCollectionViewCell: UICollectionViewCell {
    private let titleLabel = UILabel()
    private let shadowView = UIView()
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
        addSubview(shadowView)
        self.backgroundColor = .white
        self.layer.cornerRadius = 20
        self.layer.borderColor = UIColor.gray3.cgColor
        self.layer.borderWidth = 1
        
        shadowView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        titleLabel.textColor = .gray4
        titleLabel.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
        plusimageView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.trailing.equalTo(titleLabel.snp.leading).offset(-12)
        }
        
        setViewShadow(backView: shadowView)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder() // 키보드 내리기
        return true
    }
}



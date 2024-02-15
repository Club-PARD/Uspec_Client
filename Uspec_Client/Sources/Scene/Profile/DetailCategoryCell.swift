//
//  DetailCategoryCell.swift
//  Uspec_Client
//
//  Created by 김하람 on 2/15/24.
//

import UIKit

class DetailCategoryCell: UITableViewCell {
    let checkBoxButton = UIButton()
    let textlabel = UILabel()
    var isCheck: Bool = true {
        didSet {
            let imageName = isCheck ? "selected" : "unSelected"
            checkBoxButton.setImage(UIImage(named: imageName), for: .normal)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: "detailCell")
        contentView.addSubview(checkBoxButton)
        contentView.addSubview(textlabel)
        setCheckIcon()
        setUplabel()

    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        isCheck.toggle()
    }
    
    func setUplabel() {
        textlabel.font = .body1(size: 15)
        textlabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalTo(checkBoxButton.snp.trailing).offset(10)
            make.trailing.equalTo(-10)
        }
    }

    func setCheckIcon() {
        checkBoxButton.snp.makeConstraints { make in
            make.leading.equalTo(16)
            make.leftMargin.equalTo(10)
            make.width.equalTo(20)
            make.height.equalTo(20)
            make.top.equalTo(13)
        }
    }
}

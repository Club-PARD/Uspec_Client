//
//  TopCategoryTableView.swift
//  Uspec_Client
//
//  Created by 김하람 on 2/15/24.
//

import UIKit

class TopCategoryCell: UITableViewCell {
    let textlabel = UILabel()
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: "topCell")
        contentView.addSubview(textlabel)
        setUplabel()
    }
    
    func setUplabel(){
        textlabel.font = .body1(size: 15)
        textlabel.textColor = .gray7
        textlabel.snp.makeConstraints{ make in
            make.top.equalTo(10)
            make.left.equalTo(16)
        }
    }
}

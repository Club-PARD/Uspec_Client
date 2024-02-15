//
//  DetailCategoryCell.swift
//  Uspec_Client
//
//  Created by 김하람 on 2/15/24.
//

import UIKit

class DetailCategoryCell: UITableViewCell {
    let textlabel = UILabel()
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: "detailCell")
        contentView.addSubview(textlabel)
        setUplabel()
    }
    
    func setUplabel(){
        textlabel.textColor = .gray5
        textlabel.font = .body1(size: 15)
        textlabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            textlabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            textlabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 1)
        ])
    }
}


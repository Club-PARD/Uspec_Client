//
//  CommonViewController.swift
//  Uspec_Client
//
//  Created by 김하람 on 2/9/24.
//

import UIKit
import SnapKit

class NextButton: UIButton {
    
    init(backgroundColor: UIColor, titleText: String, left: CGFloat, right: CGFloat, bottom: CGFloat) {
        super.init(frame: .zero)
        self.backgroundColor = backgroundColor
        self.setTitle(titleText, for: .normal)
        setupButton(left: left, right: right, bottom: bottom)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupButton(left: CGFloat, right: CGFloat, bottom: CGFloat) {
        self.snp.makeConstraints { make in
            make.leftMargin.equalTo(left)
            make.rightMargin.equalTo(right)
            make.bottomMargin.equalTo(bottom)
        }
    }
    
}

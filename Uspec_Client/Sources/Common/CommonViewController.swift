//
//  CommonViewController.swift
//  Uspec_Client
//
//  Created by 김하람 on 2/9/24.
//

import UIKit
import SnapKit

class NextButton: UIButton {
    
    init(backgroundColor: UIColor, titleText: String) {
        super.init(frame: .zero)
        self.backgroundColor = backgroundColor
        self.setTitle(titleText, for: .normal)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

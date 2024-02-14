//
//  CommonViewController.swift
//  Uspec_Client
//
//  Created by 김하람 on 2/9/24.
//

import UIKit
import SnapKit

class NextButton: UIButton {
    
    init(titleText: String) {
        super.init(frame: .zero)
        self.setTitle(titleText, for: .normal)
        self.titleLabel?.font = UIFont.body1(size: 15)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class NormalButton: UIButton {
    
    init(titleText: String) {
        super.init(frame: .zero)
        self.setTitle(titleText, for: .normal)
        self.titleLabel?.font = UIFont.body1(size: 15)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

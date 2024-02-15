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

class DoneButton: UIButton {
    
    init(titleText: String) {
        super.init(frame: .zero)
        self.setTitle(titleText, for: .normal)
        self.setTitleColor(UIColor.black, for: .normal)
        self.titleLabel?.font = UIFont.body1()
        self.layer.borderColor = UIColor.gray3.cgColor
        self.layer.cornerRadius = 4
        self.layer.borderWidth = 1
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

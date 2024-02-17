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

class CalendarButton: UIButton {
    init(titleText: String, image : String) {
        super.init(frame: .zero)
        self.setTitle(titleText, for: .normal)
        self.setImage(UIImage(named: image), for: .normal)
        self.titleLabel?.font = UIFont.body1(size: 15)
        self.layer.borderColor = UIColor.gray3.cgColor
        self.layer.cornerRadius = 20
        self.layer.borderWidth = 1
        self.semanticContentAttribute = .forceRightToLeft
        self.imageEdgeInsets = UIEdgeInsets(top: 0, left: 8, bottom: 0, right: -8)
        self.titleEdgeInsets = UIEdgeInsets(top: 0, left: -8, bottom: 0, right: 8)
       
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class CertificationCalendarButton: UIButton {
    init(titleText: String, image : String) {
        super.init(frame: .zero)
        self.setTitle(titleText, for: .normal)
        self.setImage(UIImage(named: image), for: .normal)
        self.titleLabel?.font = UIFont.body1(size: 15)
        self.layer.borderColor = UIColor.gray3.cgColor
        self.layer.cornerRadius = 20
        self.layer.borderWidth = 1
        self.semanticContentAttribute = .forceRightToLeft
        self.imageEdgeInsets = UIEdgeInsets(top: 0, left: 95, bottom: 0, right: -95)
        self.titleEdgeInsets = UIEdgeInsets(top: 0, left: -95, bottom: 0, right: 95)
       
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

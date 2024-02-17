//
//  TextFieldComp.swift
//  Uspec_Client
//
//  Created by 김하람 on 2/14/24.
//

import UIKit

class profileFieldLabel: UILabel {
    init(text: String, fontSize: CGFloat, textColor: UIColor) {
        super.init(frame: .zero)
        self.text = text
        self.font = .body1(size: fontSize)
        self.textColor = textColor
        self.translatesAutoresizingMaskIntoConstraints = false
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class profileTextField: UITextField, UITextFieldDelegate {
    init(placeholder: String, fontSize: CGFloat, textColor: UIColor, borderColor: UIColor, cornerRadius: CGFloat, borderWidth: CGFloat, leftPadding: CGFloat, rightPadding: CGFloat) {
        super.init(frame: .zero)
        self.font = .body1(size: fontSize)
        self.textColor = textColor
        self.placeholder = placeholder
        self.layer.cornerRadius = cornerRadius
        self.layer.borderWidth = borderWidth
        self.layer.borderColor = borderColor.cgColor
        self.setPlaceholder(color: .gray4)
        self.addLeftPadding(width: leftPadding)
        self.addRightPadding(width: rightPadding)
        self.autocorrectionType = .no
        self.spellCheckingType = .no
        self.translatesAutoresizingMaskIntoConstraints = false
        self.autocorrectionType = .no
        self.spellCheckingType = .no
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

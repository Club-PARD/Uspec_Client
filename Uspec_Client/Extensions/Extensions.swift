//
//  Extensions.swift
//  Uspec_Client
//
//  Created by 김하람 on 2/14/24.
//

import UIKit

extension UILabel {
    func setTextWithLineHeight(text: String?, lineHeight: CGFloat) {
        if let text = text {
            let style = NSMutableParagraphStyle()
            style.maximumLineHeight = lineHeight
            style.minimumLineHeight = lineHeight
            
            let attributes: [NSAttributedString.Key: Any] = [
            .paragraphStyle: style,
            .baselineOffset: (lineHeight - font.lineHeight) / 4 // 추가!!️️🤟
            ]
                
            let attrString = NSAttributedString(string: text,
                                                attributes: attributes)
            self.attributedText = attrString
        }
    }
}

extension UITextField {
    func setPlaceholder(color: UIColor) {
        guard let string = self.placeholder else {
            return
        }
        attributedPlaceholder = NSAttributedString(string: string, attributes: [.foregroundColor: color])
    }
}

extension UITextField {
    func addLeftPadding(width: CGFloat) {
    let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: width, height: self.frame.height))
    self.leftView = paddingView
    self.leftViewMode = ViewMode.always
  }
}

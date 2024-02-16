//
//  UIViewExtension.swift
//  Uspec_Client
//
//  Created by 진세진 on 2/15/24.
//
import UIKit

extension UIView {
    
    var windowFrame: CGRect? {
        return superview?.convert(frame, to: nil)
    }
    
}


extension UIView {
    func setViewShadow(backView: UIView) {
        backView.layer.masksToBounds = true
        backView.layer.cornerRadius = 20
        backView.layer.borderWidth = 1
        backView.layer.borderColor = UIColor.clear.cgColor
        
        layer.masksToBounds = false
        layer.shadowOpacity = 1
        layer.shadowColor = UIColor.gray3.cgColor
        layer.shadowOffset = CGSize(width: 0, height: 4)
        layer.shadowRadius = 14
        layer.shadowPath = UIBezierPath(rect: CGRect(x: 0,
                                                         y: bounds.maxY - layer.shadowRadius,
                                                         width: bounds.width,
                                                         height: layer.shadowRadius)).cgPath
    }
}


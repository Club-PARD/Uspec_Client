//
//  UIFont+.swift
//  Uspec_Client
//
//  Created by 진세진 on 2/13/24.
//
import UIKit

extension UIFont {
    static func header0(size fontSize: CGFloat = 32.0) -> UIFont {
            let familyName = "AppleSDGothicNeoR"
            return UIFont(name: "\(familyName)", size: fontSize) ?? .systemFont(ofSize: fontSize)
    }
    
    static func header1(size fontSize: CGFloat = 26.0) -> UIFont {
            let familyName = "AppleSDGothicNeoR"
            return UIFont(name: "\(familyName)", size: fontSize) ?? .systemFont(ofSize: fontSize)
    }
    
    static func header2(size fontSize: CGFloat = 20.0) -> UIFont {
            let familyName = "AppleSDGothicNeoR"
            return UIFont(name: "\(familyName)", size: fontSize) ?? .systemFont(ofSize: fontSize)
    }
    
    static func header3(size fontSize: CGFloat = 18.0) -> UIFont {
            let familyName = "AppleSDGothicNeoB"
        return UIFont(name: "\(familyName)", size: fontSize) ?? .systemFont(ofSize: fontSize)
    }
    
    static func header4(size fontSize: CGFloat = 15.0) -> UIFont {
            let familyName = "AppleSDGothicNeoB"
            return UIFont(name: "\(familyName)", size: fontSize) ?? .systemFont(ofSize: fontSize)
    }
    
    static func body0(size fontSize: CGFloat = 15.0) -> UIFont {
            let familyName = "AppleSDGothicNeoR"
            return UIFont(name: "\(familyName)", size: fontSize) ?? .systemFont(ofSize: fontSize)
    }
    
    static func body1(size fontSize: CGFloat = 15.0) -> UIFont {
            let familyName = "AppleSDGothicNeoR"
            return UIFont(name: "\(familyName)", size: fontSize) ?? .systemFont(ofSize: fontSize)
    }
    
    static func body2(size fontSize: CGFloat = 14.0) -> UIFont {
            let familyName = "AppleSDGothicNeoR"
            return UIFont(name: "\(familyName)", size: fontSize) ?? .systemFont(ofSize: fontSize)
    }
    
    static func body3(size fontSize: CGFloat = 13.0) -> UIFont {
            let familyName = "AppleSDGothicNeoR"
            return UIFont(name: "\(familyName)", size: fontSize) ?? .systemFont(ofSize: fontSize)
    }
    
    static func caption1(size fontSize: CGFloat = 12.0) -> UIFont {
            let familyName = "AppleSDGothicNeoR"
            return UIFont(name: "\(familyName)", size: fontSize) ?? .systemFont(ofSize: fontSize)
    }
    
    static func caption2(size fontSize: CGFloat = 11.0) -> UIFont {
            let familyName = "AppleSDGothicNeoR"
            return UIFont(name: "\(familyName)", size: fontSize) ?? .systemFont(ofSize: fontSize)
    }

}

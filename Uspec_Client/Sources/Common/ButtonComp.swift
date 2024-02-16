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
        self.setTitleColor(UIColor.gray, for: .normal)
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

cclass CertificationCalendarButton: UIButton {
    init(titleText: String, image : String) {
        super.init(frame: .zero)
        self.setTitle(titleText, for: .normal)
        self.setImage(UIImage(named: image), for: .normal)
        self.setTitleColor(UIColor.gray, for: .normal)
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
class SpecRankingCard: UIView {
    var userID = 0
    
    init(nameText: String, numIndex: Int, activityNum: Int, semester: Int) {
        super.init(frame: .zero)
        self.backgroundColor = UIColor(red: 255, green: 255, blue: 255, alpha: 0.7)
        self.layer.cornerRadius = 30
        self.isUserInteractionEnabled = true
        userID = numIndex
        // 탭 제스처 인식기 추가
//                let tapGesture = UITapGestureRecognizer(target: self, action: #selector(cardTapped))
//                self.addGestureRecognizer(tapGesture)
//                self.isUserInteractionEnabled = true // UIView가 사용자 입력을 받을 수 있도록 설정
            
        let circleIcon = UIImageView().then{
            super.addSubview($0)
            $0.image = UIImage(named: "blackCircle")
            $0.image?.resized(toWidth: 28)
            $0.snp.makeConstraints{ make in
                make.left.equalToSuperview().offset(24)
                make.centerY.equalToSuperview()
            }
        }
        
        let rankLabel = UILabel().then{
            circleIcon.addSubview($0)
            $0.text = "\(numIndex)"
            $0.textColor = .white
            $0.font = .header4(size: 15)
            $0.snp.makeConstraints{ make in
                make.centerX.equalToSuperview()
                make.centerY.equalToSuperview()
            }
        }
        
        let nameLabel = UILabel().then{
            super.addSubview($0)
            $0.text = nameText
            $0.font = .header4(size: 15)
            $0.textColor = .textBlack
            $0.snp.makeConstraints{ make in
                make.top.equalToSuperview().offset(8)
                make.left.equalTo(circleIcon.snp.right).inset(-14)
            }
        }
        
        let activityLabel = UILabel().then{
            super.addSubview($0)
            $0.text = "총 \(activityNum)개의 활동"
            $0.textColor = .primaryYellow
            $0.font = .body3(size: 13)
            $0.snp.makeConstraints{ make in
                make.top.equalToSuperview().offset(8)
                make.left.equalTo(nameLabel.snp.right).inset(-12)
            }
        }
        
        let semesterLabel = UILabel().then{
            super.addSubview($0)
            $0.text = "\(semester)학기 재학중"
            $0.textColor = .gray5
            $0.font = .caption1(size: 12)
            $0.snp.makeConstraints{ make in
                make.bottom.equalToSuperview().offset(-8)
                make.left.equalTo(circleIcon.snp.right).inset(-14)
            }
        }
        
        let detailButton = UIButton().then{
            super.addSubview($0)
            $0.setTitle("자세히 보기", for: .normal)
            $0.titleLabel?.font = .body3(size: 13)
            $0.setTitleColor(.gray7, for: .normal)
            $0.setImage(UIImage(named: "arrow"), for: .normal)
            $0.addTarget(self, action: #selector(detailButtonTapped), for: .touchUpInside)
            $0.snp.makeConstraints{ make in
                make.centerY.equalToSuperview()
                make.right.equalToSuperview().offset(-24)
            }
            if let imageSize = $0.imageView?.image?.size,
               let text = $0.titleLabel?.text,
               let font = $0.titleLabel?.font {
                let textWidth = text.size(withAttributes: [.font: font]).width
                $0.titleEdgeInsets = UIEdgeInsets(top: 0, left: -(imageSize.width+10), bottom: 0, right: imageSize.width+10)
                $0.imageEdgeInsets = UIEdgeInsets(top: 0, left: textWidth, bottom: 0, right: -textWidth)
            }
        }
    }
    
    @objc func detailButtonTapped(){
        print("detailButton Tapped -> \(userID)")
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

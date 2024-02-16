//
//  CardButtonComp.swift
//  Uspec_Client
//
//  Created by 김하람 on 2/17/24.
//

import UIKit


class SpecRankingCard: UIView {
    var userID = 0
    
    init(nameText: String, numIndex: Int, activityNum: Int, semester: Int) {
        super.init(frame: .zero)
        self.backgroundColor = UIColor(red: 255, green: 255, blue: 255, alpha: 0.7)
        self.layer.cornerRadius = 30
        self.isUserInteractionEnabled = true
        userID = numIndex
        
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

class ActivityAnalysisCardButton: UIView {
    var activityID = 0
    var width1 = 400
    
    init(activity: String, rank: Int, ratio: Int, background: UIColor) {
        super.init(frame: .zero)
        self.backgroundColor = .systemPink
        self.layer.cornerRadius = 25
        self.isUserInteractionEnabled = true
        activityID = rank
        
        let activityLabel = UILabel().then{
            super.addSubview($0)
            $0.text = "\(activity)"
            $0.textColor = .textBlack
            $0.font = .header4(size: 15)
            $0.snp.makeConstraints{ make in
                make.centerY.equalToSuperview()
                make.left.equalTo(24)
            }
        }
        
        let graphView = UIView().then{
            super.addSubview($0)
            $0.layer.cornerRadius = 5
            $0.backgroundColor = background
            $0.snp.makeConstraints{ make in
                make.left.equalToSuperview().offset(94)
                make.centerY.equalToSuperview()
                make.width.equalTo(width1)
            }
        }
        
        let detailButton = UIButton().then{
            super.addSubview($0)
            $0.setTitle("\(ratio)%", for: .normal)
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
        print("detailButton Tapped -> \(activityID)")
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

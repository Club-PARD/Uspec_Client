//
//  ActivityAnalysisViewController.swift
//  Uspec_Client
//
//  Created by 김하람 on 2/17/24.
//

import UIKit

class ActivityAnalysisViewController: UIViewController {
    let backImage1 = UIImageView()
    let backImage2 = UIImageView()
    let nickName = UserDefaults.standard.string(forKey: "nickName") ?? "null"
    lazy var modifiedPath: String = {
        let originalPath = UserDefaults.standard.string(forKey: "path") ?? "null"
        return String(originalPath.dropFirst(6))
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        navigationUI()
        setBackImage()
        categorySection()
        activitySection()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.isNavigationBarHidden = false
    }
    
    private func navigationUI() {
        let backButton = UIBarButtonItem(image: UIImage(systemName: "chevron.backward"), style: .plain, target: self, action: #selector(backButtonTapped))
        backButton.tintColor = .primaryYellow
        let appearance = UINavigationBarAppearance()
        appearance.backgroundColor = .backgroundWhite

        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
        self.navigationItem.leftBarButtonItems = [backButton]
    
        let titleLabel = UILabel()
        titleLabel.text = "활동 분석표"
        titleLabel.font = UIFont.header2(size: 20)
        titleLabel.textColor = UIColor.black
        self.navigationItem.titleView = titleLabel
    }
    
    private func setBackImage() {
        backImage1.then{
            view.addSubview($0)
            $0.image = UIImage(named: "activityBack1")
            $0.snp.makeConstraints{ make in
                make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
                make.left.equalToSuperview()
                make.right.equalToSuperview()
            }
        }
        
        backImage2.then{
            view.addSubview($0)
            $0.image = UIImage(named: "activityBack2")
            $0.isUserInteractionEnabled = true
            $0.snp.makeConstraints{ make in
                make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(157)
                make.left.equalToSuperview()
                make.right.equalToSuperview()
                make.bottom.equalToSuperview()
            }
        }
    }
    
    private func categorySection(){
        let categoryTitle = UILabel().then{
            backImage1.addSubview($0)
            $0.text = "\(nickName)님이 선택한 관심분야는 다음과 같아요."
            $0.font = .body1(size: 15)
            $0.textColor = .gray6
            $0.snp.makeConstraints{ make in
                make.top.equalToSuperview().offset(40)
                make.left.equalTo(40)
                make.right.equalTo(40)
            }
        }
        let categoryChip = UIButton().then{
            backImage1.addSubview($0)
            $0.setTitle("\(modifiedPath)", for: .normal)
            $0.setTitleColor(.gray7, for: .normal)
            $0.titleLabel?.font = .caption1(size: 12)
            $0.layer.cornerRadius = 13
            $0.backgroundColor = .white
            $0.snp.makeConstraints{ make in
                make.height.equalTo(26)
                make.left.equalTo(40)
                make.width.equalTo(73)
                make.top.equalTo(categoryTitle.snp.bottom).offset(16)
            }
        }
    }
    
    private func activitySection() {
        let activityTitle = UILabel().then{
            backImage2.addSubview($0)
            $0.text = "다음 분야를 희망하는 다른 분들은"
            $0.font = .body1(size: 15)
            $0.textColor = .gray6
            $0.snp.makeConstraints{ make in
                make.top.equalToSuperview().offset(32)
                make.left.equalTo(40)
            }
        }
        
        let activity = UILabel().then{
            backImage2.addSubview($0)
            $0.text = "공모전"
            $0.font = .header3(size: 18)
            $0.textColor = .gray7
        }
        
        let activitySubTitle = UILabel().then{
            backImage2.addSubview($0)
            $0.text = "을 가장 많이 하고 있어요."
            $0.font = .body1(size: 15)
            $0.textColor = .gray6
        }
        
        let activityTitleStackView = UIStackView().then{
            backImage2.addSubview($0)
            $0.axis = .horizontal
            $0.spacing = 3
            $0.addArrangedSubview(activity)
            $0.addArrangedSubview(activitySubTitle)
            $0.snp.makeConstraints{ make in
                make.top.equalTo(activityTitle.snp.bottom).offset(5)
                make.left.equalTo(40)
            }
        }
        
        let card1 = ActivityAnalysisCardButton(activity: "공모전", rank: 1, ratio: 100, background: .gray6, width: 151, height: 135, imgHeight: 60, image: "contest").then{
            backImage2.addSubview($0)
            $0.isUserInteractionEnabled = true
            $0.snp.makeConstraints{ make in
                make.top.equalTo(activityTitleStackView.snp.bottom).offset(30)
                make.left.equalTo(16)
                make.right.equalTo(-16)
            }
        }
        
        let card2 = ActivityAnalysisCardButton(activity: "대외활동", rank: 2, ratio: 32, background: .gray5, width: 100, height: 135, imgHeight: 60, image: "outActivity").then{
            backImage2.addSubview($0)
            $0.isUserInteractionEnabled = true
            $0.snp.makeConstraints{ make in
                make.top.equalTo(card1.snp.bottom).offset(12)
                make.left.equalTo(16)
                make.right.equalTo(-16)
            }
        }
        
        let card3 = ActivityAnalysisCardButton(activity: "인턴십", rank: 3, ratio: 14, background: .gray4, width: 50, height: 175, imgHeight: 103, image: "intern").then{
            backImage2.addSubview($0)
            $0.isUserInteractionEnabled = true
            $0.snp.makeConstraints{ make in
                make.top.equalTo(card2.snp.bottom).offset(12)
                make.left.equalTo(16)
                make.right.equalTo(-16)
            }
        }
        
        let card4 = ActivityAnalysisCardButton(activity: "자격증", rank: 4, ratio: 11, background: .gray3, width: 30, height: 175, imgHeight: 103, image: "certification").then{
            backImage2.addSubview($0)
            $0.isUserInteractionEnabled = true
            $0.snp.makeConstraints{ make in
                make.top.equalTo(card3.snp.bottom).offset(12)
                make.left.equalTo(16)
                make.right.equalTo(-16)
            }
        }
        
        let card5 = ActivityAnalysisCardButton(activity: "교내활동", rank: 5, ratio: 6, background: .gray2, width: 20, height: 175, imgHeight: 103, image: "schoolActivity"
        ).then{
            backImage2.addSubview($0)
            $0.isUserInteractionEnabled = true
            $0.snp.makeConstraints{ make in
                make.top.equalTo(card4.snp.bottom).offset(12)
                make.left.equalTo(16)
                make.right.equalTo(-16)
            }
        }
        
    }
    
    @objc func backButtonTapped(){
        self.navigationController?.popViewController(animated: true)
    }
}

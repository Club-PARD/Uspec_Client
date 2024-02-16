    //
//  HomeViewController.swift
//  Uspec_Client
//
//  Created by 김하람 on 2/9/24.
//

import UIKit

class HomeViewController: UIViewController {
    let nickName = UserDefaults.standard.string(forKey: "nickName") ?? "null"
    lazy var modifiedPath: String = {
        let originalPath = UserDefaults.standard.string(forKey: "path") ?? "null"
        return String(originalPath.dropFirst(6))
    }()
    // MARK: - 서버에서 불러오기
    var firstWidth = 70
    var secondWidth = 50
    var thirdWidth = 30
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    let logo = UIImageView()
    let backImage1 = UIImageView()
    let backImage2 = UIImageView()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .backgroundWhite
        
        setTopUi()
        setBackground()
        activityView()
        setRanking()
    }
    
    private func setTopUi() {
        logo.image = UIImage(named: "splash_logo")
        view.addSubview(logo)
        logo.snp.makeConstraints{ make in
            make.top.equalTo(71)
            make.left.equalTo(16)
            make.width.equalTo(120)
            make.height.equalTo(30)
        }
        let myPageButton = UIButton().then {
            $0.setTitle("\(nickName)님의 마이페이지", for: .normal)
            $0.titleLabel?.font = .body1(size: 15)
            $0.setTitleColor(.gray7, for: .normal)
            $0.addTarget(self, action: #selector(myPageButtonTapped), for: .touchUpInside)
        }
        view.addSubview(myPageButton)
        myPageButton.snp.makeConstraints{ make in
            make.top.equalTo(75)
            make.right.equalTo(-16)
        }
    }
    
    @objc func myPageButtonTapped(){
        print("myPage")
    }
    private func setBackground() {
        backImage1.image = UIImage(named: "homeBack1")
        view.addSubview(backImage1)
        backImage1.snp.makeConstraints{ make in
            make.width.equalToSuperview()
            make.top.equalTo(logo.snp.bottom).offset(20)
        }
        
        backImage2.image = UIImage(named: "homeBack2")
        view.addSubview(backImage2)
        backImage2.snp.makeConstraints{ make in
            make.width.equalToSuperview()
            make.top.equalTo(logo.snp.bottom).offset(409)
            make.bottom.equalToSuperview()
        }
    }
    
    private func activityView() {
        let categoryLabel = UILabel().then{
            $0.text = "'\(modifiedPath)' 분야를 희망하는 다른 분들은"
            $0.textColor = .gray6
            $0.font = .body2(size: 14)
        }
        view.addSubview(categoryLabel)
        categoryLabel.snp.makeConstraints{ make in
            make.top.equalTo(backImage1.snp.top).offset(40)
            make.left.equalTo(40)
        }
        
        // MARK: - 서버에서 데이터 불러오기
        let top1Activity = UILabel().then{
            $0.text = modifiedPath
            $0.font = .header3(size: 18)
            $0.textColor = .gray7
        }
        
        let lastLabel = UILabel().then{
            $0.text = "을 가장 많이 하고 있어요."
            $0.textColor = .gray6
            $0.font = .body2(size: 14)
        }
        
        let labelStackView = UIStackView().then{
            $0.axis = .horizontal
            $0.spacing = 4
            $0.addArrangedSubview(top1Activity)
            $0.addArrangedSubview(lastLabel)
        }
        view.addSubview(labelStackView)
        labelStackView.snp.makeConstraints{ make in
            make.top.equalTo(categoryLabel.snp.bottom).offset(3)
            make.left.equalTo(40)
        }
        
        // MARK: - 서버 상위 3가지 활동 불러오기
        let top1Label = UILabel().then{
            $0.text = "교내활동"
            $0.font = .header4(size: 15)
            $0.textColor = .gray7
        }
        let top2Label = UILabel().then{
            $0.text = "인턴십"
            $0.font = .header4(size: 15)
            $0.textColor = .gray7
        }
        let top3Label = UILabel().then{
            $0.text = "대외활동"
            $0.font = .header4(size: 15)
            $0.textColor = .gray7
        }
        let top3StackView = UIStackView().then{
            $0.addArrangedSubview(top1Label)
            $0.addArrangedSubview(top2Label)
            $0.addArrangedSubview(top3Label)
            $0.alignment = .leading
            $0.axis = .vertical
            $0.spacing = 20
        }
        view.addSubview(top3StackView)
        top3StackView.snp.makeConstraints{ make in
            make.top.equalTo(top1Activity.snp.bottom).offset(30)
            make.left.equalTo(40)
        }
        
        let graphBackImg = UIImageView()
        graphBackImg.image = UIImage(named: "graph")
        view.addSubview(graphBackImg)
        graphBackImg.snp.makeConstraints{ make in
            make.top.equalTo(top1Activity.snp.bottom).offset(30)
            make.right.equalTo(-42)
            make.width.equalTo(220)
            make.height.equalTo(98)
        }
        
        let firstGraph = UIView().then{
            graphBackImg.addSubview($0)
            $0.backgroundColor = .gray5
            $0.snp.makeConstraints{ make in
                make.top.equalToSuperview()
                make.left.equalToSuperview()
                make.height.equalTo(16)
                make.width.equalTo(firstWidth)
            }
        }
        
        let secondGraph = UIView().then{
            graphBackImg.addSubview($0)
            $0.backgroundColor = .white
            $0.snp.makeConstraints{ make in
                make.top.equalTo(41)
                make.left.equalToSuperview()
                make.height.equalTo(16)
                make.width.equalTo(secondWidth)
            }
        }
        
        let thirdGraph = UIView().then{
            graphBackImg.addSubview($0)
            $0.backgroundColor = .white
            $0.snp.makeConstraints{ make in
                make.bottom.equalToSuperview()
                make.left.equalToSuperview()
                make.height.equalTo(16)
                make.width.equalTo(thirdWidth)
            }
        }
        
        let activitySubLabel = UILabel().then{
            backImage1.addSubview($0)
            $0.text = "그 중에서도 어떤 활동을 많이 했는지 궁금하다면?"
            $0.font = .body3(size: 13)
            $0.textColor = .gray6
            $0.snp.makeConstraints{ make in
                make.top.equalTo(graphBackImg.snp.bottom).offset(43)
                make.centerX.equalToSuperview()
            }
        }
        
        let gotoActivityButton = UIButton().then{
            backImage1.addSubview($0)
            $0.setTitle("활동 분석표 보러가기", for: .normal)
            $0.titleLabel?.font = .body1(size: 15)
            $0.setTitleColor(.white, for: .normal)
            $0.backgroundColor = .gray7
            $0.layer.cornerRadius = 28
            $0.snp.makeConstraints{ make in
                make.top.equalTo(activitySubLabel.snp.bottom).offset(12)
                make.left.equalTo(16)
                make.right.equalTo(-16)
                make.height.equalTo(54)
            }
        }
    }
    
    private func setRanking() {
        backImage2.isUserInteractionEnabled = true
        let titleLabel = UILabel().then{
            backImage2.addSubview($0)
            $0.text = "이 분야 스펙 랭킹"
            $0.textColor = .gray7
            $0.font = .header3(size: 18)
        }
        
        let infoIcon = UIImageView().then{
            backImage2.addSubview($0)
            $0.image = UIImage(named: "infoIcon")
            $0.image?.resized(toWidth: 20)
        }
        
        let titleInfoStackView = UIStackView().then{
            backImage2.addSubview($0)
            $0.addArrangedSubview(titleLabel)
            $0.addArrangedSubview(infoIcon)
            $0.axis = .horizontal
            $0.spacing = 6
            $0.snp.makeConstraints{ make in
                make.top.equalToSuperview().offset(24)
                make.left.equalTo(40)
            }
        }
        
        let rank1 = SpecRankingCard(nameText: "김유리", numIndex: 1, activityNum: 2, semester: 3).then{
            backImage2.addSubview($0)
            $0.snp.makeConstraints{ make in
                make.top.equalTo(74)
                make.left.equalTo(16)
                make.right.equalTo(-16)
                make.height.equalTo(57)
            }
        }
        
        let rank2 = SpecRankingCard(nameText: "이철수", numIndex: 2, activityNum: 5, semester: 3).then{
            backImage2.addSubview($0)
            $0.snp.makeConstraints{ make in
                make.top.equalTo(rank1.snp.bottom).offset(12)
                make.left.equalTo(16)
                make.right.equalTo(-16)
                make.height.equalTo(57)
            }
        }
        
        let rank3 = SpecRankingCard(nameText: "진맹구", numIndex: 3, activityNum: 2, semester: 3).then{
            backImage2.addSubview($0)
            $0.snp.makeConstraints{ make in
                make.top.equalTo(rank2.snp.bottom).offset(12)
                make.left.equalTo(16)
                make.right.equalTo(-16)
                make.height.equalTo(57)
            }
        }
    }
    
    
}

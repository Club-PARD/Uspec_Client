//
//  DashboardViewController.swift
//  Uspec_Client
//
//  Created by 김하람 on 2/9/24.
//

import UIKit

class MyPageViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        navigationUI()
        scrollViewSection()
        setButton()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.isNavigationBarHidden = false
        
    }
    
    private func navigationUI() {
        let backButton = UIBarButtonItem(image: UIImage(systemName: "chevron.backward"), style: .plain, target: self, action: #selector(backButtonTapped))
        backButton.tintColor = .primaryYellow
        let appearance = UINavigationBarAppearance()
        appearance.backgroundColor = .white
        
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = false
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
   
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
        self.navigationItem.leftBarButtonItems = [backButton]
    
        let titleLabel = UILabel()
        titleLabel.text = "마이페이지"
        titleLabel.font = UIFont.header2(size: 20)
        titleLabel.textColor = UIColor.black
        self.navigationItem.titleView = titleLabel
    }
    
    private func scrollViewSection() {
        let scroll = UIScrollView().then {
            view.addSubview($0)
            $0.backgroundColor = .white
            $0.isScrollEnabled = true
            $0.snp.makeConstraints { make in
                make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
                make.left.right.equalToSuperview()
                make.bottom.equalToSuperview().offset(-100)
            }
        }
        
        let contentView = UIView().then {
            scroll.addSubview($0)
            $0.backgroundColor = .white
            $0.snp.makeConstraints { make in
                make.top.bottom.equalTo(scroll.contentLayoutGuide)
                make.left.right.equalTo(scroll.contentLayoutGuide)
                make.width.equalTo(scroll.frameLayoutGuide)
            }
        }
        
        let myPage = UIImageView().then{
            contentView.addSubview($0)
            $0.image = UIImage(named: "myPage")
            $0.sizeToFit()
            $0.snp.makeConstraints { make in
                make.top.equalToSuperview()
                make.left.equalToSuperview().offset(7)
                make.right.equalToSuperview().offset(-7)
                make.height.equalTo(3619)
                make.bottom.equalToSuperview()
            }
        }
    }
    
    private func setButton() {
        let saveButton = NextButton(titleText: "저장하기").then{
            view.addSubview($0)
            $0.backgroundColor = .gray2
            $0.setTitleColor(.white, for: .normal)
            $0.layer.cornerRadius = 4
            $0.snp.makeConstraints{ make in
                make.bottom.equalToSuperview().offset(-45)
                make.left.equalTo(16)
                make.right.equalTo(-16)
                make.height.equalTo(45)
            }
        }
    }
    
    
    @objc func backButtonTapped() {
        let homeVC = HomeViewController()
        navigationController?.pushViewController(homeVC, animated: true)
    }
}

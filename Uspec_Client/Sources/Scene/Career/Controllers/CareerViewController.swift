//
//  CareerViewController.swift
//  Uspec_Client
//
//  Created by 진세진 on 2/15/24.
//
import UIKit

enum CareerStep: Int {
    case step0, step1, step2, step3, step4, step5 // 필요한 만큼 단계 추가
}

// MARK: - 이미지, main title, button title
class CareerViewController: UIViewController {
    var scrollView: UIScrollView!
    let mainLabel = UILabel()
    var currentStep: CareerStep
    
    init(currentStep: CareerStep) {
        self.currentStep = currentStep
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
  
    let nextButton = NextButton(titleText: "다음").then { button in
        button.isEnabled = false
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .backgroundWhite
        navigationUI()
        setupScrollView()
        setLabel()
    }
    
    @objc func backButtonTapped() {
        self.navigationController?.popViewController(animated: true)
    }
    
    private func setupScrollView() {
        scrollView = UIScrollView()
        scrollView.backgroundColor = .clear
        view.addSubview(scrollView)
        scrollView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    private func navigationUI() {
        let backButton = UIBarButtonItem(image: UIImage(systemName: "chevron.backward"), style: .plain, target: self, action: #selector(backButtonTapped))
        backButton.tintColor = UIColor(resource: .textBlack)
        let textButton = UIBarButtonItem(title: "이력 입력", style: .plain, target: self, action: #selector(backButtonTapped))
        let attributes = [NSAttributedString.Key.font: UIFont.header2(size: 20)]
        textButton.tintColor = UIColor(resource: .textBlack)
        textButton.setTitleTextAttributes(attributes, for: .normal)
        
        let appearance = UINavigationBarAppearance()
        appearance.backgroundColor = .backgroundWhite
        
        switch currentStep {
        case .step0:
            appearance.shadowImage = UIImage(named: "line0")
        case .step1:
            appearance.shadowImage = UIImage(named: "careerline1")
        case .step2:
            appearance.shadowImage = UIImage(named: "careerline2")
        case .step3:
            appearance.shadowImage = UIImage(named: "careerline3")
        case .step4:
            appearance.shadowImage = UIImage(named: "careerline4")
        case .step5:
            appearance.shadowImage = UIImage(named: "line5")
        }
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
        
        self.navigationItem.leftBarButtonItems = [backButton, textButton]
    }
    
    private func setLabel() {
        mainLabel.font = UIFont.header3(size: 18)
        mainLabel.textColor = .primaryYellow
        mainLabel.numberOfLines = 0
        mainLabel.textAlignment = .left
        scrollView.addSubview(mainLabel)
        mainLabel.snp.makeConstraints { make in
            make.top.equalTo(32)
            make.left.equalTo(16)
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
}

//
//  CareerViewController.swift
//  Uspec_Client
//
//  Created by 김하람 on 2/9/24.
//

import UIKit
import SnapKit
import Then

class CareerViewController: UIViewController {
    private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .white
        return collectionView
    }()
    
    private let addActivityCellIdentifier = "AddActivityCell"
    private var numberOfCells = 1
    
    private let semiTitleLabel = UILabel().then { label in
        label.text = "짱구님의 대외활동 내역을 입력해주세요."
        label.font = UIFont.header3(size: 18)
        label.textColor = .primaryYellow
    }
    
    private let doneButton = UIButton().then { button in
        button.setTitle("참여한 대외활동이 없어요.", for: .normal)
        button.setTitleColor(UIColor.black, for: .normal)
        button.titleLabel?.font = UIFont.body1()
        button.layer.borderColor = UIColor.gray3.cgColor
        button.layer.cornerRadius = 4
        button.layer.borderWidth = 1
        
    }
    
    private let nextButton = UIButton().then { button in
        button.setTitle("다음", for: .normal)
        button.setTitleColor(UIColor.gray1, for: .normal)
        button.backgroundColor = UIColor.gray2
        button.titleLabel?.font = UIFont.body1()
        button.layer.borderColor = UIColor.gray3.cgColor
        button.layer.cornerRadius = 4
        button.layer.borderWidth = 1
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setUpNavigationbar()
        setUpLayout()

        collectionView.register(InputCareerCollectionViewCell.self, forCellWithReuseIdentifier: "InputCareerCollectionViewCell")
        collectionView.register(AddActivityCollectionViewCell.self, forCellWithReuseIdentifier: addActivityCellIdentifier)
        collectionView.dataSource = self
        collectionView.delegate = self
    }
    
    private func setUpNavigationbar() {
        let backButton = UIBarButtonItem(image: UIImage(systemName: "chevron.backward"), style: .plain, target: self, action: #selector(backButtonTapped))
        backButton.tintColor = UIColor(resource: .textBlack)
        let textButton = UIBarButtonItem(title: "이력 입력", style: .plain, target: self, action: #selector(backButtonTapped))
        let attributes = [NSAttributedString.Key.font: UIFont.header2(size: 20)]
        textButton.tintColor = UIColor(resource: .textBlack)
        textButton.setTitleTextAttributes(attributes, for: .normal)
        
        let appearance = UINavigationBarAppearance()
        appearance.backgroundColor = .backgroundWhite
        appearance.shadowImage = UIImage(named: "line1")
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
        
        self.navigationItem.leftBarButtonItems = [backButton, textButton]
    }
    
    @objc func backButtonTapped() {
        self.navigationController?.popViewController(animated: true)
    }
    
    private func setUpLayout(){
        view.addSubview(collectionView)
        view.addSubview(semiTitleLabel)
        view.addSubview(doneButton)
        view.addSubview(nextButton)
        
        semiTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(32)
            make.leading.equalTo(view.snp.leading).offset(12)
            make.trailing.equalTo(view.snp.trailing)
        }
        
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(semiTitleLabel.snp.bottom).offset(32)
            make.leading.equalTo(view.snp.leading)
            make.trailing.equalTo(view.snp.trailing)
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).offset(-100)
        }
        
        doneButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.width.equalTo(343)
            make.height.equalTo(45)
            make.top.equalTo(view.safeAreaLayoutGuide.snp.bottom).offset(-100)
        }
        
        nextButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.width.equalTo(343)
            make.height.equalTo(45)
            make.top.equalTo(doneButton.snp.bottom).offset(4)
        }
    }
}

extension CareerViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return numberOfCells + 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.item == numberOfCells {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: addActivityCellIdentifier, for: indexPath) as? AddActivityCollectionViewCell else {
                return UICollectionViewCell()
            }
            cell.configure(title: "활동 추가하기")
            return cell
        } else {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "InputCareerCollectionViewCell", for: indexPath) as? InputCareerCollectionViewCell else {
                return UICollectionViewCell()
            }
            cell.layer.borderColor = UIColor.secondaryYellow.cgColor
            cell.layer.borderWidth = 1.0
            cell.layer.cornerRadius = 20.0
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.item == numberOfCells {
            numberOfCells += 1
            collectionView.insertItems(at: [IndexPath(item: numberOfCells - 1, section: 0)])
            print("Add activity")
        } else {
            print("Selected activity: \(indexPath.item)")
        }
    }
}

extension CareerViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if indexPath.item == numberOfCells {
            // Size for "AddActivityCollectionViewCell"
            return CGSize(width: 343, height: 61)
        } else {
            // Size for "InputCareerCollectionViewCell"
            return CGSize(width: 343, height: 412)
        }
    }
}

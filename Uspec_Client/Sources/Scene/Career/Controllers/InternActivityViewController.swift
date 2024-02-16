//
//  InternActivityViewController.swift
//  Uspec_Client
//
//  Created by 진세진 on 2/16/24.
//

import UIKit

class InternActivityViewController: CompetitionUIViewController {
    let identifier = "internViewCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpComponent()
    }
    
    func setUpComponent() {
        semiTitleLabel.text = "짱구님의 인턴 내역을 입력해주세요"
        collectionView.register(InternActCollectionViewCell.self, forCellWithReuseIdentifier: identifier)
        collectionView.register(AddActivityCollectionViewCell.self, forCellWithReuseIdentifier: addActivityCellIdentifier)
    }
    
    @objc override func doneButtonTapped() {
        let infoVC = CertificateViewController(currentStep: .step2)
        self.navigationController?.pushViewController(infoVC, animated: true)
        print(self.navigationController as Any)
    }
    
    @objc override func nextButtonTapped() {
        let infoVC = CertificateViewController(currentStep: .step2)
        self.navigationController?.pushViewController(infoVC, animated: true)
        print(self.navigationController as Any)
    }
}

extension InternActivityViewController {

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.item == numberOfCells {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: addActivityCellIdentifier, for: indexPath) as? AddActivityCollectionViewCell else {
                return UICollectionViewCell()
            }

            cell.configure(title: "인턴 추가하기")
            return cell
        } else {
            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: identifier, for: indexPath
            ) as? InternActCollectionViewCell else {
                return UICollectionViewCell()
            }

            cell.layer.borderColor = UIColor.secondaryYellow.cgColor
            cell.layer.borderWidth = 1.0
            cell.layer.cornerRadius = 20.0
            cell.delegate = self
            cell.delegateValid = self
            return cell
        }
    }
}

extension InternActivityViewController {
    override func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if indexPath.item == numberOfCells {
            return CGSize(width: 343, height: 61)
        } else {
            return CGSize(width: 343, height: 345)
        }
    }
}

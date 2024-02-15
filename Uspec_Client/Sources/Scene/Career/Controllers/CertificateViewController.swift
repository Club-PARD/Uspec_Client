//
//  CertificateViewController.swift
//  Uspec_Client
//
//  Created by 진세진 on 2/16/24.
//

import UIKit

class CertificateViewController: InternActivityViewController {
    let identifierInCertifivate = "CertificateViewCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpComponent()
    }
    
    override func setUpComponent() {
        semiTitleLabel.text = "짱구님의 자격증 내역을 입력해주세요"
        collectionView.register(
            CertifivateCollectionViewCell.self,
            forCellWithReuseIdentifier: identifierInCertifivate
        )
        collectionView.register(
            AddActivityCollectionViewCell.self,
            forCellWithReuseIdentifier: addActivityCellIdentifier
        )
    }
}

extension CertificateViewController {
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return numberOfCells + 1
    }

    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.item == numberOfCells {
            numberOfCells += 1
            collectionView.insertItems(at: [IndexPath(item: numberOfCells - 1, section: 0)])
        }
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.item == numberOfCells {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: addActivityCellIdentifier, for: indexPath) as? AddActivityCollectionViewCell else {
                return UICollectionViewCell()
            }

            cell.configure(title: "인턴 추가하기")
            return cell
        } else {
            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: identifierInCertifivate, for: indexPath
            ) as? CertifivateCollectionViewCell else {
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

extension CertificateViewController {
    override func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if indexPath.item == numberOfCells {
            return CGSize(width: 343, height: 61)
        } else {
            return CGSize(width: 343, height: 218)
        }
    }
}

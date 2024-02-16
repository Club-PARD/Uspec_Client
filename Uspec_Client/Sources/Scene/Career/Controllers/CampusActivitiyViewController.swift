//
//  CampusActivitiyViewController.swift
//  Uspec_Client
//
//  Created by 진세진 on 2/17/24.
//

import UIKit

class CampusActivitiyViewController: InternActivityViewController {
    let identifierInCampus = "campusActivityCollectionViewCell"
    override func viewDidLoad() {
        super.viewDidLoad()
        semiTitleLabel.text = "짱구님의 교내활동 내역을 입력해주세요."
        doneButton.setTitle("참여한 교내활동이 없어요", for: .normal)
        collectionView.register(CampusActivityCollectionViewCell.self, forCellWithReuseIdentifier: identifierInCampus)
        collectionView.register(AddActivityCollectionViewCell.self, forCellWithReuseIdentifier: addActivityCellIdentifier)
    }
    
    @objc override func doneButtonTapped() {
        let infoVC = HomeViewController()
        self.navigationController?.pushViewController(infoVC, animated: true)
        print(self.navigationController as Any)
    }
    
    @objc override func nextButtonTapped() {
        let infoVC = HomeViewController()
        self.navigationController?.pushViewController(infoVC, animated: true)
        print(self.navigationController as Any)
    }
    

}
extension CampusActivitiyViewController {
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.item == numberOfCells {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: addActivityCellIdentifier, for: indexPath) as? AddActivityCollectionViewCell else {
                return UICollectionViewCell()
            }
            
            cell.configure(title: "교내활동 추가하기")
            return cell
        } else {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: identifierInCampus, for: indexPath) as? CampusActivityCollectionViewCell else {
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
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.item == numberOfCells {
            numberOfCells += 1
            collectionView.insertItems(at: [IndexPath(item: numberOfCells - 1, section: 0)])
            collectionView.reloadData()
        }
    }
}

extension CampusActivitiyViewController {
    override func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if indexPath.item == numberOfCells {
            return CGSize(width: 343, height: 61)
        } else {
            return CGSize(width: 343, height: 315)
        }
    }
}

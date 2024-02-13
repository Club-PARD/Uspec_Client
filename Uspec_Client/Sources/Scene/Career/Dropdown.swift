//
//  Dropdown.swift
//  Uspec_Client
//
//  Created by 진세진 on 2/14/24.
//
import UIKit
import SnapKit
import Then

class DropdownMenu: UICollectionView {
    var options: [String] = [] {
        didSet {
            reloadData()
        }
    }
    //여러개 선택을 위한 것
    var selectedOptions: [String] = []
    
    var didSelectOption: (([String]) -> Void)?
    
    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .horizontal 
        super.init(frame: frame, collectionViewLayout: flowLayout)
        
        setupCollectionView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupCollectionView() {
        backgroundColor = .white
        dataSource = self
        delegate = self
        register(UICollectionViewCell.self, forCellWithReuseIdentifier: "Cell")
    }
}

extension DropdownMenu: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return options.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath)
        cell.backgroundColor = .clear
        
        cell.contentView.subviews.forEach { $0.removeFromSuperview() }
        
        let label = UILabel(frame: cell.contentView.bounds)
        label.text = options[indexPath.item]
        label.textAlignment = .center
        label.textColor = selectedOptions.contains(options[indexPath.item]) ? .blue : .black // 선택된 항목은 파란색으로 표시
        label.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        cell.contentView.addSubview(label)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        // 아이템의 크기를 조정
        return CGSize(width: collectionView.bounds.width, height: 40)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        // 아이템 사이의 간격 설정
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        // 콜렉션 뷰의 여백 설정
        return UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selectedOption = options[indexPath.item]
        if let index = selectedOptions.firstIndex(of: selectedOption) { // 이미 선택된 옵션인 경우 제거
            selectedOptions.remove(at: index)
        } else { // 선택되지 않은 옵션인 경우 추가
            selectedOptions.append(selectedOption)
        }
        didSelectOption?(selectedOptions)
        collectionView.reloadData() // 선택 상태가 변경될 때마다 셀을 다시 로드하여 선택된 항목을 갱신
    }
}

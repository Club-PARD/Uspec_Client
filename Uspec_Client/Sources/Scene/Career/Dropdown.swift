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
    
    var selectedOptions: [String] = []
    
    var didSelectOption: (([String]) -> Void)?
    
    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.collectionView?.backgroundColor = .secondaryYellow
        flowLayout.scrollDirection = .vertical
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
        
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: cell.contentView.bounds.width, height: 50)) // 아이템의 높이를 50으로 지정
        label.text = options[indexPath.item]
        label.textAlignment = .center
        label.textColor = selectedOptions.contains(options[indexPath.item]) ? .blue : .black
        label.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        cell.contentView.addSubview(label)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let itemWidth = (collectionView.bounds.width - 30) / 3
        return CGSize(width: itemWidth, height: 50)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selectedOption = options[indexPath.item]
        if let index = selectedOptions.firstIndex(of: selectedOption) {
            selectedOptions.remove(at: index)
        } else {
            selectedOptions.append(selectedOption)
        }
        didSelectOption?(selectedOptions)
        collectionView.reloadData()
    }
}

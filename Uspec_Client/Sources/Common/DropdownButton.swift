//
//  Dropdown.swift
//  Uspec_Client
//
//  Created by 진세진 on 2/14/24.
//
import UIKit
import SnapKit
import Then

class DropdownMenu: UIView {
    var options: [String] = [] {
        didSet {
            collectionView.reloadData()
        }
    }
    var selectedOptions: [String] = []
    
    var didSelectOption: (([String]) -> Void)?
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .secondaryYellow
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "Cell")
        return collectionView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupCollectionView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupCollectionView() {
        addSubview(collectionView)
        collectionView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
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
        
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: cell.contentView.bounds.width, height: 50))
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
        return UIEdgeInsets(top: 0, left: 5, bottom: 0, right: 5)
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
    
    func updateHeight() {
        collectionView.layoutIfNeeded()
        let contentHeight = collectionView.collectionViewLayout.collectionViewContentSize.height
        let maxHeight: CGFloat = 172
        let newHeight = min(contentHeight, maxHeight)
        snp.updateConstraints { make in
            make.height.equalTo(newHeight)
        }
    }
}

class DropdownButton: UIView {
    private var isDropdownMenuVisible = true
    private let maxHeight: CGFloat = 172 // 드롭다운 메뉴의 최대 높이
    private let dropDownMenu = DropdownMenu()
    let option : [String] = []
    
    lazy var button: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("선택하기", for: .normal)
        button.titleLabel?.font = UIFont.body1()
        button.setTitleColor(.gray3, for: .normal)
        button.layer.cornerRadius = 20
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.gray3.cgColor
        button.contentHorizontalAlignment = .left
        button.titleEdgeInsets = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 0)
        button.addTarget(self, action: #selector(didTapButton), for: .touchUpInside)
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        setupDropdownMenu(options: option)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        self.backgroundColor = .clear // 버튼과 같은 배경 색으로
        self.addSubview(button)
        button.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    func setupDropdownMenu(options: [String]) {
        dropDownMenu.options = options
        dropDownMenu.didSelectOption = { selectedOptions in
           print("Selected options: \(selectedOptions)")
        }
        dropDownMenu.clipsToBounds = true
        dropDownMenu.layer.cornerRadius = 5
        dropDownMenu.backgroundColor = .white
        
        self.addSubview(dropDownMenu)
        dropDownMenu.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        dropDownMenu.isHidden = isDropdownMenuVisible
    }

    @objc private func didTapButton() {
        isDropdownMenuVisible.toggle()
        print(isDropdownMenuVisible)
        dropDownMenu.isHidden = isDropdownMenuVisible
        setUplayoutPullButtonView()
    }
    
    private func setUplayoutPullButtonView() {
        if let window = UIWindow.visibleWindow() {
            if !window.subviews.contains(dropDownMenu) {
                window.addSubview(dropDownMenu)
                dropDownMenu.snp.makeConstraints { make in
                    make.top.equalTo(self.snp.bottom)
                    make.leading.trailing.equalTo(self)
                    make.height.equalTo(145)
                }
            }
        }
    }
}

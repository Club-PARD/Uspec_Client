//
//  Dropdown.swift
//  Uspec_Client
//
//  Created by 진세진 on 2/14/24.
//
import UIKit
import SnapKit
import Then

class DropdownButton: UIView {
    private var isDropdownMenuVisible = true
    private let maxHeight: CGFloat = 172 // 드롭다운 메뉴의 최대 높이
    private let dropDownMenu = DropdownMenu()
    var buttonoption : [String] = []
    
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
        setupDropdownMenu(options: buttonoption)
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
        buttonoption = options
        selectedDropdownMenu(options: buttonoption)
        dropDownMenu.clipsToBounds = true
        dropDownMenu.layer.cornerRadius = 5
        dropDownMenu.backgroundColor = .white
        self.addSubview(dropDownMenu)
        dropDownMenu.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        dropDownMenu.isHidden = isDropdownMenuVisible
    }
    
    func selectedDropdownMenu(options: [String]) {
        dropDownMenu.options = options
        dropDownMenu.didSelectOption = { [weak self] selectedOptions in
            guard let self = self else { return }
            if selectedOptions.isEmpty {
                self.button.setTitle("선택하기", for: .normal)
            } else {
                self.button.setTitle(selectedOptions.joined(separator: ", "), for: .normal)
                print("Selected options: \(selectedOptions)")
            }
        }
    }

    @objc private func didTapButton() {
        isDropdownMenuVisible.toggle()
        if isDropdownMenuVisible {
            button.layer.borderColor = UIColor.gray3.cgColor
        } else {
            button.layer.borderColor = UIColor.secondaryYellow.cgColor
        }
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

//MARK: DropdownMenuVIiew , 드롭다운 버튼 눌렀을 때 생기는 뷰

class DropdownMenu: UIView {
    var options: [String] = [] {
        didSet {
            collectionView.reloadData()
        }
    }
    var selectedOptions: [String] = []
    
    var didSelectOption: (([String]) -> Void)?
    
    private let layout = LeftAlignedCollectionViewFlowLayout().then { layout in
        layout.scrollDirection = .vertical
        layout.minimumInteritemSpacing = 5
        layout.sectionInset = UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
    }
    
    private lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
        collectionView.layer.cornerRadius = 20
        collectionView.layer.borderWidth = 1
        collectionView.layer.borderColor = UIColor.secondaryYellow.cgColor
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(DropDownCollectionViewCell.self, forCellWithReuseIdentifier: "Cell")
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
            make.top.equalToSuperview().offset(12)
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.bottom.equalToSuperview().offset(-12)
        }
    }
}

extension DropdownMenu: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return options.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as? DropDownCollectionViewCell else {
            return UICollectionViewCell()
        }
        cell.backgroundColor = .clear
        cell.contentView.subviews.forEach { $0.removeFromSuperview() }
        cell.configureIncategory(with: options[indexPath.item], isSelected: selectedOptions.contains(options[indexPath.item]))

        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let text = options[indexPath.item]
        let font = UIFont.body3(size: 13)
        
        let textWidth = text.size(withAttributes: [.font: font]).width

        let cellWidth = textWidth + 16
        
        return CGSize(width: cellWidth, height: 28)
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


class LeftAlignedCollectionViewFlowLayout: UICollectionViewFlowLayout {

    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        let attributes = super.layoutAttributesForElements(in: rect)

        var leftMargin = sectionInset.left
        var maxY: CGFloat = -1.0
        attributes?.forEach { layoutAttribute in
            if layoutAttribute.frame.origin.y >= maxY {
                leftMargin = sectionInset.left
            }

            layoutAttribute.frame.origin.x = leftMargin

            leftMargin += layoutAttribute.frame.width + minimumInteritemSpacing
            maxY = max(layoutAttribute.frame.maxY , maxY)
        }

        return attributes
    }
}

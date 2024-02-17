//
//  Dropdown.swift
//  Uspec_Client
//
//  Created by 진세진 on 2/14/24.
//
import UIKit
import SnapKit
import Then

protocol DropdownButtonDelegate: AnyObject {
    func dropdownButton(_ button: DropdownButton, didSelectOption isSelected: Bool)
}

class DropdownButton: UIView {
    var isDropdownMenuVisible = true
    let dropDownMenu = DropdownMenu()
    weak var DropButtondelegate: DropdownButtonDelegate?

    var buttonoption : [String] = []
    var buttonOptionOnly : String = ""
    var isSelectedOption : Bool = false
    var isSelectedNotOnly : Bool = true
    
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
        setupDropdownMenu(options: buttonoption, selectedvalue: true)
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
    
    func setupDropdownMenu(options: [String], selectedvalue : Bool) {
        
        dropDownMenu.isSelectedOnly = selectedvalue
        isSelectedNotOnly = selectedvalue
        
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
        if isSelectedNotOnly {
            dropDownMenu.didSelectOption = { [weak self] selectedOptions in
                guard let self = self else { return }
                if selectedOptions.isEmpty {
                    isSelectedOption = false
                    
                    self.DropButtondelegate?.dropdownButton(self, didSelectOption: false)
                    button.setTitleColor(UIColor.gray3, for: .normal)
                    self.button.setTitle("선택하기", for: .normal)
                } else {
                    isSelectedOption = true
                    self.DropButtondelegate?.dropdownButton(self, didSelectOption: true)
                    button.setTitleColor(UIColor.gray7, for: .normal)
                    self.button.titleLabel?.font = UIFont.body3(size: 13)
                    self.button.setTitle(selectedOptions.joined(separator: ", "), for: .normal)
                }
            }
        } else {
            dropDownMenu.didSelectOptionOnly = { [weak self] selectedOptions in
                guard let self = self else { return }
                if selectedOptions == "" || selectedOptions == nil {
                    isSelectedOption = false
                    button.setTitleColor(UIColor.gray3, for: .normal)
                    self.DropButtondelegate?.dropdownButton(self, didSelectOption: false)
                    self.button.setTitle("선택하기", for: .normal)
                } else {
                    isSelectedOption = true
                    self.DropButtondelegate?.dropdownButton(self, didSelectOption: true)
                    button.setTitleColor(UIColor.gray7, for: .normal)
                    self.button.setTitle(selectedOptions, for: .normal)
                }
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
    
    override func didMoveToWindow() {
        super.didMoveToWindow()
        if window == nil {
            hideDropdownMenu()
        }
    }
    
    func hideDropdownMenu() {
        isDropdownMenuVisible = true
        dropDownMenu.isHidden = true
        dropDownMenu.willRemoveSubview(self)
    }
}

//MARK: DropdownMenuVIiew , 드롭다운 버튼 눌렀을 때 생기는 뷰
@objc protocol DropdownMenuDelegate: AnyObject {
    @objc optional func dropdownMenu(_ dropdownMenu: DropdownMenu, didSelectOptions options: [String])
    @objc optional func dropdownMenu(_ dropdownMenu: DropdownMenu, didSelectOption option: String)
}

class DropdownMenu: UIView {
    var options: [String] = [] {
        didSet {
            collectionView.reloadData()
        }
    }
    weak var delegate : DropdownMenuDelegate?
    var selectedOptionsText: [String] = []
    var selectedOptionsOnlyText: String = " "
    var isSelectedOnly : Bool = true // 다중일지 단일일지 선택하는
    var didSelectOption: (([String]) -> Void)? //다중
    var didSelectOptionOnly : ((String)-> Void)? // 단일
    
    private let layout = LeftAlignedCollectionViewFlowLayout().then { layout in
        layout.scrollDirection = .vertical
        layout.minimumInteritemSpacing = 5
        layout.sectionInset = UIEdgeInsets(top: 13, left: 16, bottom: 10, right: 10)
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
            make.bottom.equalToSuperview()
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
        if isSelectedOnly {
            // 다중 선택
            cell.contentView.subviews.forEach { $0.removeFromSuperview() }
            cell.configureIncategory(with: options[indexPath.item], isSelected: selectedOptionsText.contains(options[indexPath.item]))
        } else {
            // 단일 선택
            let isSelected = selectedOptionsText.contains(options[indexPath.item])
            cell.configureIncategory(with: options[indexPath.item], isSelected: isSelected)
        }
        

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
        // isSelectedOnly 값에 따라 다중 선택 또는 단일 선택으로 동작
        if isSelectedOnly {
            if let index = selectedOptionsText.firstIndex(of: selectedOption) {
                selectedOptionsText.remove(at: index)
            } else {
                selectedOptionsText.append(selectedOption)
            }
            didSelectOption?(selectedOptionsText)
            
            self.delegate?.dropdownMenu?(self, didSelectOptions: selectedOptionsText)
            
        } else {
            didSelectOptionOnly?(selectedOption)
            selectedOptionsText = [selectedOption]
            selectedOptionsOnlyText = selectedOption
            self.delegate?.dropdownMenu?(self, didSelectOption: selectedOptionsOnlyText)
        }
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

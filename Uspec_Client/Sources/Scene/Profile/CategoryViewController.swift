//
//  CategoryViewController.swift
//  Uspec_Client
//
//  Created by 김하람 on 2/15/24.
//

import UIKit

class CategoryViewController: ProfileViewController {
    var path = ""
    let topWidth = 150
    let topCategoryTableView = UITableView()
    let detailCategoryTableView = UITableView()
    let notYetButton = NextButton(titleText: "아직 진로 방향을 정하지 못했어요.")
    let doneButton = NextButton(titleText: "회원가입 완료")
    let titleLabel = UILabel().then {
        $0.text = "진학/취업하고자 하는 분야를 입력해주세요."
        $0.font = .body1(size: 15)
        $0.textColor = .textBlack
    }
    let subTitle = UILabel().then {
        $0.text = "희망하는 분야가 여러개일 경우 모두 선택하여 주세요."
        $0.font = .body3(size: 13)
        $0.textColor = .gray4
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        setUi()
        setBottomButtons()
        categorySection()
    }
    
    private func setUi() {
        mainLabel.setTextWithLineHeight(text: "마지막으로 여러분들의\n자세한 진로 분야를 알려주세요.", lineHeight: 24)
        
        view.addSubview(titleLabel)
        titleLabel.snp.makeConstraints{ make in
            make.top.equalTo(mainLabel.snp.bottom).offset(32)
            make.left.equalTo(16)
        }
        view.addSubview(subTitle)
        subTitle.snp.makeConstraints{ make in
            make.top.equalTo(titleLabel.snp.bottom).offset(6)
            make.left.equalTo(16)
        }
    }
    
    private func categorySection() {
        let categoryView = UIView().then{
            $0.backgroundColor = .gray1
        }
        
        view.addSubview(categoryView)
        categoryView.snp.makeConstraints{ make in
            make.top.equalTo(subTitle.snp.bottom).offset(20)
            make.width.equalToSuperview()
            make.bottom.equalTo(notYetButton.snp.top).offset(0)
        }
        topCategoryTableView.delegate = self
        topCategoryTableView.dataSource = self
        topCategoryTableView.backgroundColor = .clear
        categoryView.addSubview(topCategoryTableView)
        topCategoryTableView.snp.makeConstraints{ make in
            make.top.equalToSuperview()
            make.width.equalTo(topWidth)
            make.bottom.equalToSuperview()
            make.height.equalToSuperview()
        }
        topCategoryTableView.register(TopCategoryCell.self, forCellReuseIdentifier: "topCell")
        
        detailCategoryTableView.delegate = self
        detailCategoryTableView.dataSource = self
        detailCategoryTableView.backgroundColor = .white
        categoryView.addSubview(detailCategoryTableView)
        detailCategoryTableView.snp.makeConstraints{ make in
            make.top.equalToSuperview()
            make.left.equalTo(topWidth)
            make.right.equalTo(0)
            make.bottom.equalToSuperview()
            make.height.equalToSuperview()
        }
        detailCategoryTableView.register(DetailCategoryCell.self, forCellReuseIdentifier: "detailCell")
    }
    
    private func setBottomButtons() {
        view.addSubview(notYetButton)
        view.addSubview(doneButton)
        doneButton.snp.makeConstraints { make in
            make.left.equalTo(16)
            make.right.equalTo(-16)
            make.bottom.equalTo(-48)
            make.height.equalTo(45)
        }
        notYetButton.snp.makeConstraints { make in
            make.left.equalTo(16)
            make.right.equalTo(-16)
            make.bottom.equalTo(doneButton.snp.top).offset(-4)
            make.height.equalTo(45)
        }
        
        notYetButton.backgroundColor = .white
        notYetButton.setTitleColor(.textBlack, for: .normal)
        notYetButton.layer.borderWidth = 1
        notYetButton.layer.borderColor = UIColor.gray3.cgColor
        notYetButton.layer.cornerRadius = 4
        notYetButton.addTarget(self, action: #selector(notYetButtonTapped), for: .touchUpInside)
        
        doneButton.backgroundColor = .gray2
        doneButton.layer.cornerRadius = 4
        doneButton.addTarget(self, action: #selector(doneButtonTapped), for: .touchUpInside)
    }
    @objc func notYetButtonTapped() {
        let profileDoneVC = ProfileDoneViewController(currentStep: .step0)
        self.navigationController?.pushViewController(profileDoneVC, animated: true)
        print(self.navigationController as Any)
    }
    @objc func doneButtonTapped() {
        UserDefaults.standard.set(path, forKey: "path")
        if let nickName = UserDefaults.standard.string(forKey: "nickName"),
           let university = UserDefaults.standard.string(forKey: "university"),
           let ageString = UserDefaults.standard.string(forKey: "age"),
           let semesterString = UserDefaults.standard.string(forKey: "semester"),
           let score = UserDefaults.standard.string(forKey: "score"),
           let path = UserDefaults.standard.string(forKey: "path"),
           let major = UserDefaults.standard.string(forKey: "major") {
            let isGraduated = UserDefaults.standard.bool(forKey: "isGraduated")
            let isThree = UserDefaults.standard.bool(forKey: "isThree")
            let isGradeOpen = UserDefaults.standard.bool(forKey: "isGradeOpen")
            if let age = Int(ageString), let semester = Int(semesterString) {
                makePostRequest(with: nickName, university: university, age: age, semester: semester, isGraduated: isGraduated, score: score, major: major, isThree: isThree, isGradeOpen: isGradeOpen, path: path)
            } else {
                print("Error: Unable to convert age or semester to Int.")
            }
        } else {
            print("Error: Unable to retrieve some UserDefaults values.")
        }
        
        let profileDoneVC = ProfileDoneViewController(currentStep: .step0)
        self.navigationController?.pushViewController(profileDoneVC, animated: true)
        print(self.navigationController as Any)
    }
}

var selectedTopCategoryIndex: Int?
var lastIndexPath: IndexPath?
extension CategoryViewController: UITableViewDataSource, UITableViewDelegate{
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView == topCategoryTableView {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "topCell", for: indexPath) as? TopCategoryCell else {
                print("Failed to dequeue topCell")
                return UITableViewCell()
            }
            let data = TopCategory.model[indexPath.row]
            cell.textLabel?.text = data.topCategory
            cell.textLabel?.textColor = .gray5
            cell.selectionStyle = .none
            cell.backgroundColor = .gray1
            return cell
        } else if tableView == detailCategoryTableView {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "detailCell", for: indexPath) as? DetailCategoryCell else {
                print("Failed to dequeue detailCell")
                return UITableViewCell()
            }
            if let selectedIndex = selectedTopCategoryIndex, selectedIndex < DetailCategory.model.count {
                let data = DetailCategory.model[selectedIndex][indexPath.row]
                cell.textLabel?.text = data.detailCategory
                cell.textLabel?.textColor = .gray5
            }
            cell.selectionStyle = .none
            cell.backgroundColor = .white
            return cell
        } else {
            return UITableViewCell()
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        if tableView == detailCategoryTableView {
            return selectedTopCategoryIndex != nil ? 1 : 0
        }
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == detailCategoryTableView {
            if let selectedIndex = selectedTopCategoryIndex, selectedIndex < DetailCategory.model.count {
                return DetailCategory.model[selectedIndex].count
            }
            return 0
        }
        return TopCategory.model.count
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if tableView == topCategoryTableView {
            selectedTopCategoryIndex = indexPath.row
            detailCategoryTableView.reloadData()
        }
        
        if tableView == topCategoryTableView {
            if let lastIndexPath = lastIndexPath, let lastCell = tableView.cellForRow(at: lastIndexPath) {
                lastCell.backgroundColor = .gray1
            }
            // 현재 선택된 셀의 배경색 변경
            if let cell = tableView.cellForRow(at: indexPath) {
                cell.backgroundColor = .white
            }
            // 마지막 indexPath 업데이트
            lastIndexPath = indexPath
            print("first category: \(String(describing: lastIndexPath))")
        } else if tableView == detailCategoryTableView {
            if let lastIndexPath = lastIndexPath, let lastCell = tableView.cellForRow(at: lastIndexPath) {
                lastCell.backgroundColor = .white
            }
            
            lastIndexPath = indexPath
            // selectedTopCategoryIndex를 사용하여 현재 선택된 top category에 해당하는 detail category 데이터를 가져옵니다.
            if let selectedIndex = selectedTopCategoryIndex, selectedIndex < DetailCategory.model.count {
                let detailCategories = DetailCategory.model[selectedIndex]
                
                // lastIndexPath.row를 사용하여 선택된 detail category의 데이터를 가져옵니다.
                if lastIndexPath!.row < detailCategories.count {
                   path = detailCategories[lastIndexPath!.row].detailCategory
                    print("second category: \(String(describing: lastIndexPath)), text: \(path)")
                
                }
            }
            tableView.deselectRow(at: indexPath, animated: false)
        }
    }
}

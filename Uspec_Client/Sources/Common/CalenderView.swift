//
//  CalenderViewController.swift
//  Uspec_Client
//
//  Created by 진세진 on 2/17/24.
//

import UIKit
import FSCalendar
import SnapKit
import Then

protocol CalendarViewDelegate : AnyObject {
    func didSelectDate(_ calendar: CalendarView,_ date: String)
}
                                                
class CalendarView: UIView, FSCalendarDelegate, FSCalendarDataSource, FSCalendarDelegateAppearance {
    weak var delegate: CalendarViewDelegate?
    let shadowView = UIView()
    let calendar = FSCalendar().then { calendar in
        calendar.backgroundColor = .white
        calendar.scrollDirection = .horizontal
        calendar.tintColor = UIColor.secondaryYellow
        calendar.calendarWeekdayView.tintColor = UIColor.gray2
        calendar.appearance.weekdayTextColor = UIColor.gray2
        calendar.appearance.selectionColor = UIColor.secondaryYellow
        calendar.appearance.todaySelectionColor = UIColor.gray3
        calendar.headerHeight = 20
        calendar.appearance.headerMinimumDissolvedAlpha = 0
        calendar.appearance.headerDateFormat = "YYYY년 MM월"
        calendar.appearance.headerTitleFont = UIFont.body2()
        calendar.appearance.headerTitleColor = UIColor.secondaryYellow
        calendar.appearance.headerTitleAlignment = .center
        calendar.appearance.subtitleOffset = CGPoint(x: 0, y: 4)
        calendar.layer.cornerRadius = 10
    }
    
    lazy var dateFormatter = DateFormatter().then({ formatter in
        formatter.dateFormat = "yyyy.MM.dd"
    })

    var selectedDate: Date = Date()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setCalendarUI()
        backgroundColor = .white
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // 오늘 날짜로 돌아오는 버튼 및 액션
    @IBOutlet weak var currentBtn: UIButton!
    @IBAction func currentBtnClicked(_ sender: Any) {
        self.calendar.select(Date.now)
    }

    // 현재 달로 돌아오기 위해서는
    @IBAction func currentMonthBtnClicked(_ sender: Any) {
        self.calendar.setCurrentPage(Date(), animated: true)
    }

    func setCalendarUI() {
        addSubview(shadowView)
        shadowView.addSubview(calendar)
        self.setViewShadow(backView: shadowView)
        shadowView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        calendar.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
       
        // delegate, dataSource
        self.calendar.delegate = self
        self.calendar.dataSource = self
        
        // calendar locale > 한국으로 설정
        self.calendar.locale = Locale(identifier: "ko_KR")
        
        // 월~일 글자 폰트 및 사이즈 지정
        self.calendar.appearance.weekdayFont = UIFont.body0()
        // 숫자들 글자 폰트 및 사이즈 지정
        self.calendar.appearance.titleFont = UIFont.body2()
        
        // 캘린더 스크롤 가능하게 지정
        self.calendar.scrollEnabled = true
        
        
        // 요일 글자 색
        self.calendar.appearance.weekdayTextColor = UIColor.gray3
        
        // 양옆 년도, 월 지우기
        self.calendar.appearance.headerMinimumDissolvedAlpha = 0.0
        self.calendar.appearance.titleDefaultColor = UIColor.secondaryYellow
        // 달에 유효하지않은 날짜 지우기
        self.calendar.placeholderType = .none
        
        self.calendar.select(selectedDate)
    }

    // 날짜를 선택했을 때 할일을 지정
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        delegate?.didSelectDate(self, dateFormatter.string(from: date))
    }

    // 선택된 날짜의 채워진 색상 지정
    func calendar(_ calendar: FSCalendar, appearance: FSCalendarAppearance, fillSelectionColorFor date: Date) -> UIColor? {
        return appearance.selectionColor
    }

    // 선택된 날짜 테두리 색상
    func calendar(_ calendar: FSCalendar, appearance: FSCalendarAppearance, borderSelectionColorFor date: Date) -> UIColor? {
     
        return UIColor.secondaryYellow
    }

    
    // 모든 날짜의 채워진 색상 지정
    func calendar(_ calendar: FSCalendar, appearance: FSCalendarAppearance, fillDefaultColorFor date: Date) -> UIColor? {
        return UIColor.white
    }
    
    // title의 디폴트 색상
    func calendar(_ calendar: FSCalendar, appearance: FSCalendarAppearance, titleDefaultColorFor date: Date) -> UIColor? {
        return UIColor.secondaryYellow
    }
    // subtitle의 디폴트 색상
    func calendar(_ calendar: FSCalendar, appearance: FSCalendarAppearance, subtitleDefaultColorFor date: Date) -> UIColor? {
        return UIColor.gray3
    }
}


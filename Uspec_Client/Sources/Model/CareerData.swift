//
//  OutingActingPart.swift
//  Uspec_Client
//
//  Created by 진세진 on 2/15/24.
//

import Foundation
// 사용자가 선택
// MARK: - 대외활동 관련 데이터
struct OutingActingPart {
    var outingActionData : [SeveralOutignActPart] = []
}

struct SeveralOutignActPart {
    var outingActName : String
    var outingActPart : [String]
    var interestPart : [String]
    var interestDate : String
}

// MARK: - 공모전 관련 데이터
struct CompetitionPart {
    var competitionData : [SeveralOutignActPart] = []
}

struct SeveralCompetitionPart {
    var competitionName : String = ""
    var competitionPart : [String] = []
    var awardScalePart : String = ""
}

// MARK: - 인턴 관련 데이터
struct InternPart {
    var internData : [SeveralOutignActPart] = []
}

struct SeveralInternPart {
    var internName : String
    var startinternDate : Date
    var finishinternDate : Date
    var isWorking : Bool
    var workingPart : String
}

// MARK: - 자격증 관련 데이터
struct CertifivationPart {
    var certifivationData : [SeveralOutignActPart] = []
}

struct SeveralCertifivationPart {
    var certifivationName : String
    var certifivationDate : Date
}

// MARK: - 자격증 관련 데이터
struct CampusActingPart {
    var campusActingData : [SeveralOutignActPart] = []
}

struct SeveralCampusActingPart {
    var campusActingName : String
    var campusActingPart: [String]
    var campusActingContent : String
}


struct SelectCategoryInCareer {
    
    let actingPart = ["서포터즈",
                      "해외탐방 (무료 / 유료)",
                      "봉사단 (해외 / 국내)",
                      "마케터","기자단",
                      "강연", "멘토링",
                      "기타"
    ]
    let inTerestingPart = ["여행 / 호텔 / 항공",
                           "언론 / 미디어", "콘텐츠", "문화 / 역사",
                           "행사 / 페스티벌", "경제 / 금융", "교육",
                           "디자인 / 사진 / 예술 / 영상", "경영 / 컨설팅 / 마케팅",
                           "정치 / 사회 / 법률",
    ]
    
    let actingDate = ["3개월 이하", "3~6개월",
                      "6개월~1년","1년 이상"
    ]
    
    let competitionPart = [ "기획 / 아이디어" , "광고 / 마케팅", "과학 / 공학",
                            "사진 / 영상 / UCC", "디자인 / 순수미술 / 공예",
                            "네이밍 / 슬로건", "캐릭터 / 만화 / 게임",
                            "학술", "건축 / 건설 / 인테리어", "예체능 / 패션",
                            "창업", "전시 / 페스티벌", "문학 / 시나리오",
                            "해외"
    
    ]
    
    let awardScale = [ "1천만원 미만", "1~3천만원",
                       "3~5천만원" , "5천만원 이상"
    ]
    
    let campushActivities = [ "학생회", "홍보대사", "학교언론사", "홍보단",
                              "근로장학생", "교내동아리", "교내창업",
                              "교내 공모전", "학회", "랩실"
    
    ]
}



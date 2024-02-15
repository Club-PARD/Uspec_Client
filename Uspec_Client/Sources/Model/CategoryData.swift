//
//  MockData.swift
//  Uspec_Client
//
//  Created by 김하람 on 2/10/24.
//

import Foundation

struct TopCategory{
    var topCategory: String
}

extension TopCategory{
    static var model =
    [
        TopCategory(topCategory: "개발"),
        TopCategory(topCategory: "교육"),
        TopCategory(topCategory: "금융/재무"),
        TopCategory(topCategory: "기획/경영"),
        TopCategory(topCategory: "데이터"),
        TopCategory(topCategory: "디자인"),
        TopCategory(topCategory: "마케팅/시장조사"),
        TopCategory(topCategory: "미디어/홍보"),
        TopCategory(topCategory: "법률/법무"),
        TopCategory(topCategory: "생산/제조"),
        TopCategory(topCategory: "서비스/고객지원"),
        TopCategory(topCategory: "영업/제휴"),
        TopCategory(topCategory: "유통/무역"),
        TopCategory(topCategory: "인사/총무"),
        TopCategory(topCategory: "전문직"),
    ]
}


struct DetailCategory{
    var detailCategory: String
}

extension DetailCategory{
    static var model = [
        [
            DetailCategory(detailCategory: "CTO"),
            DetailCategory(detailCategory: "DBA"),
            DetailCategory(detailCategory: "ERP"),
            DetailCategory(detailCategory: "iOS개발"),
            DetailCategory(detailCategory: "QA"),
            DetailCategory(detailCategory: "VR엔지니어"),
            DetailCategory(detailCategory: "게임개발"),
            DetailCategory(detailCategory: "기술지원"),
            DetailCategory(detailCategory: "네트워크/보안/운영"),
            DetailCategory(detailCategory: "백엔드 개발"),
            DetailCategory(detailCategory: "소프트웨어개발"),
            DetailCategory(detailCategory: "안드로이드 개발"),
            DetailCategory(detailCategory: "웹퍼블리셔"),
            DetailCategory(detailCategory: "프론트엔드 개발"),
            DetailCategory(detailCategory: "하드웨어 개발"),
            DetailCategory(detailCategory: "클라우드 개발"),
            DetailCategory(detailCategory: "웹개발"),
            DetailCategory(detailCategory: "교육기획/교재개발"),
            DetailCategory(detailCategory: "문화기획"),
            DetailCategory(detailCategory: "그래픽디자인"),
            DetailCategory(detailCategory: "캐릭터디자인")
        ],
        [
            DetailCategory(detailCategory: "교육기획/교재개발"),
            DetailCategory(detailCategory: "외국어/어학원 강사"),
            DetailCategory(detailCategory: "유치원/보육교사"),
            DetailCategory(detailCategory: "전문강사"),
            DetailCategory(detailCategory: "입시/보습/학원 강사")

        ],
        [
            DetailCategory(detailCategory: "경리/츨납/결산"),
            DetailCategory(detailCategory: "보험계리사/손해사정인"),
            DetailCategory(detailCategory: "세무사"),
            DetailCategory(detailCategory: "손익/리스크관리"),
            DetailCategory(detailCategory: "외환/국제금융/펀드매니저"),
            DetailCategory(detailCategory: "은행원"),
            DetailCategory(detailCategory: "자산운용가"),
            DetailCategory(detailCategory: "재무기획/재무분석"),
            DetailCategory(detailCategory: "증권/투자분석가"),
            DetailCategory(detailCategory: "채권관리"),
            DetailCategory(detailCategory: "회계사")
        ],
        [
            DetailCategory(detailCategory: "CEO"),
            DetailCategory(detailCategory: "COO"),
            DetailCategory(detailCategory: "PM/PO"),
            DetailCategory(detailCategory: "게임 기획"),
            DetailCategory(detailCategory: "경영기획/전략"),
            DetailCategory(detailCategory: "경영지원"),
            DetailCategory(detailCategory: "문화기획"),
            DetailCategory(detailCategory: "사업기획"),
            DetailCategory(detailCategory: "서비스기획"),
            DetailCategory(detailCategory: "전략기획"),
            DetailCategory(detailCategory: "경영/컨설팅/마케팅"),
            DetailCategory(detailCategory: "행사기획")
        ],
        [
            DetailCategory(detailCategory: "데이터분석가"),
            DetailCategory(detailCategory: "데이터엔지니어"),
            DetailCategory(detailCategory: "빅데이터엔지니어"),
            DetailCategory(detailCategory: "BI엔지니어"),
            DetailCategory(detailCategory: "데이서 사이언티스트"),
            DetailCategory(detailCategory: "머신러닝엔지니어")
        ],
        [
            DetailCategory(detailCategory: "건축/설계디자인"),
            DetailCategory(detailCategory: "그래픽디자인"),
            DetailCategory(detailCategory: "브랜드디자인"),
            DetailCategory(detailCategory: "영상/모션디자인"),
            DetailCategory(detailCategory: "일러스트레이터"),
            DetailCategory(detailCategory: "제품/산업디자인"),
            DetailCategory(detailCategory: "캐릭터디자인"),
            DetailCategory(detailCategory: "UI/UX/GUI디자인"),
            DetailCategory(detailCategory: "광고/시각디자인"),
            DetailCategory(detailCategory: "출판/편집디자인")
        ],
        [
            DetailCategory(detailCategory: "마케팅"),
            DetailCategory(detailCategory: "브랜드마케팅"),
            DetailCategory(detailCategory: "시장조사/분석"),
            DetailCategory(detailCategory: "전략마케팅"),
            DetailCategory(detailCategory: "CRM"),
            DetailCategory(detailCategory: "마케팅커뮤니케이션"),
            DetailCategory(detailCategory: "상품개발/기획/MD")
        ],
        [
            DetailCategory(detailCategory: "광고기획/카피라이터"),
            DetailCategory(detailCategory: "대외협력"),
            DetailCategory(detailCategory: "작가/시나리오"),
            DetailCategory(detailCategory: "방송연출/PD/감독"),
            DetailCategory(detailCategory: "인쇄/출판/편집"),
            DetailCategory(detailCategory: "진행/아나운서"),
            DetailCategory(detailCategory: "홍보")
        ],
        [
            DetailCategory(detailCategory: "법률/법무"),
            DetailCategory(detailCategory: "특허/변리사"),
            DetailCategory(detailCategory: "감사"),
            DetailCategory(detailCategory: "변호사")
        ],
        [
            DetailCategory(detailCategory: "기계/기계설비"),
            DetailCategory(detailCategory: "반도체/디스플레이"),
            DetailCategory(detailCategory: "생산/제조"),
            DetailCategory(detailCategory: "포장/조립"),
            DetailCategory(detailCategory: "금속/금형"),
            DetailCategory(detailCategory: "바이오/제약/식품"),
            DetailCategory(detailCategory: "섬유/의류/패션"),
            DetailCategory(detailCategory: "전기/전자/제어")
        ],
        [
            DetailCategory(detailCategory: "고객지원/CS"),
            DetailCategory(detailCategory: "여행가이드"),
            DetailCategory(detailCategory: "호텔리어"),
            DetailCategory(detailCategory: "스튜어디스/승무원"),
            DetailCategory(detailCategory: "외식업/식음료"),
            DetailCategory(detailCategory: "의전"),
            DetailCategory(detailCategory: "경호/경비원")
        ],
        [
            DetailCategory(detailCategory: "국내영업"),
            DetailCategory(detailCategory: "기술영업"),
            DetailCategory(detailCategory: "의약영업"),
            DetailCategory(detailCategory: "판매/매장관리"),
            DetailCategory(detailCategory: "IT/솔루션영업"),
            DetailCategory(detailCategory: "금융/보험영업"),
            DetailCategory(detailCategory: "영업기획/관리/지원"),
            DetailCategory(detailCategory: "텔레마케팅")
        ],
        [
            DetailCategory(detailCategory: "구매/자재/재고"),
            DetailCategory(detailCategory: "수출입관리"),
            DetailCategory(detailCategory: "프로젝트/자원개발"),
            DetailCategory(detailCategory: "관세사"),
            DetailCategory(detailCategory: "물류/유통/운송")
        ],
        [
            DetailCategory(detailCategory: "노무"),
            DetailCategory(detailCategory: "사무보조/문서작성"),
            DetailCategory(detailCategory: "인재개발/교육"),
            DetailCategory(detailCategory: "채용"),
            DetailCategory(detailCategory: "비서/안내/수행원"),
            DetailCategory(detailCategory: "인사관리"),
            DetailCategory(detailCategory: "조직문화"),
            DetailCategory(detailCategory: "총무/사무"),
            DetailCategory(detailCategory: "헤드헌터")
        ],
        [
            DetailCategory(detailCategory: "문화/예술/스포츠"),
            DetailCategory(detailCategory: "사서/문서관리"),
            DetailCategory(detailCategory: "종교"),
            DetailCategory(detailCategory: "프로게이머"),
            DetailCategory(detailCategory: "행정사"),
            DetailCategory(detailCategory: "감정사/평가사/경매사"),
            DetailCategory(detailCategory: "부동산/공인중개사"),
            DetailCategory(detailCategory: "상담사"),
            DetailCategory(detailCategory: "통역/번역"),
            DetailCategory(detailCategory: "항공기조종사/항해사")
        ]
    ]
}

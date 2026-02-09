//
//  Item.swift
//  test
//
//  Created by 손영빈 on 2/3/26.
//

import Foundation

// 1. 모델 정의
struct Item {
    let id: Int
    let name: String
    let category: String // 상의, 하의, 신발, 무기
    let grade: String    // 일반, 레전더리
    let price: Int
    let imageName: String
}

// 2. 전체 데이터 저장소
struct ItemData {
    static let allItems: [Item] = {
        var items: [Item] = []
        var currentID = 1
        
        // --- 1. 무기 (weapon) ---
        let weaponsLeg = ["페어리피코", "피의 서약", "세레니티 프레이어", "죽음의 데스"]
        let weaponsNor = ["원킬의 검", "토끼 찹쌀떡", "장검", "베리베리", "검사의 양손검", "강철구 망치", "톱", "연보라 우산", "화염의 카타나", "돼지치기 막대", "달콤 포크", "삐약삐약 병아리", "분홍 튜브", "훌라후프", "007가방"]
        
        
        
        items += createItems(names: weaponsLeg, category: "무기", grade: "레전더리", imgPrefix: "legendary_weapon", startID: &currentID)
        items += createItems(names: weaponsNor, category: "무기", grade: "일반", imgPrefix: "weapon", startID: &currentID)
        
        // --- 2. 상의 (top) ---
        let topsLeg = ["핑크빈 내복 상의", "슬라임 내복 상의", "예티 내복 상의", "신비한 내복 상의"]
        let topsNor = ["회갈색 수련복", "RED 티셔츠", "유치원 옷", "죄수복", "보우타이 셔츠", "그린 냥이 티셔츠", "정열의 내복 상의", "파릇파릇 잎사귀", "[MS특제] 빨간색 더플코트", "두근두근 후디", "딸기셔츠", "훈 티셔츠", "민 티셔츠", "정 티셔츠", "음 티셔츠"]
        
        items += createItems(names: topsLeg, category: "상의", grade: "레전더리", imgPrefix: "legendary_top", startID: &currentID)
        items += createItems(names: topsNor, category: "상의", grade: "일반", imgPrefix: "top", startID: &currentID)
        
        // --- 3. 하의 (bottom) ---
        let bottomsLeg = ["핑크빈 내복 하의", "슬라임 내복 하의", "예티 내복 하의", "신비한 내복 하의"]
        let bottomsNor = ["하이퍼 펑키 실로폰 레깅스", "빨기 쇼콜라 팬츠", "오션블루 워싱진", "정열의 내복 하의", "옐로우 롱 플레어 스커트", "하와이안 하의", "옛날군복 바지", "별모래 힙합청바지", "죄수복 하의", "SK 농구복 하의", "불꽃바지", "무지개 통바지", "변신용 레드 레골리스 바지", "단무Gee 팬츠", "도트 블루 데님 팬츠", "사무엘 팬츠"]
        
        items += createItems(names: bottomsLeg, category: "하의", grade: "레전더리", imgPrefix: "legendary_bottom", startID: &currentID)
        items += createItems(names: bottomsNor, category: "하의", grade: "일반", imgPrefix: "bottom", startID: &currentID)
        
        // --- 4. 모자 (hat) ---
        let hatsLeg = ["혼돈의 명령", "로열티 크라운", "폭신 레이스 귀마개", "폭신 눈사람 귀마개"]
        let hatsNor = ["핑크빈 스쿠터 헬멧", "브로콜리 모자", "포롱 동글모자", "민트초코 아이스크림 모자", "네온 다이아 머리띠", "달콤 버섯갓", "겨울여우 머리띠", "말랑 주황버섯 귀마개", "하늘 모래 신캡", "헤네시스 고깔", "튀김의 정령", "쑥쑥 새싹 모자", "내츄럴 도로시 탈", "영광의 얼굴", "대왕 붕어빵", "메신쥐 모자"]
        
        items += createItems(names: hatsLeg, category: "모자", grade: "레전더리", imgPrefix: "legendary_hat", startID: &currentID)
        items += createItems(names: hatsNor, category: "모자", grade: "일반", imgPrefix: "hat", startID: &currentID)
        
        // --- 5. 신발 (shoes) ---
        let shoesLeg = ["별빛 걸음", "파멸의 궤적", "해답의 조각", "아너 마제스티"]
        let shoesNor = ["뽀송 다람", "해바라기 꽃신", "햇살 여우 넝굴", "구름 깃털", "나비선", "토끼곰 슬리퍼", "훌라훌라 구슬발찌", "카카오베어 슈즈", "꽃게도 갈게", "팡팡 범퍼카 슈즈", "서커스 방울 신발", "매화나무 나막신", "슬라임 슬리퍼", "하이틴 롤러스케이트", "정열적인 당화"]
        
        items += createItems(names: shoesLeg, category: "신발", grade: "레전더리", imgPrefix: "legendary_shoes", startID: &currentID)
        items += createItems(names: shoesNor, category: "신발", grade: "일반", imgPrefix: "shoes", startID: &currentID)
        
        return items
    }()
    
    private static func createItems(names: [String], category: String, grade: String, imgPrefix: String, startID: inout Int) -> [Item] {
        return names.enumerated().map { index, name in
            let item = Item(
                id: startID,
                name: name,
                category: category,
                grade: grade,
                price: 1000, // 요청하신 대로 전부 0원 적용
                imageName: "\(imgPrefix)\(index + 1)" // 예: hat1, legendary_hat1
            )
            startID += 1
            return item
        }
    }
}

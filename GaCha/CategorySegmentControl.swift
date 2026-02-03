//
//  CategorySegmentControl.swift
//  GaCha
//
//  Created by 변예린 on 2/3/26.
//

import UIKit

class CategorySegmentControl: UISegmentedControl {
    //TODO: 색깔 변경?
    override init(frame: CGRect) {
        super.init(frame: frame)
        setSegments()
        selectedSegmentIndex = 0 // 초기 선택값 설정
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

//MARK: Configure Components
extension CategorySegmentControl {
    func setSegments() {
        let categories = ["가챠", "상의", "하의", "신발", "무기"]
        
        for i in categories.indices {
            self.insertSegment(withTitle: categories[i], at: i, animated: true)
        }
    }
}

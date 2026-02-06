//
//  CategorySegmentControl.swift
//  GaCha
//
//  Created by 변예린 on 2/3/26.
//

import UIKit

class CategorySegmentedControl: UISegmentedControl {
    weak var delegate: CategorySegmentedControlDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setSegments()
        selectedSegmentIndex = 0 // 초기 선택값 설정
        
        selectedSegmentTintColor = .mushroomOrange // 선택 시 색상
        setTitleTextAttributes([.foregroundColor: UIColor.white], for: .selected) // 선택 시 글자 색상
        backgroundColor = UIColor(red: 0.99, green: 0.96, blue: 0.92, alpha: 1.00) // 배경 색상 설정 - #fcf5eb
        
        setAction()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        // 시스템은 기본적으로 각 세그먼트에 회색 이미지 뷰를 배치함 - backgroundColor를 보이게 하기 위해 해당 이미지뷰를 가림
        let imageViews = subviews.compactMap { $0 as? UIImageView }.prefix(numberOfSegments)
        imageViews.forEach { $0.isHidden = true }
    }
    
}

//MARK: Configure Components
extension CategorySegmentedControl {
    private func setSegments() {
        GachaCategory.allCases.enumerated().forEach { (index, category) in
            self.insertSegment(withTitle: category.rawValue, at: index, animated: true)
        }
        
    }
}

//MARK: Set Action
extension CategorySegmentedControl {
    private func setAction() {
        let changeSegment = UIAction { [unowned self] _ in
            let selected = self.titleForSegment(at: self.selectedSegmentIndex)
            self.delegate?.categorySegmentedControlChanged(selected)
        }
        
        self.addAction(changeSegment, for: .valueChanged)
    }
}

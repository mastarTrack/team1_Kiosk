//
//  MainView.swift
//  GaCha
//
//  Created by 변예린 on 2/3/26.
//

import UIKit
import SnapKit

class MainView: UIView {
    
    private let mesoStack = MesoStackView()
    let categorySegment = CategorySegmentedControl(frame: .zero)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        
        let titleLabel = makeTitleLabel()

        addSubview(titleLabel)
        addSubview(mesoStack)
        addSubview(categorySegment)
        
        
        titleLabel.snp.makeConstraints {
            $0.leading.trailing.equalTo(safeAreaLayoutGuide).inset(20)
            $0.top.equalTo(safeAreaLayoutGuide).offset(10)
        }
        
        mesoStack.snp.makeConstraints {
            $0.leading.trailing.equalTo(safeAreaLayoutGuide).inset(20)
            $0.top.equalTo(titleLabel.snp.bottom).offset(10)
        }
        
        categorySegment.snp.makeConstraints {
            $0.leading.trailing.equalTo(safeAreaLayoutGuide).inset(20)
            $0.top.equalTo(mesoStack.snp.bottom).offset(10)
        }
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

//MARK: Configure Components
extension MainView {
    // 타이틀 레이블 생성
    private func makeTitleLabel() -> UILabel {
        let label = UILabel()
        
        label.text = "GaCha!"
        label.textColor = .black
        label.font = .boldSystemFont(ofSize: 24)
        label.textAlignment = .center
        
        return label
    }

}

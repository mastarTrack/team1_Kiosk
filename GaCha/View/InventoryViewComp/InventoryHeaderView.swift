//
//  InventoryHeaderView.swift
//  GaCha
//
//  Created by 손영빈 on 2/5/26.
//

import UIKit
import SnapKit

class InventoryHeaderView: UIView {
    
    let stackView = UIStackView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setAttributes()
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension InventoryHeaderView {
    private func setAttributes() {
        
        stackView.axis = .horizontal
        stackView.distribution = .fill
        stackView.alignment = .center
        stackView.spacing = 5
        
        let infoTitles = ["", "아이템", "수량", "가격", ""]
        infoTitles.enumerated().forEach { index, title in
            let label = UILabel()
            label.text = title
            label.textColor = .black
            label.font = .systemFont(ofSize: 14, weight: .semibold)
            label.textAlignment = (index == 1) ? .left : .center
            stackView.addArrangedSubview(label)
        }
    }
    
    private func setLayout() {
        
        addSubview(stackView)
        
        stackView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        stackView.arrangedSubviews[0].snp.makeConstraints {
            $0.width.equalTo(stackView.snp.width).multipliedBy(0.1)
        }
        stackView.arrangedSubviews[1].snp.makeConstraints {
            $0.width.equalTo(stackView.snp.width).multipliedBy(0.3)
        }
        stackView.arrangedSubviews[2].snp.makeConstraints {
            $0.width.equalTo(stackView.snp.width).multipliedBy(0.1)
        }
        stackView.arrangedSubviews[3].snp.makeConstraints {
            $0.width.equalTo(stackView.snp.width).multipliedBy(0.3)
        }
    }
}

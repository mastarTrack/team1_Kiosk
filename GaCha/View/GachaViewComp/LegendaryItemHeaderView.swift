//
//  LegendaryItemHeaderView.swift
//  GaCha
//
//  Created by 변예린 on 2/5/26.
//
import UIKit
import SnapKit

class LegendaryItemHeaderView: UICollectionReusableView {
    private let label = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(label)
        
        label.snp.makeConstraints {
            $0.directionalEdges.equalToSuperview()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension LegendaryItemHeaderView {
    func configLegendaryItemSection() {
        label.text = "아무도 갖지 못한 아이템을 뽑아라!"
        label.font = .boldSystemFont(ofSize: 20)
        label.textAlignment = .center
    }
    
    func configResultTableSection() {
        label.text = "뽑기 결과"
        label.font = .systemFont(ofSize: 16, weight: .semibold)
        label.textColor = .darkGray
        label.textAlignment = .left
    }
}

//
//  LegendaryItemHeaderView.swift
//  GaCha
//
//  Created by 변예린 on 2/5/26.
//
import UIKit
import SnapKit

class LegendaryItemHeaderView: UICollectionReusableView {
    let label = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        label.font = .boldSystemFont(ofSize: 20)
        label.textAlignment = .center
        
        addSubview(label)
        
        label.snp.makeConstraints {
            $0.directionalEdges.equalToSuperview()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

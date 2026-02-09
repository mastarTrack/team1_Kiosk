//
//  LegendaryItemHeaderView.swift
//  GaCha
//
//  Created by 변예린 on 2/5/26.
//
import UIKit
import SnapKit

class GachaCollectionHeaderView: UICollectionReusableView {
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

extension GachaCollectionHeaderView {
    func config(_ section: Int) {
        if section == 0 { // Legendary Item List 섹션
            label.text = "아무도 갖지 못한 아이템을 뽑아라!"
            label.font = .boldSystemFont(ofSize: 20)
            label.textAlignment = .center
            label.textColor = .black
        } else if section == 2 { // Result Table 섹션
            label.text = "뽑기 결과"
            label.font = .systemFont(ofSize: 15, weight: .bold)
            label.textColor = .mushroomOrange
            label.textAlignment = .left
        }
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.5
    }
}

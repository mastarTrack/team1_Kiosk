//
//  GachaButtonCell.swift
//  GaCha
//
//  Created by 변예린 on 2/5/26.
//

import UIKit
import SnapKit

class GachaButtonCell: UICollectionViewCell {
    let label = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(label)
        
        contentView.layer.cornerRadius = 12
        contentView.backgroundColor = .mushroomOrange
        label.textColor = .white
        label.font = .systemFont(ofSize: 15, weight: .semibold)
        
        label.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension GachaButtonCell {
    func config(with title: String) {
        label.text = title
    }
}

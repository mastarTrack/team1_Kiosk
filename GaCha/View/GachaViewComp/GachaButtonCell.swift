//
//  GachaButtonCell.swift
//  GaCha
//
//  Created by 변예린 on 2/5/26.
//

import UIKit
import SnapKit

class GachaButtonCell: UICollectionViewCell {
    let button = ActionButton(title: "")
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentView.addSubview(button)
        button.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.width.equalToSuperview().multipliedBy(0.5)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension GachaButtonCell {
    func config(with title: String) {
        button.setTitle(title, for: .normal)
    }
}

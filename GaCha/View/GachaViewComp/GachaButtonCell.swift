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
    let label = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setAttribute()
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension GachaButtonCell {
    func setAttribute() {
        label.font = .systemFont(ofSize: 16, weight: .semibold)
        label.textColor = .white
        label.textAlignment = .center
        
        label.backgroundColor = .mushroomOrange
        label.layer.cornerRadius = 10
        label.clipsToBounds = true
    }
    
    func setLayout() {
        contentView.addSubview(label)
        label.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.width.equalToSuperview()
            $0.height.equalTo(label.snp.width).multipliedBy(0.4)
        }
    }
    
    func config(with title: String) {
        button.setTitle(title, for: .normal)
        label.text = title
    }
}

//
//  LegendaryListCollectionCell.swift
//  GaCha
//
//  Created by 변예린 on 2/4/26.
//

import UIKit
import SnapKit

class LegendaryListCollectionCell: UICollectionViewCell {
    let imageView = UIImageView()
    let nameLabel = UILabel()    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setAttributes()
        
        addSubview(imageView)
        addSubview(nameLabel)
        
        imageView.snp.makeConstraints {
            $0.width.height.equalTo(50)
            $0.centerX.equalToSuperview()
            $0.top.equalToSuperview().offset(8)
        }
        
        nameLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(imageView.snp.bottom).offset(8)
            $0.bottom.equalToSuperview().offset(-8)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

//MARK: Set attributes
extension LegendaryListCollectionCell {
    func setAttributes() {
        imageView.contentMode = .scaleAspectFit
        
        nameLabel.font = .systemFont(ofSize: 16, weight: .semibold)
        nameLabel.textColor = .black
        nameLabel.numberOfLines = 0
    }
}

//MARK: Set Contents
extension LegendaryListCollectionCell {
    func config(with item: Item) {
        imageView.image = UIImage(named: item.imageName)
        nameLabel.text = item.name
    }
}

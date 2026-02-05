//
//  GachaResultCell.swift
//  GaCha
//
//  Created by 변예린 on 2/5/26.
//

import UIKit
import SnapKit

class GachaResultCell: UICollectionViewListCell {
    let imageView = UIImageView()
    let nameLabel = UILabel()
    let gradeLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setAttributes()
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension GachaResultCell {
    private func setAttributes() {
        imageView.contentMode = .scaleAspectFit
        
        nameLabel.font = .systemFont(ofSize: 16, weight: .semibold)
        nameLabel.textColor = .black
        
        gradeLabel.font = .systemFont(ofSize: 14)
        gradeLabel.textColor = .darkGray
    }
    
    private func setLayout() {
        contentView.addSubview(imageView)
        contentView.addSubview(nameLabel)
        contentView.addSubview(gradeLabel)
        
        imageView.snp.makeConstraints {
            $0.leading.equalToSuperview()
            $0.centerY.equalToSuperview()
            $0.size.equalTo(50)
        }
        
        nameLabel.snp.makeConstraints {
            $0.leading.equalTo(imageView.snp.trailing).offset(10)
            $0.top.equalToSuperview().offset(7)
        }
        
        gradeLabel.snp.makeConstraints {
            $0.leading.equalTo(imageView.snp.trailing).offset(10)
            $0.top.equalTo(nameLabel.snp.bottom).offset(5)
        }
    }
}

extension GachaResultCell {
    func config(with item: Item) {
        imageView.image = UIImage(named: item.imageName)
        nameLabel.text = item.name
        gradeLabel.text = "\(item.grade)"
    }
}

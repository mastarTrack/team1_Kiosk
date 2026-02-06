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
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.contentView.layoutIfNeeded()
    }
}

extension GachaResultCell {
    private func setAttributes() {
        imageView.contentMode = .scaleAspectFit
        
        nameLabel.font = .systemFont(ofSize: 16, weight: .semibold)
        nameLabel.textColor = .black
        nameLabel.setContentHuggingPriority(.defaultHigh + 1, for: .vertical)
        nameLabel.adjustsFontSizeToFitWidth = true
        nameLabel.minimumScaleFactor = 0.6
        
        gradeLabel.font = .systemFont(ofSize: 14)
        gradeLabel.textColor = .darkGray
        gradeLabel.adjustsFontSizeToFitWidth = true
        gradeLabel.minimumScaleFactor = 0.6
    
        contentView.backgroundColor = .apricot
    }
    
    private func setLayout() {
        contentView.addSubview(imageView)
        
        let labelStack = UIStackView(arrangedSubviews: [nameLabel, gradeLabel])
        labelStack.axis = .vertical
        labelStack.spacing = 5

        contentView.addSubview(labelStack)
        
        imageView.snp.makeConstraints {
            $0.top.bottom.leading.equalToSuperview()
            $0.size.equalTo(44)
        }
        
        labelStack.snp.makeConstraints {
            $0.centerY.equalTo(imageView)
            $0.leading.equalTo(imageView.snp.trailing).offset(10)
            $0.trailing.equalToSuperview()
        }
    }
}

extension GachaResultCell {
    func config(with item: Item) {
        imageView.image = UIImage(named: item.imageName)
        nameLabel.text = item.name
        gradeLabel.text = "\(item.grade)"
        
        if gradeLabel.text == "레전더리" {
            contentView.backgroundColor = .mushroomOrange
        } else {
            contentView.backgroundColor = .apricot
        }
    }
}

//
//  ItemCell.swift
//  GaCha
//
//  Created by 손영빈 on 2/4/26.
//

import UIKit
import SnapKit

class ItemCell: UITableViewCell {
    let itemImageView = UIImageView()
    let itemNameLabel = UILabel()
    let itemPriceLabel = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setAttributes()
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension ItemCell {
    private func setAttributes() {
        itemImageView.contentMode = .scaleAspectFit
        itemImageView.clipsToBounds = true
        
        itemNameLabel.font = .systemFont(ofSize: 16, weight: .semibold)
        itemNameLabel.textColor = .black
        
        itemPriceLabel.font = .systemFont(ofSize: 14)
        itemPriceLabel.textColor = .darkGray
    }
    
    private func setLayout() {
        [itemImageView, itemNameLabel, itemPriceLabel].forEach { contentView.addSubview($0) }
        
        itemImageView.snp.makeConstraints {
            $0.leading.equalToSuperview()
            $0.centerY.equalToSuperview()
            $0.size.equalTo(50)
        }
        
        itemNameLabel.snp.makeConstraints {
            $0.leading.equalTo(itemImageView.snp.trailing).offset(10)
            $0.top.equalToSuperview().offset(5)
        }
        
        itemPriceLabel.snp.makeConstraints {
            $0.leading.equalTo(itemImageView.snp.trailing).offset(10)
            $0.top.equalTo(itemNameLabel.snp.bottom).offset(5)
        }
    }
}

extension ItemCell {
    func config(with item: Item) {
        itemImageView.image = UIImage(named: item.imageName)
        itemNameLabel.text = item.name
        
        let formatter = FormatterManager()
        itemPriceLabel.text = formatter.setMesoToString(meso: item.price)
    }
}

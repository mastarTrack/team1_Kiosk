//
//  InventoryItemCell.swift
//  GaCha
//
//  Created by 손영빈 on 2/5/26.
//

import UIKit
import SnapKit

class InventoryItemCell: UITableViewCell {
    
    weak var delegate: InventoryItemCellDelegate?
    
    let itemImageView = UIImageView()
    let itemNameLabel = UILabel()
    let itemCountLabel = UILabel()
    let itemPriceLabel = UILabel()
    let sellButton = UIButton()
    
    let stackView = UIStackView()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setAttributes()
        setLayout()
        
        setAction()
        
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension InventoryItemCell {
    private func setAttributes() {
        
        itemImageView.contentMode = .scaleAspectFit
        itemImageView.clipsToBounds = true
        
        itemNameLabel.font = .systemFont(ofSize: 15, weight: .semibold)
        itemNameLabel.textColor = .black
        itemNameLabel.textAlignment = .left
        
        [itemCountLabel, itemPriceLabel].forEach {
            $0.font = .systemFont(ofSize: 13)
            $0.textColor = .darkGray
            $0.textAlignment = .center
        }
        
        sellButton.setTitle("판매", for: .normal)
        sellButton.titleLabel?.font = .systemFont(ofSize: 13, weight: .semibold)
        sellButton.backgroundColor = .mushroomOrange
        sellButton.layer.cornerRadius = 12
        
        stackView.axis = .horizontal
        stackView.distribution = .fill
        stackView.alignment = .center
        stackView.spacing = 5
        
    }
    
    private func setLayout() {
        
        contentView.addSubview(stackView)
        
        [itemImageView, itemNameLabel, itemCountLabel, itemPriceLabel, sellButton]
            .forEach { stackView.addArrangedSubview($0) }
        
        stackView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        itemImageView.snp.makeConstraints {
            $0.width.height.equalTo(stackView.snp.width).multipliedBy(0.1)
        }
        itemNameLabel.snp.makeConstraints {
            $0.width.equalTo(stackView.snp.width).multipliedBy(0.3)
        }
        itemCountLabel.snp.makeConstraints {
            $0.width.equalTo(stackView.snp.width).multipliedBy(0.1)
        }
        itemPriceLabel.snp.makeConstraints {
            $0.width.equalTo(stackView.snp.width).multipliedBy(0.3)
        }
        sellButton.snp.makeConstraints {
            $0.height.equalTo(stackView.snp.height).multipliedBy(0.7)
        }
    }
}


extension InventoryItemCell {
    func config(with purchaseItem: PurchaseItem) {
        itemImageView.image = UIImage(named: purchaseItem.item.imageName)
        itemNameLabel.text = purchaseItem.item.name
        itemCountLabel.text = "\(purchaseItem.count)"
        
        let formatter = FormatterManager()
        itemPriceLabel.text = formatter.setMesoToString(meso: purchaseItem.totalPrice)
    }
}

extension InventoryItemCell {
    private func setAction() {
        sellButton.addTarget(self, action: #selector(sellButtonTapped), for: .touchUpInside)
    }
    
    @objc
    private func sellButtonTapped() {
        delegate?.didTapSellButton(with: self)
    }
}

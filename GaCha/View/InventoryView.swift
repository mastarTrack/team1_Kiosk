//
//  InventoryView.swift
//  GaCha
//
//  Created by 손영빈 on 2/5/26.
//

import SnapKit
import UIKit

class InventoryView: UIView {
    
    
    let titleLabel = UILabel()
    let infoStackView = UIStackView()
    let spaceView = UIView()
    let contentScackView = UIStackView()
    let sellAllButton = UIButton()
    
    let inventoryTableView = InventoryTableView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        
        setAttributes()
        setLayout()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension InventoryView {
    private func setAttributes() {
        
        titleLabel.text = "인벤토리"
        titleLabel.textColor = .black
        titleLabel.font = .systemFont(ofSize: 24, weight: .bold)
        
        infoStackView.axis = .horizontal
        infoStackView.distribution = .fill
        infoStackView.alignment = .center
        infoStackView.spacing = 5
        
        let infoTitles = ["아이템", "수량", "가격", ""]
        infoTitles.enumerated().forEach { index, infoTitle in
            let label = UILabel()
            label.text = infoTitle
            label.textColor = .black
            label.font = .systemFont(ofSize: 14, weight: .semibold)
            label.textAlignment = (index == 0) ? .left : .center
            contentScackView.addArrangedSubview(label)
        }
        
        
        sellAllButton.setTitle("전체 판매", for: .normal)
        sellAllButton.setTitleColor( .white, for: .normal)
        sellAllButton.backgroundColor = .mushroomOrange
        sellAllButton.layer.cornerRadius = 12
        
        contentScackView.axis = .horizontal
        contentScackView.distribution = .fill
        contentScackView.alignment = .center
    }
    
    private func setLayout() {
        [titleLabel, infoStackView, inventoryTableView, sellAllButton].forEach {
            addSubview($0)
        }
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(safeAreaLayoutGuide).offset(20)
            $0.leading.equalToSuperview().offset(20)
        }
        infoStackView.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(20)
            $0.leading.trailing.equalToSuperview().inset(20)
        }
        
        [spaceView, contentScackView].forEach {
            infoStackView.addArrangedSubview($0)
        }
        
        spaceView.snp.makeConstraints {
            $0.width.equalTo(50)
        }
        
        contentScackView.arrangedSubviews[0].snp.makeConstraints {
            $0.width.equalTo(contentScackView.snp.width).multipliedBy(0.35)
        }
        contentScackView.arrangedSubviews[1].snp.makeConstraints {
            $0.width.equalTo(contentScackView.snp.width).multipliedBy(0.1)
        }
        contentScackView.arrangedSubviews[2].snp.makeConstraints {
            $0.width.equalTo(contentScackView.snp.width).multipliedBy(0.35)
        }
        contentScackView.arrangedSubviews[3].snp.makeConstraints {
            $0.width.equalTo(contentScackView.snp.width).multipliedBy(0.2)
        }
        
        inventoryTableView.snp.makeConstraints {
            $0.top.equalTo(infoStackView.snp.bottom).offset(20)
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.bottom.equalTo(sellAllButton.snp.top).offset(-20)
        }
        sellAllButton.snp.makeConstraints {
            $0.bottom.equalTo(safeAreaLayoutGuide)
            $0.trailing.equalTo(safeAreaLayoutGuide).offset(-20)
            $0.width.equalTo(100)
        }
    }
}

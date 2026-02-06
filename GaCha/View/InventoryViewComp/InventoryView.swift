//
//  InventoryView.swift
//  GaCha
//
//  Created by 손영빈 on 2/5/26.
//

import SnapKit
import UIKit

class InventoryView: UIView {
    
    weak var delegate: InventoryViewDelegate?
    
    let titleLabel = UILabel()
    let sellAllButton = UIButton()
    
    let inventoryTableView = InventoryTableView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        
        setAttributes()
        setLayout()
        inventoryTableView.showsVerticalScrollIndicator = false
        setAction()
        
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
        
        sellAllButton.setTitle("전체 판매", for: .normal)
        sellAllButton.titleLabel?.font = .systemFont(ofSize: 16, weight: .semibold)
        sellAllButton.setTitleColor( .white, for: .normal)
        sellAllButton.backgroundColor = .mushroomOrange
        sellAllButton.layer.cornerRadius = 12
    }
    
    private func setLayout() {
        
        [titleLabel, inventoryTableView, sellAllButton].forEach {
            addSubview($0)
        }
        
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(safeAreaLayoutGuide).offset(20)
            $0.leading.equalToSuperview().offset(20)
        }
        
        sellAllButton.snp.makeConstraints {
            $0.top.equalTo(safeAreaLayoutGuide).offset(20)
            $0.trailing.equalToSuperview().offset(-20)
            $0.width.equalTo(100)
        }
        
        inventoryTableView.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(20)
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.bottom.equalToSuperview()
        }
    }
}

extension InventoryView {
    private func setAction() {
        sellAllButton.addTarget(self, action: #selector(sellAllButtonTapped), for: .touchUpInside)
    }
    
    @objc
    private func sellAllButtonTapped() {
        delegate?.didTapSellAllButton()
    }
}

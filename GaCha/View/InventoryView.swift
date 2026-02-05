//
//  InventoryView.swift
//  GaCha
//
//  Created by 손영빈 on 2/5/26.
//

import SnapKit
import UIKit

class InventoryView: UIView {
    
    let inventoryTableView = InventoryTableView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        
        addSubview(inventoryTableView)
        
        inventoryTableView.snp.makeConstraints {
            $0.directionalEdges.equalToSuperview()
        }
        
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

//
//  PurchaseButton.swift
//  GaCha
//
//  Created by 손영빈 on 2/4/26.
//

import UIKit
import SnapKit

class ActionButton: UIButton {
    
    init(title: String) {
        super.init(frame: .zero)
        self.setTitle(title, for: .normal)
        setAttributes()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension ActionButton {
    private func setAttributes() {
        self.setTitleColor(.white, for: .normal)
        
        self.backgroundColor = .mushroomOrange
        self.layer.cornerRadius = 12
        self.titleLabel?.font = .systemFont(ofSize: 16, weight: .semibold)
        
    }
}

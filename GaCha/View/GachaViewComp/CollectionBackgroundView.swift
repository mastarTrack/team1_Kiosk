//
//  CollectionBackgroundView.swift
//  GaCha
//
//  Created by t2025-m0143 on 2/8/26.
//

import UIKit
import SnapKit

final class CollectionBackgroundView: UICollectionReusableView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        let view = UIView()
        
        view.backgroundColor = .apricot
        view.layer.cornerRadius = 16
        view.clipsToBounds = true
        view.layer.borderColor = UIColor.mushroomOrange.cgColor
        view.layer.borderWidth = 0.2
        
        addSubview(view)
        
        view.snp.makeConstraints {
            $0.top.equalToSuperview().offset(32)
            $0.bottom.equalToSuperview().offset(-28)
            $0.horizontalEdges.equalToSuperview().inset(-15)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

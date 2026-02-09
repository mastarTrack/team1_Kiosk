//
//  MesoBadgeView.swift
//  GaCha
//
//  Created by 변예린 on 2/6/26.
//

import UIKit
import SnapKit

final class MesoBadgeView: UICollectionReusableView {
    private let imageView = UIImageView(image: .meso)
    private let label = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setAttribute()
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension MesoBadgeView {
    func setAttribute() {
        layer.cornerRadius = 10
        backgroundColor = .apricot.withAlphaComponent(0.9)
        
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
      
        label.font = .systemFont(ofSize: 10, weight: .medium)
        label.textColor = .black
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.5
        label.setContentHuggingPriority(.defaultHigh + 1, for: .horizontal)
    }
    
    func setLayout() {
        addSubview(imageView)
        addSubview(label)
        
        imageView.snp.makeConstraints {
            $0.leading.top.bottom.equalToSuperview().inset(2)
            $0.width.equalTo(imageView.snp.height)
        }
        
        label.snp.makeConstraints {
            $0.leading.equalTo(imageView.snp.trailing).offset(3)
            $0.top.bottom.trailing.equalToSuperview().inset(2)
        }
    }
}

extension MesoBadgeView {
    func config(_ item: Int) {
        label.text = item == 0 ? "1000" : "5000"
    }
}

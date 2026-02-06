//
//  LegendaryItemFooterView.swift
//  GaCha
//
//  Created by 변예린 on 2/5/26.
//
import UIKit
import SnapKit

class GachaCollectionFooterView: UICollectionReusableView {
    let pageControl = UIPageControl()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        pageControl.currentPage = 1
        
        pageControl.currentPageIndicatorTintColor = .mushroomOrange
        pageControl.pageIndicatorTintColor = UIColor(red: 0.99, green: 0.96, blue: 0.92, alpha: 1.00)
        pageControl.isUserInteractionEnabled = false // pageIndicator 눌러서 indicator 위치 변경을 막음
        
        addSubview(pageControl)
        
        pageControl.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

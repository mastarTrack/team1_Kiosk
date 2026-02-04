//
//  GachaView.swift
//  GaCha
//
//  Created by 변예린 on 2/4/26.
//
import UIKit
import SnapKit

class GachaCollectionView: UICollectionView {
    
    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: frame, collectionViewLayout: layout)
        
        self.collectionViewLayout = makeCompositionalLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension GachaCollectionView {
    private func makeCompositionalLayout() -> UICollectionViewCompositionalLayout {
      // Item 정의: 컬렉션 뷰에 사용될 아이템의 레이아웃을 설정합니다.
        // 각 아이템의 크기 설정
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(0.4), // group 내 아이템 너비 == 그룹 너비 * 0.8
            heightDimension: .fractionalHeight(1) // group 내 아이템 높이 == 그룹 높이
        )
        
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        // 각 아이템 간의 간격 설정: 상, 하, 좌, 우 5포인트 여백 추가
        item.contentInsets = NSDirectionalEdgeInsets(top: 5, leading: 5, bottom: 5, trailing: 5)
        
        
      // Group 정의: 컬렉션 뷰에 사용될 그룹의 레이아웃을 설정합니다.
        // 그룹 사이즈 설정
        let groupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1), // 그룹 너비 == 컬렉션 뷰의 너비
            heightDimension: .fractionalWidth(1/3) // 그룹 높이 == 컬렉션 뷰의 너비 * 1/3
        )
        
        // 수평 그룹 생성 - item을 2번 반복하는 수평 그룹
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, repeatingSubitem: item, count: 2)
//        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        
        
      // Section 정의: 위에서 정의한 그룹을 포함할 섹션을 설정합니다.
        let section = NSCollectionLayoutSection(group: group)
        
        return UICollectionViewCompositionalLayout(section: section)
    }
}

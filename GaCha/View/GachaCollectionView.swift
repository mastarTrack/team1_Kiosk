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
        super.init(frame: frame, collectionViewLayout: UICollectionViewLayout())
        
        self.collectionViewLayout = makeCompositionalLayout()
        directionalLayoutMargins = NSDirectionalEdgeInsets(top: 0, leading: 20, bottom: 0, trailing: 20)
        
        isScrollEnabled = false
        
        register(LegendaryItemHeaderView.self, forSupplementaryViewOfKind: "HeaderKind", withReuseIdentifier: "Header")
        register(LegendaryItemFooterView.self, forSupplementaryViewOfKind: "FooterKind", withReuseIdentifier: "Footer")
        register(LegendaryItemCell.self, forCellWithReuseIdentifier: CellIdentifier.legendaryItemCell.rawValue)
        register(GachaButtonCell.self, forCellWithReuseIdentifier: CellIdentifier.gachaButtonCell.rawValue)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension GachaCollectionView {
    private func makeCompositionalLayout() -> UICollectionViewLayout {
        let configuration = UICollectionViewCompositionalLayoutConfiguration()
        configuration.contentInsetsReference = .layoutMargins // 컬렉션뷰 양옆에 공백을 위함
        configuration.interSectionSpacing = 10 // 섹션 간 공백 설정

        
        return UICollectionViewCompositionalLayout(sectionProvider: { section, environment in
            // Header 설정
            let headerItem = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: NSCollectionLayoutSize(
                  widthDimension: .fractionalWidth(1),
                  heightDimension: .absolute(26)
              ),
                  elementKind: "HeaderKind",
                  alignment: .top
              )
            
            // Paging Footer 설정
            let footerItem = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1),
                heightDimension: .absolute(26)
            ),
                elementKind: "FooterKind",
                alignment: .bottom
            )
            
            switch section  {
            case 0:
              // 기본 설정
                let spacing: CGFloat = 8
                
                // CollectionView 사이즈 - effectiveContentSize는 인셋 빼고 계산, 그냥 contentSize는 인셋 포함하여 계산
                let containerSize = environment.container.effectiveContentSize
                
              // Item 설정
                let itemSize = (containerSize.width - spacing) / 2 // 아이템 1개 가로 사이즈
                let item = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(
                    widthDimension: .absolute(itemSize),
                    heightDimension: .fractionalHeight(1)
                ))
                
              // Group 설정
                // 내부 그룹(아이템 2개 표시 횡렬 그룹) 설정
                let inLineGroup1 = NSCollectionLayoutGroup.horizontal(layoutSize: NSCollectionLayoutSize(
                    widthDimension: .fractionalWidth(1),
                    heightDimension: .absolute(itemSize * 0.7)
                    ),
                    repeatingSubitem: item,
                    count: 2
                )
                
                let inLineGroup2 = NSCollectionLayoutGroup.horizontal(layoutSize: NSCollectionLayoutSize(
                    widthDimension: .fractionalWidth(1),
                    heightDimension: .absolute(itemSize * 0.7)
                    ),
                    repeatingSubitem: item,
                    count: 2
                )
                
                // 그룹 내부 아이템 간 공백 설정
                inLineGroup1.interItemSpacing = .fixed(spacing)
                inLineGroup2.interItemSpacing = .fixed(spacing)
                
                // 전체 그룹 설정
                let entireGroup = NSCollectionLayoutGroup.vertical(layoutSize: NSCollectionLayoutSize(
                    widthDimension: .fractionalWidth(1),
                    heightDimension: .absolute(itemSize * 1.4 + spacing)
                ),
                    subitems: [inLineGroup1, inLineGroup2]
                )
                
                // 전체 그룹 내부 그룹 간 공백 설정
                entireGroup.interItemSpacing = .fixed(spacing)
                
              // Section 설정
                let section = NSCollectionLayoutSection(group: entireGroup)
                section.interGroupSpacing = spacing * 2 // 그룹 간 공백 설정
                section.orthogonalScrollingBehavior = .groupPaging // 그룹 간 스크롤 설정 - 페이징 형식
                
                section.boundarySupplementaryItems = [headerItem, footerItem]
                return section
                
            case 1:
                let spacing: CGFloat = 8
                // CollectionView 사이즈(inset 제외)
                let containerSize = environment.container.effectiveContentSize
                
                // item 설정
                let itemSize = (containerSize.width - spacing) / 2 // 섹션 0과 동일한 아이템 너비
                let item = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(
                    widthDimension: .absolute(itemSize),
                    heightDimension: .absolute(itemSize * 0.3)
                ))
                
                // group 설정
                let group = NSCollectionLayoutGroup.horizontal(layoutSize: NSCollectionLayoutSize(
                    widthDimension: .fractionalWidth(1),
                    heightDimension: .absolute(itemSize * 0.5)
                ), repeatingSubitem: item, count: 2)
                
                group.interItemSpacing = .fixed(spacing)
                
                // section 설정
                let section = NSCollectionLayoutSection(group: group)
                return section
            default: return nil
            }
        }, configuration: configuration)
    }
}


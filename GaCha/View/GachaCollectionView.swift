//
//  GachaView.swift
//  GaCha
//
//  Created by 변예린 on 2/4/26.
//
import UIKit
import SnapKit

class GachaCollectionView: UICollectionView {
    var pageControl: UIPageControl?
    
    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: frame, collectionViewLayout: UICollectionViewLayout())
        setAttribute()
        registerCell()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

//MARK: Set Attributes
extension GachaCollectionView {
    private func setAttribute() {
        self.collectionViewLayout = makeCompositionalLayout()
        directionalLayoutMargins = NSDirectionalEdgeInsets(top: 0, leading: 20, bottom: 0, trailing: 20)
        isScrollEnabled = false
    }
}

//MARK: Set Layout
extension GachaCollectionView {
    private func registerCell() {
        register(GachaCollectionHeaderView.self, forSupplementaryViewOfKind: "HeaderKind", withReuseIdentifier: "Header")
        register(GachaCollectionFooterView.self, forSupplementaryViewOfKind: "FooterKind", withReuseIdentifier: "Footer")
        register(MesoBadgeView.self, forSupplementaryViewOfKind: "BadgeKind", withReuseIdentifier: "Badge")
        
        register(LegendaryItemCell.self, forCellWithReuseIdentifier: CellIdentifier.legendaryItemCell.rawValue)
        register(GachaButtonCell.self, forCellWithReuseIdentifier: CellIdentifier.gachaButtonCell.rawValue)
        register(GachaResultCell.self, forCellWithReuseIdentifier: CellIdentifier.gachaResultCell.rawValue)
    }
    
    private func makeCompositionalLayout() -> UICollectionViewLayout {
        let configuration = UICollectionViewCompositionalLayoutConfiguration()
        configuration.contentInsetsReference = .layoutMargins // 컬렉션뷰 양옆에 공백을 위함
        configuration.interSectionSpacing = 10
        backgroundColor = .white
        
        return UICollectionViewCompositionalLayout(sectionProvider: { [unowned self] section, environment in
            // Header 설정
            let headerItem = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: NSCollectionLayoutSize(
                  widthDimension: .fractionalWidth(1),
                  heightDimension: .absolute(30)
              ),
                  elementKind: "HeaderKind",
                  alignment: .top
              )
            
            // Paging Footer 설정
            let footerItem = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1),
                heightDimension: .absolute(30)
            ),
                elementKind: "FooterKind",
                alignment: .bottom
            )
            
            
            
            // section 레이아웃 설정
            switch section  {
            case 0:
                let firstSection = self.setLegendaryListSection(environment)
                firstSection.boundarySupplementaryItems = [headerItem, footerItem] // header, footer 등록
                return firstSection
                
            case 1:
                return self.setButtonSection(environment)
                
            case 2:
                let thirdSection = self.setResultSection(environment)
                thirdSection.boundarySupplementaryItems = [headerItem]
                return thirdSection
                
            default: return nil
            }
        }, configuration: configuration)
    }
}

//MARK: Set Section Layout
extension GachaCollectionView {
    // 레전더리 아이템 목록 섹션 레이아웃
    private func setLegendaryListSection(_ environment: any NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection {
        // 기본 설정
          let spacing: CGFloat = 8
          
          // CollectionView 사이즈 - effectiveContentSize는 인셋 빼고 계산, 그냥 contentSize는 인셋 포함하여 계산
          let containerSize = environment.container.effectiveContentSize
          
        // Item 설정
          let itemSize = (containerSize.width) / 2 // 아이템 1개 가로 사이즈
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
          
          // 전체 그룹 설정
          let entireGroup = NSCollectionLayoutGroup.vertical(layoutSize: NSCollectionLayoutSize(
              widthDimension: .fractionalWidth(1),
              heightDimension: .absolute(itemSize * 1.4)
          ),
              subitems: [inLineGroup1, inLineGroup2]
          )
          
        // Section 설정
          let section = NSCollectionLayoutSection(group: entireGroup)
          section.interGroupSpacing = spacing * 3 // 그룹 간 공백 설정
          section.orthogonalScrollingBehavior = .groupPaging // 그룹 간 스크롤 설정 - 페이징 형식
          
          section.visibleItemsInvalidationHandler = { [weak self] _, contentOffset, environment in
              let currentPage = Int(max(0, contentOffset.x / containerSize.width)) // 현재 페이지 = 현재 스크롤 위치(x) / 컬렉션뷰 가로 길이
              self?.pageControl?.currentPage = currentPage // 현재 페이지 변경
          }
          
          return section
    }
    
    // 버튼 섹션 레이아웃
    private func setButtonSection(_ environment: any NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection {
        // CollectionView 사이즈(inset 제외)
        let containerSize = environment.container.effectiveContentSize

        // badge 설정
        let itemSize = (containerSize.width) / 4 // 섹션 0과 동일한 아이템 너비
        
        let badgeItemSize = NSCollectionLayoutSize(
            widthDimension: .absolute(itemSize * 0.6),
            heightDimension: .absolute(itemSize * 0.24)
        )
        let badgeItemAnchor = NSCollectionLayoutAnchor(edges: [.top, .trailing], fractionalOffset: CGPoint(x: 0.4, y: -0.5))
        let badgeItem = NSCollectionLayoutSupplementaryItem(
            layoutSize: badgeItemSize,
            elementKind: "BadgeKind",
            containerAnchor: badgeItemAnchor
        )
        
        // item 설정
        let item = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(
            widthDimension: .absolute(itemSize),
            heightDimension: .absolute(itemSize * 0.4)
        ),
        supplementaryItems: [badgeItem]
        )
        
        // group 설정
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1),
            heightDimension: .absolute(itemSize * 0.4)
        ), repeatingSubitem: item, count: 2)
        
        group.interItemSpacing = .fixed(itemSize)
        
        // section 설정
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: itemSize * 0.5, bottom: 0, trailing: itemSize * 0.5)
        
        return section
    }
    
    // 가챠 결과 테이블 섹션 레이아웃
    private func setResultSection(_ environment: any NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection {
        let configuration = UICollectionLayoutListConfiguration(appearance: .plain)
        let section = NSCollectionLayoutSection.list(using: configuration, layoutEnvironment: environment)

        return section
    }
}

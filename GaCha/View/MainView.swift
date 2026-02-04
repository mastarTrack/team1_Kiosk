//
//  MainView.swift
//  GaCha
//
//  Created by 변예린 on 2/3/26.
//

import UIKit
import SnapKit

class MainView: UIView {
    
    private let mesoStack = MesoStackView()
    
    let itemTableView = ItemTableView()
    let purchaseButton = ActionButton(title: "구매하기")
    let inventoryButton = ActionButton(title: "인벤토리")
    
    let categorySegment = CategorySegmentedControl(frame: .zero)
    lazy var gachaView = UICollectionView(frame: .zero, collectionViewLayout: self.makeCompositionalLayout())
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        
        let titleLabel = makeTitleLabel()
//        gachaView.collectionViewLayout = makeCompositionalLayout()
//        registerCollectionViewCell()

        addSubview(titleLabel)
        addSubview(inventoryButton)
        addSubview(mesoStack)
        addSubview(categorySegment)
        addSubview(itemTableView)
        addSubview(purchaseButton)
        addSubview(gachaView)
        
        
        titleLabel.snp.makeConstraints {
            $0.leading.trailing.equalTo(safeAreaLayoutGuide).inset(20)
            $0.top.equalTo(safeAreaLayoutGuide).offset(10)
        }
        
        inventoryButton.snp.makeConstraints {
            $0.leading.equalTo(safeAreaLayoutGuide).offset(20)
            $0.top.equalTo(titleLabel.snp.bottom).offset(10)
            $0.width.equalTo(100)
        }
        
        mesoStack.snp.makeConstraints {
            $0.leading.equalTo(inventoryButton.snp.trailing)
            $0.trailing.equalTo(safeAreaLayoutGuide).inset(20)
            $0.top.equalTo(titleLabel.snp.bottom).offset(10)
        }
        
        categorySegment.snp.makeConstraints {
            $0.leading.trailing.equalTo(safeAreaLayoutGuide).inset(20)
            $0.top.equalTo(inventoryButton.snp.bottom).offset(10)
        }
        
        itemTableView.snp.makeConstraints {
            $0.leading.trailing.equalTo(safeAreaLayoutGuide).inset(20)
            $0.top.equalTo(categorySegment.snp.bottom).offset(10)
            $0.bottom.equalTo(purchaseButton.snp.top).offset(-20)
        }
        
        purchaseButton.snp.makeConstraints {
            $0.bottom.equalTo(safeAreaLayoutGuide)
            $0.trailing.equalTo(safeAreaLayoutGuide).offset(-20)
            $0.width.equalTo(100)
        }
        
        gachaView.snp.makeConstraints {
            $0.leading.trailing.equalTo(safeAreaLayoutGuide).inset(20)
            $0.top.equalTo(categorySegment.snp.bottom).offset(10)
            $0.bottom.equalTo(purchaseButton.snp.top).offset(-20)
        }
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

//MARK: Configure Components
extension MainView {
    // 타이틀 레이블 생성
    private func makeTitleLabel() -> UILabel {
        let label = UILabel()
        
        label.text = "GaCha!"
        label.textColor = .black
        label.font = .boldSystemFont(ofSize: 24)
        label.textAlignment = .center
        
        return label
    }

}

//MARK: Register Cell
extension MainView {
    func registerCollectionViewCell() {
        gachaView.register(LegendaryListCollectionCell.self, forCellWithReuseIdentifier: "Legendary Item Cell")
    }
}

extension MainView {
    private func makeCompositionalLayout() -> UICollectionViewCompositionalLayout {
      // Item 정의: 컬렉션 뷰에 사용될 아이템의 레이아웃을 설정합니다.
        // 각 아이템의 크기 설정
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(0.4), // group 내 아이템 1개의 너비 == 그룹 너비 * 0.4
            heightDimension: .fractionalHeight(1) // group 내 아이템 1개의 높이 == 그룹 높이
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

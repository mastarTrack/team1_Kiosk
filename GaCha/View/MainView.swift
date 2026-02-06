//
//  MainView.swift
//  GaCha
//
//  Created by 변예린 on 2/3/26.
//

import UIKit
import SnapKit

protocol MainViewDelegate: AnyObject {
    func didTapPurchaseButton()
    func didTapInventoryButton()
}

class MainView: UIView {
    
    weak var delegate: MainViewDelegate?
    
    let mesoStack = MesoStackView()
    
    let itemTableView = ItemTableView()
    let purchaseButton = ActionButton(title: "구매하기")
    let inventoryButton = ActionButton(title: "인벤토리")
    
    let categorySegment = CategorySegmentedControl(frame: .zero)
    let gachaCollectionView = GachaCollectionView(frame: .zero)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        setActionButtons()
        itemTableView.allowsMultipleSelection = true
        itemTableView.showsVerticalScrollIndicator = false
        
        let titleLabel = makeTitleLabel()

        addSubview(titleLabel)
        addSubview(inventoryButton)
        addSubview(mesoStack)
        addSubview(categorySegment)
        addSubview(itemTableView)
        addSubview(purchaseButton)
        addSubview(gachaCollectionView)
        
        
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
            $0.bottom.equalTo(inventoryButton.snp.bottom)
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
        
        gachaCollectionView.snp.makeConstraints {
            $0.leading.trailing.bottom.equalTo(safeAreaLayoutGuide).inset(20)
            $0.top.equalTo(categorySegment.snp.bottom).offset(10)
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

extension MainView {
    private func setActionButtons() {
        purchaseButton.addTarget(self, action: #selector(purchaseButtonTapped), for: .touchUpInside)
        inventoryButton.addTarget(self, action: #selector(inventoryButtonTapped), for: .touchUpInside)
    }
    
    @objc
    private func purchaseButtonTapped() {
        delegate?.didTapPurchaseButton()
    }
    
    @objc
    private func inventoryButtonTapped() {
        delegate?.didTapInventoryButton()
    }
}

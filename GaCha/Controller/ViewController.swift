//
//  ViewController.swift
//  GaCha
//
//  Created by 손영빈 on 2/3/26.
//

import UIKit

class ViewController: UIViewController {
    
    private let mainView = MainView()
    private var selectedCategory: String = GachaCategory.gacha.rawValue // 선택된 카테고리 기본값
    
//    private let allItemList: [Item] = ItemData.allItems
    private var itemList: [Item] = []
    private var dataSource: [Section] = []
    private var gachaResult: [Item] = []
    private var inventoryItemList: [Int: PurchaseItem] = [:] // 구매한 아이템 담아둘 딕셔너리( item.id : Item)
    
    override func loadView() {
        self.view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setDelegate()
        setItemTableView()
        
        updateItemList()
        setGachaCollectionViewDataSource()
    }
}

//MARK: Set Delegate
extension ViewController {
    private func setDelegate() {
        mainView.categorySegment.delegate = self
        mainView.gachaCollectionView.delegate = self
        mainView.gachaCollectionView.dataSource = self
        mainView.delegate = self
    }
}

// CategorySegmentedControl delegate 정의
extension ViewController: CategorySegmentedControlDelegate {
    func categorySegmentedControlChanged(_ selected: String?) {
        selectedCategory = selected ?? GachaCategory.gacha.rawValue // 선택된 카테고리 변경
//        print(selectedCategory)
        
        updateItemList()
        mainView.itemTableView.reloadData()
        
    }
}

//MARK: Set Data
extension ViewController {
    private func updateItemList() {
        if selectedCategory == GachaCategory.gacha.rawValue {
            mainView.itemTableView.isHidden = true
            mainView.gachaCollectionView.isHidden = false
            mainView.purchaseButton.isHidden = true
            
            self.itemList = ItemData.allItems.filter {
                $0.grade == "레전더리"
            }
        } else {
            mainView.gachaCollectionView.isHidden = true
            mainView.itemTableView.isHidden = false
            mainView.purchaseButton.isHidden = false
            self.itemList = ItemData.allItems.filter {
                $0.category == selectedCategory && $0.grade == "일반" }
        }
    }
    
    private func setGachaCollectionViewDataSource() {
        dataSource = [
            .first(self.itemList),
            .second(["1회 뽑기", "5회 뽑기"]),
            .third([])
        ]
    }
}

extension ViewController {
    private func setItemTableView() {
        mainView.itemTableView.dataSource = self
        mainView.itemTableView.delegate = self
        mainView.itemTableView.register(ItemCell.self, forCellReuseIdentifier: "Cell")
    }
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! ItemCell
        
        let item = itemList[indexPath.row]
        cell.config(with: item)
        return cell
    }
}

extension ViewController: UITableViewDelegate {
    
}

// GachaView CollectionView datasource 정의
extension ViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        switch dataSource[section] {
        case .first(let items): return items.count // 0번째 섹션 - Legendary Item List 섹션
        case .second(let title): return title.count // 1번째 섹션 - Gacha Button 섹션
        case .third(let items): return items.count // 2번째 섹션 - Result Table 섹션
        }
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        // 섹션의 개수
        return dataSource.count
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        switch kind {
        case "HeaderKind":
            let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "Header", for: indexPath) as! LegendaryItemHeaderView
            
            if indexPath.section == 0 { // Legendary Item List 섹션
                headerView.configLegendaryItemSection()
            } else if indexPath.section == 2 { // Result Table 섹션
                headerView.configResultTableSection()
            }
            
            return headerView
            
        case "FooterKind":
            let footerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "Footer", for: indexPath) as! LegendaryItemFooterView
            
            mainView.gachaCollectionView.pageControl = footerView.pageControl // 컬렉션뷰에서 footerView의 페이지컨트롤 참조
            
            // 전체 페이지 수 설정
            footerView.pageControl.numberOfPages = switch dataSource[indexPath.section] {
            case .first(let items):
                items.count / 4
            default: 0
            }
            
            return footerView
            
        default: return UICollectionReusableView()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch indexPath.section {
        case 0:
            let cell = mainView.gachaCollectionView.dequeueReusableCell(withReuseIdentifier: CellIdentifier.legendaryItemCell.rawValue, for: indexPath) as! LegendaryItemCell
            switch dataSource[indexPath.section] {
            case .first(let items):
                cell.config(with: items[indexPath.item])
            default: break
            }
            return cell
            
        case 1:
            let cell = mainView.gachaCollectionView.dequeueReusableCell(withReuseIdentifier: CellIdentifier.gachaButtonCell.rawValue, for: indexPath) as! GachaButtonCell
            switch dataSource[indexPath.section] {
            case .second(let titles):
                cell.config(with: titles[indexPath.item])
            default: break
            }
            return cell
            
        case 2:
            let cell = mainView.gachaCollectionView.dequeueReusableCell(withReuseIdentifier: CellIdentifier.gachaResultCell.rawValue, for: indexPath) as! GachaResultCell
            switch dataSource[indexPath.section] {
            case .third(let items):
                cell.config(with: items[indexPath.item])
            default: break
            }
            return cell
            
        default:
            return UICollectionViewCell()
        }
    }
}

extension ViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.section == 1 && indexPath.item == 0 {
            guard let result = itemList.randomElement() else { return }
            print("1번 뽑기")
            if gachaResult.count == 5 { gachaResult.removeFirst() }
            gachaResult.append(result)
            print(gachaResult)
            
            dataSource[2] = .third(gachaResult.reversed())
            mainView.gachaCollectionView.reloadData()
        } else if indexPath.section == 1 && indexPath.item == 1 {
            print("5번 뽑기")
            var tempResult:[Item] = []
            for _ in 0..<5 {
                guard let result = itemList.randomElement() else { return }
                tempResult.append(result)
            }
            gachaResult = tempResult
            dataSource[2] = .third(gachaResult.reversed())
            mainView.gachaCollectionView.reloadData()
        } else {
            print("다른 셀 선택")
        }
    }
}
extension ViewController: MainViewDelegate {
    func didTapPurchaseButton() {
        guard let selectedPaths = mainView.itemTableView.indexPathsForSelectedRows else {
            print("선택된 아이템이 없습니다.")
            return
        }
        
        for indexPath in selectedPaths {
            let selectedItem = itemList[indexPath.row] // selectedPaths 배열에서 하나하나 뽑아온 데이터 selectedItem
            
            if var existingPurchase = inventoryItemList[selectedItem.id] { // inventoryItemList에 있다면
                existingPurchase.count += 1 // [1: [Item, count: 1]]
                inventoryItemList[selectedItem.id] = existingPurchase
            } else { // inventoryItemList에 없을 경우
                inventoryItemList[selectedItem.id] = PurchaseItem(item: selectedItem, count: 1)
            }
            //            print("\(selectedItem.name) 구매")
        }
        selectedPaths.forEach { mainView.itemTableView.deselectRow(at: $0, animated: true) } // 구매버튼 클릭 후 선택 풀기
        print("인벤토리 현황")
        inventoryItemList.values.forEach { print("\($0.item.name): \($0.count)개")}
        
    }
    
    func didTapInventoryButton() {
        print("인벤토리 버튼 선택")
        let inventoryViewController = InventoryViewController()
        
        self.present(inventoryViewController, animated: true)
    }
}

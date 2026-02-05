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
    private var inventoryItemList: [Int: PurchaseItem] = [:] // 구매한 아이템 담아둘 딕셔너리( item.id : Item)
    
    override func loadView() {
        self.view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setDelegate()
        setItemTableView()
        
        updateItemList()
    }
}

//MARK: Set Delegate
extension ViewController {
    private func setDelegate() {
        mainView.categorySegment.delegate = self
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

extension ViewController {
    private func updateItemList() {
        if selectedCategory == GachaCategory.gacha.rawValue {
            mainView.itemTableView.isHidden = true
            mainView.purchaseButton.isHidden = true
        } else {
            mainView.itemTableView.isHidden = false
            mainView.purchaseButton.isHidden = false
            self.itemList = ItemData.allItems.filter {
                $0.category == selectedCategory && $0.grade == "일반" }
        }
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

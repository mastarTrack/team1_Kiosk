//
//  InventoryViewController.swift
//  GaCha
//
//  Created by 손영빈 on 2/5/26.
//

import UIKit

class InventoryViewController: UIViewController {
    
    private let inventoryView = InventoryView()
    
    var inventoryItemList: [PurchaseItem] = [] // 구매한 아이템을 받아 놓을 배열
    
    override func loadView() {
        self.view = inventoryView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setInventoryTableView()
        setDelegate()
    }
}

extension InventoryViewController {
    private func setDelegate() {
        inventoryView.delegate = self
    }
}

extension InventoryViewController {
    private func setInventoryTableView() {
        inventoryView.inventoryTableView.dataSource = self
        inventoryView.inventoryTableView.delegate = self
        inventoryView.inventoryTableView.register(InventoryItemCell.self, forCellReuseIdentifier: "Cell")
    }
}

extension InventoryViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return inventoryItemList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! InventoryItemCell
        let purchaseItem = inventoryItemList[indexPath.row]
        cell.config(with: purchaseItem)
        return cell
    }
    
}
extension InventoryViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return InventoryHeaderView()
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
}

extension InventoryViewController: InventoryViewDelegate {
    func didTapSellAllButton() {
        let alert = UIAlertController(title: "전체 판매", message: "아이템을 전부 판매하시겠습니까?", preferredStyle: .alert)
        let cancel = UIAlertAction(title: "취소하기", style: .cancel)
        let confirm = UIAlertAction(title: "판매하기", style: .destructive) { [weak self] _ in
            self?.sellAllItem()
        }
        
        alert.addAction(cancel)
        alert.addAction(confirm)
        present(alert, animated: true)
    }
    
    func sellAllItem() {
        self.inventoryItemList.removeAll()
        self.inventoryView.inventoryTableView.reloadData()
    }
    
    
}

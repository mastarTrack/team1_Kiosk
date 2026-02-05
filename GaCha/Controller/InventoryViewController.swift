//
//  InventoryViewController.swift
//  GaCha
//
//  Created by 손영빈 on 2/5/26.
//

import UIKit

class InventoryViewController: UIViewController {
    
    private let inventoryView = InventoryView()
    
    override func loadView() {
        self.view = inventoryView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setInventoryTableView()
    }
}

extension InventoryViewController {
    private func setInventoryTableView() {
        inventoryView.inventoryTableView.dataSource = self
        inventoryView.inventoryTableView.register(InventoryItemCell.self, forCellReuseIdentifier: "Cell")
    }
}

extension InventoryViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! InventoryItemCell
        let item = Item(id: 0, name: "테스트아이템", category: "무기", grade: "레전더리", price: 100000, imageName: "weapon1")
        let itemPurchase = PurchaseItem(item: item, count: 10)
        
        cell.config(with: itemPurchase)
        return cell
    }
    
}
extension InventoryViewController: UITableViewDelegate {
    
}

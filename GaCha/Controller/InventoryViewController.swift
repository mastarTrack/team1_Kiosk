//
//  InventoryViewController.swift
//  GaCha
//
//  Created by 손영빈 on 2/5/26.
//

import UIKit
import IdentifiedCollections

class InventoryViewController: UIViewController {
    
    weak var delegate: InventoryViewControllerDelegate?
    private let inventoryView = InventoryView()
    
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
        return DataManager.shared.inventoryList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! InventoryItemCell
        let purchaseItem = DataManager.shared.inventoryList[indexPath.row]
        cell.config(with: purchaseItem)
        
        cell.delegate = self // InventoryItemCell의 Delegate 선언
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
        
        // 받게되는 전체 메소
        let totalMeso = DataManager.shared.inventoryList.reduce(0) { sum, purchaseItem in
            let price = Double(purchaseItem.item.price * purchaseItem.count)
            return sum + Int(price * 0.4)
        }
        DataManager.shared.addMeso(amount: totalMeso)
        
        DataManager.shared.inventoryList.removeAll()
        self.inventoryView.inventoryTableView.reloadData()
        
    }
}

extension InventoryViewController: InventoryItemCellDelegate {
    func didTapSellButton(with cell: InventoryItemCell) {
        guard let indexPath = inventoryView.inventoryTableView.indexPath(for: cell) else { return }
        let selectedItem = DataManager.shared.inventoryList[indexPath.row]
        
        let alert = UIAlertController(title: "판매하기", message: "\(selectedItem.item.name) 판매 개수를 입력해주세요.", preferredStyle: .alert)
        
        alert.addTextField { textField in
            textField.placeholder = "개수를 입력해주세요. (현재 :\(selectedItem.count)개)"
        }
        
        let cancel = UIAlertAction(title: "취소하기", style: .cancel)
        let confirm = UIAlertAction(title: "판매하기", style: .destructive) { [weak self] _ in
            let textField = alert.textFields?.first // UIAlertController의 텍스트 필드는 배열임
            
            //TODO: 입력이 없을 경우 예외처리 필요(showErrorAlert로 처리 완료)
            guard let text = textField?.text, !text.isEmpty, let sellCount = Int(text) else {
                self?.showErrorAlert(message: "판매 개수를 입력해주세요.")
                return
            }
            self?.sellItem(indexPath: indexPath, count: sellCount)
        }
        
        alert.addAction(cancel)
        alert.addAction(confirm)
        present(alert, animated: true)
    }
    
    func sellItem(indexPath: IndexPath, count: Int) {
        let itemIndex = indexPath.row
        let selectedItem = DataManager.shared.inventoryList[itemIndex]
        let currentItemCount = DataManager.shared.inventoryList[itemIndex].count
        
        if count <= 0 || currentItemCount < count { // 입력된 값이 0보다 작거나 현재 개수보다 많을 경우
            showErrorAlert(message: "판매 개수를 다시 확인해주세요.")
            return
        }
        if count == currentItemCount { // 개수가 같을 경우 아이템 리스트에서 제거, 테이블 뷰에서 제거
            DataManager.shared.inventoryList.remove(at: itemIndex)
            inventoryView.inventoryTableView.deleteRows(at: [indexPath], with: .automatic)
        } else { // 개수가 적을 경우( 리스트에서 개수 감소, 해당 row만 reload)
            DataManager.shared.inventoryList[itemIndex].count -= count
            inventoryView.inventoryTableView.reloadRows(at: [indexPath], with: .automatic)
        }
        let originalEranedMeso = Double(selectedItem.item.price * count)
        let earnedMeso = Int(originalEranedMeso * 0.4)
        DataManager.shared.addMeso(amount: earnedMeso)
    }
}

// 에러처리 Alert
extension InventoryViewController {
    private func showErrorAlert(message: String) {
        let alert = UIAlertController(title: "오류", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "확인", style: .default))
        present(alert, animated: true)
    }
}

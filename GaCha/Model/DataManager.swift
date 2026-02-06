//
//  DataManager.swift
//  GaCha
//
//  Created by 손영빈 on 2/6/26.
//

import Foundation
import IdentifiedCollections

class DataManager {
    
    static let shared = DataManager()
    
    var inventoryList: IdentifiedArrayOf<PurchaseItem> = []
    
    var didChangeMeso: (() -> Void)?
    
    func addItemToInventory(item: Item) {
        if var item = DataManager.shared.inventoryList[id: item.id] {
            item.count += 1
            DataManager.shared.inventoryList[id: item.id] = item
        } else {
            DataManager.shared.inventoryList.append(PurchaseItem(item: item, count: 1))
        }
    }
    
    var meso = Meso()
    func getCurrentMeso() -> Int {
        return meso.meso
    }
    
    func addMeso(amount: Int) {
        meso.meso += amount
        didChangeMeso?()
    }
    
    func subtractMeso(amount: Int) -> Bool{
        if meso.meso >= amount{
            meso.meso -= amount
            return true
        } else {
            return false
        }
    }
}

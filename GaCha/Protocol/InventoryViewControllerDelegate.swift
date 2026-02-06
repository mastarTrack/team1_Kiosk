//
//  InventoryViewControllerDelegate.swift
//  GaCha
//
//  Created by 손영빈 on 2/6/26.
//

protocol InventoryViewControllerDelegate: AnyObject {
    func didUpdateInventoryItemList(with updatedItemList: [PurchaseItem])
}

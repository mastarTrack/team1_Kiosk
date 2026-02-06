//
//  PurchaseItem.swift
//  GaCha
//
//  Created by 손영빈 on 2/4/26.
//

import Foundation

struct PurchaseItem: Identifiable {
    var id: Int{
        item.id
    }
    let item: Item
    var count: Int
    var totalPrice: Int {
        return item.price * count
    }
}

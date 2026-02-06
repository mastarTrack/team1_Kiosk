//
//  InventoryItemCellDelegate.swift
//  GaCha
//
//  Created by 손영빈 on 2/6/26.
//

protocol InventoryItemCellDelegate: AnyObject {
    func didTapSellButton(with cell: InventoryItemCell) // 어느 셀에 해당하는 지 알아야해서 셀 자체를 넘겨줌
}

//
//  Meso.swift
//  GaCha
//
//  Created by 손영빈 on 2/6/26.
//

import Foundation

class Meso {
    
    static let shared = Meso()
    private var meso: Int = 15000000
    
    func getCurrentMeso() -> Int {
        return meso
    }
    
    func addMeso(amount: Int) {
        meso += amount
    }
    
    func subtractMeso(amount: Int) -> Bool{
        if meso >= amount{
            meso -= amount
            return true
        } else {
            return false
        }
    }
}

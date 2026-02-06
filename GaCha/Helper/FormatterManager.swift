//
//  FormatterManager.swift
//  GaCha
//
//  Created by 손영빈 on 2/6/26.
//

import Foundation

class FormatterManager {
    func setMesoToString(meso: Int) -> String {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        
        let formattedMesoToString = numberFormatter.string(from: NSNumber(value: meso)) ?? "\(meso)"
        return "\(formattedMesoToString) 메소"
    }
}


//
//  CellIdentifier.swift
//  GaCha
//
//  Created by 변예린 on 2/5/26.
//

enum CellIdentifier: String {
    case legendaryItemCell = "LegendaryItemCell"
    case gachaButtonCell = "GachaButtonCell"
    case gachaResultCell = "GachaResultCell"
}

//enum SupplementaryKind {
//    enum ReuseIdentifier: String, CaseIterable {
//        case headerKind = "Header"
//    }
//    
//    case header(reuse: ReuseIdentifier)
//    
//    static func getKind() -> String {
//        switch self {
//        case header(reuse: .allCases): return "HeaderKind"
//    }
//}

enum Section {
    case first([Item])
    case second([String])
    case third([Item])
}

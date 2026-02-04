//
//  ViewController.swift
//  GaCha
//
//  Created by 손영빈 on 2/3/26.
//

import UIKit

class ViewController: UIViewController {
    
    private let mainView = MainView()
    private var selectedCategory: String = GachaCategory.gacha.rawValue // 선택된 카테고리 기본값
    
    override func loadView() {
        self.view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setDelegate()
        
    }
}

//MARK: Set Delegate
extension ViewController {
    private func setDelegate() {
        mainView.categorySegment.delegate = self
    }
}

// CategorySegmentedControl delegate 정의
extension ViewController: CategorySegmentedControlDelegate {
    func categorySegmentedControlChanged(_ selected: String?) {
        selectedCategory = selected ?? GachaCategory.gacha.rawValue // 선택된 카테고리 변경
        print(selectedCategory)
    }
}

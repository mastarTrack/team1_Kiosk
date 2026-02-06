//
//  MesoStack.swift
//  GaCha
//
//  Created by 변예린 on 2/3/26.
//
import UIKit
import SnapKit

class MesoStackView: UIStackView {
    // 현재 보유 메소 레이블
    private let currentMesoLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        // 타이틀 레이블 생성
        let title = makeCurrentMesoTitleLabel()
        
        // 타이틀 레이블 설정
        title.setContentCompressionResistancePriority(.defaultLow, for: .horizontal) // 크기 축소 우선순위 설정
        title.textAlignment = .right // 텍스트 오른쪽정렬
        
        setAttributes()
        
        updateMeso()
        
        addArrangedSubview(title)
        addArrangedSubview(currentMesoLabel)
        
        axis = .horizontal
        spacing = 8
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// Meso 모델로부터 현재의 메소를 불러옴.
extension MesoStackView {
    func updateMeso() {
        let currentMeso = Meso.shared.getCurrentMeso()
        self.setCurrentMesoLabel(meso: currentMeso)
    }
}

//MARK: Set Component Contents
extension MesoStackView {
    // 보유 메소 레이블 설정
    func setCurrentMesoLabel(meso: Int) {
        // 메소 #,### 형태 문자열로 변환
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        
        if let formattedMesoToString = numberFormatter.string(from: NSNumber(value: meso)) {
            currentMesoLabel.text = "\(formattedMesoToString) 메소"
        }
    }
}

//MARK: Configure Components
extension MesoStackView {
    // 보유 메소 타이틀 레이블 생성
    private func makeCurrentMesoTitleLabel() -> UILabel {
        let label = UILabel()
        
        label.text = "보유 메소"
        label.textColor = .black
        label.font = .boldSystemFont(ofSize: 16)
        
        return label
    }
    
    // 보유 메소 레이블 config 설정
    private func setAttributes() {
        currentMesoLabel.textColor = .black
        currentMesoLabel.font = .systemFont(ofSize: 16)
    }
}

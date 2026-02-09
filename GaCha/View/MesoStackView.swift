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
    private let mesoImageView = UIImageView(image: .meso)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        let space = UILabel()
        space.text = " "
        space.setContentCompressionResistancePriority(.required, for: .horizontal)
        
        let titleStack = setTitleStackView()
        
        setAttributes()
        updateMeso()
        
        addArrangedSubview(space)
        addArrangedSubview(titleStack)
        addArrangedSubview(currentMesoLabel)
        
        axis = .horizontal
        spacing = 8
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        // 메소 이미지 크기 조정 - 원본 크기의 70%
        mesoImageView.transform = CGAffineTransform(scaleX: 0.7, y: 0.7)
    }
}

// Meso 모델로부터 현재의 메소를 불러옴.
extension MesoStackView {
    func updateMeso() {
        let currentMeso = DataManager.shared.getCurrentMeso()
        
        let formatter = FormatterManager()
        currentMesoLabel.text = formatter.setMesoToString(meso: currentMeso)
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
        label.textAlignment = .right
        
        return label
    }
    
    // 보유 메소 레이블 config 설정
    private func setAttributes() {
        currentMesoLabel.textColor = .black
        currentMesoLabel.font = .systemFont(ofSize: 16)
        currentMesoLabel.setContentHuggingPriority(.required, for: .horizontal) // 우선순위 설정
    }
    
    // 보유 메소 이미지 생성
    private func setTitleStackView() -> UIStackView {
        // 타이틀 레이블 생성
        let title = makeCurrentMesoTitleLabel()
        let stackView = UIStackView(arrangedSubviews: [mesoImageView, title])
        
        stackView.axis = .horizontal
        stackView.spacing = 0
        
        title.setContentHuggingPriority(.required, for: .horizontal)
        
        mesoImageView.snp.makeConstraints {
            $0.width.equalTo(mesoImageView.snp.height)
        }
        return stackView
    }
}

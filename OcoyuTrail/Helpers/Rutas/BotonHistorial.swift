//
//  BotonHistorial.swift
//  OcoyuTrail
//
//  Created by Valente Cisneros Gomez on 06/11/24.
//

import UIKit

final class BotonHistorial: UIButton {
    var borderWidth: CGFloat = 8.0
    var borderColor: UIColor = .white
    
    var titletext: String?{
        didSet {
            setTitle(titletext, for: .normal)
        }
    }
    var titleTextColor: UIColor?{
        didSet{
            setTitleColor(titleTextColor, for: .normal)
        }
    }
    override init(frame: CGRect){
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setup()
    }
    
    private func setup(){
        clipsToBounds = true
        backgroundColor = UIColor(red: 0.149, green: 0.231, blue: 0.149, alpha: 1.0)
        layer.cornerRadius = frame.size.width / 2.0
        layer.borderColor = borderColor.cgColor
        layer.borderWidth = borderWidth
    }
}

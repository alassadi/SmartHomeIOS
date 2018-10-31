//
//  ElipseButton.swift
//  SmartHome-ios
//
//  Created by Charlie Tuna on 2018-10-22.
//  Copyright © 2018 Charlie Tuna. All rights reserved.
//

import UIKit

class RoundedButtonView: UIView {
    
    let button: UIButton = {
        let bttn = UIButton(type: .system)
        bttn.translatesAutoresizingMaskIntoConstraints = false
        bttn.setTitleColor(.white, for: .normal)
        return bttn
    }()
    
    init(title: String, backgroundColor: UIColor) {
        super.init(frame: .zero)
        self.translatesAutoresizingMaskIntoConstraints = false
        self.backgroundColor = backgroundColor
        self.button.setTitle(title, for: .normal)
        self.clipsToBounds = true
        self.heightAnchor.constraint(equalToConstant: 50).isActive = true
        self.layer.cornerRadius = 25
        
        self.setConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    fileprivate func setConstraints() {
        self.addSubview(button)
        NSLayoutConstraint.activate([
            self.button.topAnchor.constraint(equalTo: self.topAnchor),
            self.button.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            self.button.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            self.button.trailingAnchor.constraint(equalTo: self.trailingAnchor)
            ])
    }
}

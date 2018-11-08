//
//  HeaderStack+LoginVC.swift
//  SmartHome-ios
//
//  Created by Charlie Tuna on 2018-10-31.
//  Copyright © 2018 Charlie Tuna. All rights reserved.
//

import UIKit

class HeaderStack: UIStackView {

    init() {
        super.init(frame: .zero)
        self.translatesAutoresizingMaskIntoConstraints = false

        self.distribution = .equalSpacing
        self.spacing = 10
        self.axis = .vertical
        self.alignment = .center
        [labelReplaceWithLogo,
         labelLoginToContinue]
            .forEach({addArrangedSubview($0)})
    }

    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    //Components
    let labelReplaceWithLogo: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "SmartHome App"
        label.font = UIFont.systemFont(ofSize: 40)
        return label
    }()

    let labelLoginToContinue: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Please log in to continue" //Localize
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = UIColor(displayP3Red: 0, green: 0, blue: 0, alpha: 0.3)
        return label
    }()
}

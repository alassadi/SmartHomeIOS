//
//  AboutVC.swift
//  SmartHome-ios
//
//  Created by Charlie Tuna on 2019-01-27.
//  Copyright © 2019 Charlie Tuna. All rights reserved.
//

import UIKit
import VTAcknowledgementsViewController

class AboutVC: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = .white
        self.title = "About"

        self.setConstraints()
        self.addTargets()
    }

    private func setConstraints() {
        self.view.addSubview(self.acknowledgementsButton)

        self.acknowledgementsButton.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.top.equalTo(self.view.safeAreaLayoutGuide).offset(20)
        }
    }

    private func addTargets() {
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(onCancelPressed))
        self.acknowledgementsButton.addTarget(self, action: #selector(onAcknowledgementsPressed), for: .touchUpInside)
    }

    @objc private func onCancelPressed() {
        self.dismiss(animated: true)
    }

    @objc private func onAcknowledgementsPressed() {
        if let vc = VTAcknowledgementsViewController(fileNamed: "Pods-SmartHome-ios-acknowledgements") {
            vc.headerText = NSLocalizedString("Open source for the win!", comment: "")
            vc.footerText = "SmartHome the App"
            navigationController?.pushViewController(vc, animated: true)
        } else {
            print("Something is wrong!")
        }
    }

    let acknowledgementsButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Acknowledgements", for: .normal) //Localize
        button.setTitleColor(.redish, for: .normal)
        button.isEnabled = true
        return button
    }()
}

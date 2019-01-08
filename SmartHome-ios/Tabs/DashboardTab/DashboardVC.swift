//
//  DashboardVC.swift
//  SmartHome-ios
//
//  Created by Charlie Tuna on 2019-01-06.
//  Copyright © 2019 Charlie Tuna. All rights reserved.
//

import UIKit
import SnapKit
import FirebaseDatabase

class DashboardVC: UIViewController {

    var ref: DatabaseReference!

    override func viewDidLoad() {
        super.viewDidLoad()
        ref = Database.database().reference()

        setConstraints()
        setDatabaseConnections()
        initTargets()
    }

    private func setConstraints() {
        self.view.addSubview(self.outsideTempLabel)
        self.view.addSubview(self.insideTempLabel)
        self.view.addSubview(self.upstairsTempLabel)
        self.view.addSubview(self.alarmStatusLabel)
        self.view.addSubview(self.alarmIconLabel)

        self.outsideTempLabel.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top)
                .offset(20)
        }

        self.insideTempLabel.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.top.equalTo(self.outsideTempLabel.snp.bottom)
                .offset(30)
        }

        self.upstairsTempLabel.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.top.equalTo(self.insideTempLabel.snp.bottom)
                .offset(30)
        }

        [self.outsideTempLabel,
         self.insideTempLabel,
         self.upstairsTempLabel].forEach { (label) in
            let backgroundView = UIView()
            let titleLabel = UILabel()

            self.view.addSubview(backgroundView)
            self.view.addSubview(titleLabel)

            backgroundView.backgroundColor = .yellowish
            titleLabel.font = UIFont.italicSystemFont(ofSize: 12)
            self.view.sendSubviewToBack(backgroundView)
            backgroundView.snp.makeConstraints({ (make) in
                if label.tag == 1 {
                    make.leading.equalTo(label).offset(6)
                    make.bottom.equalTo(label).offset(-6)
                    make.height.width.equalTo(UIScreen.main.bounds.height/7)

                    titleLabel.snp.makeConstraints({ (make) in
                        make.leading.equalTo(label).offset(-3)
                        make.bottom.equalTo(label).offset(3)
                    })

                } else {
                    make.trailing.bottom.equalTo(label).offset(-6)
                    make.height.width.equalTo(UIScreen.main.bounds.height/7)

                    titleLabel.snp.makeConstraints({ (make) in
                        make.trailing.bottom.equalTo(label).offset(3)
                    })
                }
            })
            switch label.tag {
            case 0: titleLabel.text = "Outside"
            case 1: titleLabel.text = "Inside"
            case 2: titleLabel.text = "Upstairs"
            default: titleLabel.text = ""
            }
        }

        footerView.backgroundColor = .yellow

        self.alarmStatusLabel.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview().offset(16)
            make.bottom.equalTo(self.view.safeAreaLayoutGuide).offset(-20)
        }

        self.alarmIconLabel.snp.makeConstraints { (make) in
            make.centerY.equalTo(self.alarmStatusLabel)
            make.trailing.equalTo(self.alarmStatusLabel.snp.leading).offset(-8)
        }
    }

    private func initTargets() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.onAlarmLabelPressed))
        self.alarmStatusLabel.isUserInteractionEnabled = true
        self.alarmStatusLabel.addGestureRecognizer(tap)
    }

    @objc func onAlarmLabelPressed(sender: UITapGestureRecognizer? = nil) {
        self.alarmStatusLabel.text = "No ongoing alerts"
        self.alarmIconLabel.text = "thumbs-up"
    }

    private func setDatabaseConnections() {

        ref.child("Devices")
            .child("ORr9T5abPtJpeV6XdPw8") //Outside
            .child("value").observe(.value) { (snapshot) in
                if let value = snapshot.value as? Int {
                    self.outsideTempLabel.text = "\(value)°"
                }
        }

        ref.child("Devices")
            .child("Dga7pWKFbWR0NquaWc9V") //Inside
            .child("value").observe(.value) { (snapshot) in
                if let value = snapshot.value as? Int {
                    self.insideTempLabel.text = "\(value)°"
                }
        }

        ref.child("Devices")
            .child("Dga7pWKFbWR0NquaWc9V") //Upstairs
            .child("value").observe(.value) { (snapshot) in
                if let value = snapshot.value as? Int {
                    self.upstairsTempLabel.text = "\(value)°"
                }
        }

        ref.child("Devices")
            .child("ICYkFxoI0x2ng9NzGark") //Upstairs
            .child("value").observe(.value) { (snapshot) in
                if let value = snapshot.value as? String {
                    if value == "true" {
                        self.alarmStatusLabel.text = "BURGLAR ALERT!"
                        self.alarmIconLabel.text = "exclamation-square"
                    }
                }
                if let value = snapshot.value as? Bool {
                    if value {
                        self.alarmStatusLabel.text = "BURGLAR ALERT!"
                        self.alarmIconLabel.text = "exclamation-square"
                    }
                }
        }

        ref.child("Devices")
            .child("NjF7valDGmHOPZrF0S9O") //Upstairs
            .child("value").observe(.value) { (snapshot) in
                if let value = snapshot.value as? String {
                    if value == "true" {
                        self.alarmStatusLabel.text = "FIRE ALERT!"
                        self.alarmIconLabel.text = "exclamation-square"
                        self.alarmIconLabel.textColor = .red
                    }
                }
                if let value = snapshot.value as? Bool {
                    if value {
                        self.alarmStatusLabel.text = "FIRE ALERT!"
                        self.alarmIconLabel.text = "exclamation-square"
                        self.alarmIconLabel.textColor = .red
                    }
                }
        }

    }

    let outsideTempLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: UIScreen.main.bounds.height/7.1)
        label.textColor = .blackish
        label.textAlignment = .center
        label.text = "-°"
        label.tag = 0
        return label
    }()

    let insideTempLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: UIScreen.main.bounds.height/7.1)
        label.textColor = .blackish
        label.textAlignment = .center
        label.text = "-°"
        label.tag = 1
        return label
    }()

    let upstairsTempLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: UIScreen.main.bounds.height/7.1)
        label.textColor = .blackish
        label.textAlignment = .center
        label.text = "-°"
        label.tag = 2
        return label
    }()

    let footerView = UIView()

    let alarmIconLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: FontNames.FAPro_solid, size: 20)
        label.textColor = .blackish
        label.textAlignment = .center
        label.text = "thumbs-up"
        return label
    }()

    let alarmStatusLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.textColor = UIColor.blackish.withAlphaComponent(0.7)
        label.textAlignment = .center
        label.text = "No ongoing alarms"
        return label
    }()
}

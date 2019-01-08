//
//  DeviceCell.swift
//  SmartHome-ios
//
//  Created by Charlie Tuna on 2019-01-08.
//  Copyright © 2019 Charlie Tuna. All rights reserved.
//

import UIKit
import SnapKit

class DeviceCell: UITableViewCell {

    var device: _device? {
        didSet {
            if let device = self.device {
                self.initUI(device: device)
            }
        }
    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none
        setConstraints()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setConstraints() {
        self.onOffSwitch.addTarget(self,
                                   action: #selector(self.onSwitchToggled),
                                   for: .valueChanged)

        self.addSubview(self.iconContainer)
        self.addSubview(self.titleLabel)
        self.addSubview(self.onOffSwitch)
        self.addSubview(self.tempLabel)

        self.iconContainer.addSubview(iconLabel)

        self.iconContainer.snp.makeConstraints { (make) in
            make.height.width.equalTo(30)
            make.leading.equalToSuperview().offset(20)
            make.centerY.equalToSuperview()
        }

        self.iconLabel.snp.makeConstraints { (make) in
            make.center.equalToSuperview()
        }

        self.titleLabel.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview()
            make.leading.equalTo(self.iconContainer.snp.trailing).offset(16)
        }

        self.onOffSwitch.snp.makeConstraints { (make) in
            make.trailing.equalToSuperview().offset(-20)
            make.centerY.equalToSuperview()
        }

        self.tempLabel.snp.makeConstraints { (make) in
            make.center.equalTo(self.onOffSwitch.snp.center)
        }
    }

    private func initUI(device: _device) {
        if let value = device.value {
            if let name = device.name {
                self.titleLabel.text = name
                if let type = DeviceType(rawValue: name) {
                    switch type {
                    case .lampInside,.lampOutside:
                        if value == "true" {
                            self.iconLabel.text = "lightbulb-on"
                        } else if value == "false" {
                            self.iconLabel.text = "lightbulb-slash"
                        } else {
                            self.setForError()
                        }
                    case .temperatureInside, .temperatureOutside, .temperatureUpstairs:
                        if let value = Int(value) {
                            if value < -5 {
                                self.iconLabel.text = "thermometer-empty"
                            } else if value < 10 {
                                self.iconLabel.text = "thermometer-quarter"
                            } else if value < 20 {
                                self.iconLabel.text = "thermometer-half"
                            } else {
                                self.iconLabel.text = "thermometer-three-quarters"
                            }
                        } else {
                            self.setForError()
                        }
                    case .door:
                        if value == "true" {
                            self.iconLabel.text = "door-open"
                        } else if value == "false" {
                            self.iconLabel.text = "door-closed"
                        } else {
                            self.setForError()
                        }
                    case .stove:
                        if value == "true" {
                            self.iconLabel.text = "exclamation"
                        } else if value == "false" {
                            self.iconLabel.text = "power-off"
                        } else {
                            self.setForError()
                        }
                    case .window:
                        self.iconLabel.text = "city"
                    case .radiator:
                        if value == "true" {
                            self.iconLabel.text = "fire"
                        } else if value == "false" {
                            self.iconLabel.text = "temperature-frigid"
                        } else {
                            self.setForError()
                        }
                    case .waterLeak:
                        self.iconLabel.text = "tint"
                    case .burglarAlarm, .fireALarm:
                        self.iconLabel.text = "exclamation-triangle"
                    }

                    switch type {
                    case .lampOutside,.lampInside,.door,
                         .stove,.window,.radiator,
                         .waterLeak,.burglarAlarm,.fireALarm:
                        self.onOffSwitch.isHidden = false
                        self.tempLabel.isHidden = true
                        if let bool = Bool(value) {
                            self.onOffSwitch.isOn = bool
                        } else {
                            self.setForError()
                        }
                    case .temperatureUpstairs,.temperatureOutside,
                         .temperatureInside:
                        self.onOffSwitch.isHidden = true
                        self.tempLabel.isHidden = false
                        self.tempLabel.text = value
                    }
                } else {
                    print("Device name does not conform a device type.")
                    self.setForError()
                }
            } else {
                print("Device name was nil!")
                self.setForError()
            }
        } else {
            print("Device value was nil!")
            self.setForError()
        }
    }

    @objc func onSwitchToggled(sender: UISwitch) {
        
    }

    private func setForError() {
        self.iconLabel.text = "exclamation-square"
        self.iconLabel.alpha = 0.4
        if !self.onOffSwitch.isHidden {
            self.alpha = 0.4
        }
        if !self.tempLabel.isHidden {
            self.alpha = 0.4
        }
    }

    let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = .redish
        label.alpha = 0.8
        return label
    }()

    let iconContainer: UIView = {
        let view = UIView()
        view.backgroundColor = .yellow
        return view
    }()

    let iconLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.init(name: FontNames.FAPro_solid, size: 30)
        label.textColor = .lighterBlack
        return label
    }()

    let tempLabel: UILabel = {
        let label = UILabel()
        label.isHidden = true
        label.font = UIFont.systemFont(ofSize: 20)
        label.textColor = .redish
        return label
    }()

    let onOffSwitch: UISwitch = {
        let swtch = UISwitch()
        swtch.onTintColor = .redish
        swtch.isHidden = true
        return swtch
    }()

    let errorLabel: UILabel = {
        let label = UILabel()
        label.text = "Could not get device information!"
        label.font = UIFont.systemFont(ofSize: 11)
        label.textColor = UIColor.redish.withAlphaComponent(0.6)
        label.isHidden = true
        return label
    }()
}

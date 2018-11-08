//
//  Utility.swift
//  SmartHome-ios
//
//  Created by Charlie Tuna on 2018-10-31.
//  Copyright © 2018 Charlie Tuna. All rights reserved.
//

import Foundation

extension Dictionary {
    mutating func merge(with dictionary: Dictionary) {
        dictionary.forEach { updateValue($1, forKey: $0) }
    }

    func merged(with dictionary: Dictionary) -> Dictionary {
        var dict = self
        dict.merge(with: dictionary)
        return dict
    }
}

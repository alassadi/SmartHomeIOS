//
//  Regex.swift
//  SmartHome-ios
//
//  Created by Charlie Tuna on 2018-11-11.
//  Copyright © 2018 Charlie Tuna. All rights reserved.
//

import Foundation

class Regex {
    static func hasUpperCase(text: String) -> Bool{
        let format  = ".*[A-Z]+.*"
        let predicate = NSPredicate(format:"SELF MATCHES %@", format)
        let result = predicate.evaluate(with: text)
        return result
    }

    static func hasLowerCase(text: String) -> Bool{
        let format  = ".*[a-z]+.*"
        let predicate = NSPredicate(format:"SELF MATCHES %@", format)
        let result = predicate.evaluate(with: text)
        return result
    }

    static func validateName(text: String) -> Bool{
        let format  = "^[a-zåäöA-ZÅÄÖ]+(([',. -][a-zåäöA-ZÅÄÖ ])?[a-zåäöA-ZÅÄÖ]*)*$"
        let predicate = NSPredicate(format:"SELF MATCHES %@", format)
        let result = predicate.evaluate(with: text)
        return result
    }

    static func hasSpecialCharacter(text: String) -> Bool{
        let format  = ".*[.!&?^%$#@()/]+.*"
        let predicate = NSPredicate(format:"SELF MATCHES %@", format)
        let result = predicate.evaluate(with: text)
        return result
    }

    static func hasNumber(text: String) -> Bool{
        let format  = ".*[0-9]+.*"
        let predicate = NSPredicate(format:"SELF MATCHES %@", format)
        let result = predicate.evaluate(with: text)
        return result
    }

    static func validateEmail(text: String) -> Bool{
        let format  = "[A-ZÅÄÖ0-9a-zåäö._%+-]+@[A-ZÅÄÖa-zåäö0-9.-]+\\.[A-ZÅÄÖa-zåäö]{2,64}"
        let predicate = NSPredicate(format:"SELF MATCHES %@", format)
        let result = predicate.evaluate(with: text)
        return result
    }

    static func validatePostalCode(text: String) -> Bool{
        let format  = "^(s-|S-){0,1}[0-9]{3}\\s?[0-9]{2}$"
        let predicate = NSPredicate(format:"SELF MATCHES %@", format)
        let result = predicate.evaluate(with: text)
        return result
    }

    static func validateCity(text: String) -> Bool{
        let format  = "^[a-zåäöA-ZÅÄÖ]+(([',. -][a-zåäöA-ZÅÄÖ ])?[a-zåäöA-ZÅÄÖ]*)*$"
        let predicate = NSPredicate(format:"SELF MATCHES %@", format)
        let result = predicate.evaluate(with: text)
        return result
    }

    static func onlyNumbers(text: String) -> Bool{
        let format  = "^[0-9]*$"
        let predicate = NSPredicate(format:"SELF MATCHES %@", format)
        let result = predicate.evaluate(with: text)
        return result
    }

    //accepts +111111111 & 011111111 (minimum 8 digits & max 12 digits)
    static func onlyPhoneNumber(text: String) -> Bool{
        let format  = "^[0/+]+[0-9]{7,11}$"
        let predicate = NSPredicate(format:"SELF MATCHES %@", format)
        let result = predicate.evaluate(with: text)
        return result
    }
}

//
//  Validation.swift
//  LS
//
//  Created by macmini on 04/08/2023.
//

import Foundation

import UIKit

public class Validation: NSObject {
    public static let shared = Validation()
    
    public func checkValidationEmail(_ emailString: String) -> Bool {
        var returnValue = true
        let emailRegEx = "^((\"[\\w-\\s]+\")|([\\w-]+(?:\\.[\\w-]+)*)|(\"[\\w-\\s]+\")([\\w-]+(?:\\.[\\w-]+)*))(@((?:[\\w-]+\\.)*\\w[\\w-]{0,66})\\.([a-z]{2,6}(?:\\.[a-z]{2})?)$)|(@\\[?((25[0-5]\\.|2[0-4][0-9]\\.|1[0-9]{2}\\.|[0-9]{1,2}\\.))((25[0-5]|2[0-4][0-9]|1[0-9]{2}|[0-9]{1,2})\\.){2}(25[0-5]|2[0-4][0-9]|1[0-9]{2}|[0-9]{1,2})\\]?$)"
        do {
            let regex = try NSRegularExpression(pattern: emailRegEx)
            let nsString = emailString as NSString
            let resultsEmail = regex.matches(in: emailString, range: NSRange(location: 0, length: nsString.length))
            
            if resultsEmail.count == 0 {
                returnValue = false
            }
        } catch let error as NSError {
            print("invalid regex: \(error.localizedDescription)")
            returnValue = false
        }
        
        return  returnValue && (emailString.count > 7 && emailString.count < 50)
    }
    
    public func isValidIdentityNo(identityNo: String) -> Bool {
        let regEx = "^[a-zA-Z0-9]{8,12}$"
        let test = NSPredicate(format:"SELF MATCHES %@", regEx)
        return test.evaluate(with: identityNo)
    }
    
    public func isValidFullname(fullName: String) -> Bool {
        let regEx = "^[a-zA-Z0-9 ]{2,60}$"
        let test = NSPredicate(format:"SELF MATCHES %@", regEx)
        return test.evaluate(with: fullName.convertToEngLowercase())
    }
    
    public func isNumber(string: String) -> Bool {
        let regEx = "^[0-9]+$"
        let test = NSPredicate(format:"SELF MATCHES %@", regEx)
        return test.evaluate(with: string)
    }
    
    public func isDouble(_ string: String) -> Bool {
        let regEx = "^-?\\d+(\\.\\d+)?$"
        let test = NSPredicate(format: "SELF MATCHES %@", regEx)
        return test.evaluate(with: string)
    }
    
    public func isValidPhoneNumber(phone: String) -> Bool {
        let regEx = "^[0-9]{8,12}$"
        let test = NSPredicate(format:"SELF MATCHES %@", regEx)
        return test.evaluate(with: phone)
    }
    
    public func isValidPhoneNumber2(phone: String) -> Bool {
        let regEx = "^[0-9]{8,12}$"
        let test = NSPredicate(format:"SELF MATCHES %@", regEx)
        return test.evaluate(with: phone)
    }
    
    public func isValidSeriNumber(phone: String) -> Bool {
        let regEx = "^[0-9]$"
        let test = NSPredicate(format:"SELF MATCHES %@", regEx)
        return test.evaluate(with: phone)
    }
    
    public func isValidUsername(string: String) -> Bool {
        let regEx = "^[a-zA-Z0-9@._-]{6,45}$"
        let test = NSPredicate(format:"SELF MATCHES %@", regEx)
        return test.evaluate(with: string)
    }
    
    public func isValidIDNumber(string: String) -> Bool {
        let regEx = "^[a-zA-Z0-9]{8,12}$"
        let test = NSPredicate(format:"SELF MATCHES %@", regEx)
        return test.evaluate(with: string)
    }
    
    public func isValidPassword(string: String) -> Bool {
        let regEx = "^(?=.*\\d)(?=.*[a-z])(?=.*[A-Z])(?!.*\\s).{8,20}$"
        let test = NSPredicate(format:"SELF MATCHES %@", regEx)
        let isAlphabetCharacter = string.lowercased() == string.replaceFoldingTextWithDD()
        return test.evaluate(with: string) && isAlphabetCharacter
    }
    
    public func isValidPassword2(string: String) -> Bool {
        let regEx = "^(?=.*[!@#$&*])(?=.*[a-z])(?!.*\\s)(?=.*[0-9]).{8,20}$"
        let test = NSPredicate(format:"SELF MATCHES %@", regEx)
        let isAlphabetCharacter = string.lowercased() == string.replaceFoldingTextWithDD()
        return test.evaluate(with: string) && isAlphabetCharacter
    }
    
    public func isValidInputPassWord(string: String) -> Bool {
        let regEx = "^(?=.*\\d)(?=.*[a-z])(?=.*[A-Z])(?!.*\\s).{6,35}$"
        let test = NSPredicate(format:"SELF MATCHES %@", regEx)
        let isAlphabetCharacter = string.lowercased() == string.replaceFoldingTextWithDD()
        return test.evaluate(with: string) && isAlphabetCharacter
    }
    
    public func isValidAddress(_ string: String) -> Bool {
        let regEx = "^[a-zA-Z0-9 .,-/]{1,120}$"
        let test = NSPredicate(format:"SELF MATCHES %@", regEx)
        return test.evaluate(with: string.lowercased().convertToEngLowercase())
    }
    
    public func isValidEmail(_ email: String) -> Bool {
        var returnValue = true
        let emailRegEx = "^((\"[\\w-\\s]+\")|([\\w-]+(?:\\.[\\w-]+)*)|(\"[\\w-\\s]+\")([\\w-]+(?:\\.[\\w-]+)*))(@((?:[\\w-]+\\.)*\\w[\\w-]{0,66})\\.([a-z]{2,6}(?:\\.[a-z]{2})?)$)|(@\\[?((25[0-5]\\.|2[0-4][0-9]\\.|1[0-9]{2}\\.|[0-9]{1,2}\\.))((25[0-5]|2[0-4][0-9]|1[0-9]{2}|[0-9]{1,2})\\.){2}(25[0-5]|2[0-4][0-9]|1[0-9]{2}|[0-9]{1,2})\\]?$)"
        do {
            let regex = try NSRegularExpression(pattern: emailRegEx)
            let nsString = email as NSString
            let resultsEmail = regex.matches(in: email, range: NSRange(location: 0, length: nsString.length))
            
            if resultsEmail.isEmpty {
                return false
            }
        } catch let error as NSError {
            print("invalid regex: \(error.localizedDescription)")
            returnValue = false
        }
        
        return  returnValue && (email.count > 7 && email.count < 46)
    }
    
    public func hasNoNilProperties<T: Codable>(_ object: T) -> Bool {
        let mirror = Mirror(reflecting: object)
        for child in mirror.children {
            if let value = child.value as? OptionalProtocol, value.isNil {
                return false
            }
        }
        return true
    }
}

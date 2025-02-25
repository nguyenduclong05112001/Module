//
//  DoubleExtension.swift
//  LS
//
//  Created by macmini on 25/10/2023.
//

import Foundation

extension Double {
    func addComma(_ comma: String = ",") -> String {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        numberFormatter.minimumFractionDigits = 2
        numberFormatter.maximumFractionDigits = 2
        
        numberFormatter.groupingSeparator = ","
        numberFormatter.decimalSeparator = "."
        
        return numberFormatter.string(from: NSNumber(value: self)) ?? ""
    }
    
//    func removeZerosFromEnd(_ insertLast: Bool = false) -> String {
//        let formatter = NumberFormatter()
//        let number = NSNumber(value: self)
//        formatter.usesGroupingSeparator = true
//        formatter.numberStyle = .currency
//        formatter.locale = Locale(identifier: "en_US")
//        formatter.minimumFractionDigits = 2
//        formatter.maximumFractionDigits = 2
//        
//        return insertLast ? (String(formatter.string(from: number) ?? "0").removeCurrencyCharacter() + " USD") : ("USD " + String(formatter.string(from: number) ?? "0").removeCurrencyCharacter())
//    }
    
    
    
    func formatDoubleWithDecimals(_ numberOfDecimals: Int = 1, numberStyle: NumberFormatter.Style = .decimal) -> String {
        let formatter = NumberFormatter()
        let number = NSNumber(value: self)
        formatter.usesGroupingSeparator = true
        formatter.numberStyle = numberStyle
        formatter.locale = Locale(identifier: "en_US")
        formatter.groupingSeparator = "."
        formatter.decimalSeparator = ","
        formatter.minimumFractionDigits = numberOfDecimals
        formatter.maximumFractionDigits = numberOfDecimals
        
        return String(formatter.string(from: number) ?? "0")
    }
    
    func formatDoubleWithTwoDecimals() -> String {
        let formatter = NumberFormatter()
        let number = NSNumber(value: self)
        formatter.usesGroupingSeparator = true
        formatter.numberStyle = .currency
        formatter.locale = Locale(identifier: "en_US")
        formatter.groupingSeparator = "."
        formatter.decimalSeparator = ","
        formatter.minimumFractionDigits = 2
        formatter.maximumFractionDigits = 2
        
        return String(formatter.string(from: number) ?? "0").removeCurrencyCharacter()
    }
    
    func customRound(_ rule: FloatingPointRoundingRule, precision: RoundingPrecision = .ones) -> Double {
          switch precision {
          case .ones: return (self * Double(1)).rounded(rule) / 1
          case .tenths: return (self * Double(10)).rounded(rule) / 10
          case .hundredths: return (self * Double(100)).rounded(rule) / 100
          case .thousands: return (self * Double(1000)).rounded(rule) / 1000
          }
      }
}


public enum RoundingPrecision {
    case ones
    case tenths
    case hundredths
    case thousands
}

//
//  NumberExtensions.swift
//  LocstockO2O
//
//  Created by Intelin MacHD on 30/11/2023.
//

import UIKit

extension CGFloat {
    func addComma(_ comma: String = ",") -> String {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        numberFormatter.minimumFractionDigits = 2
        numberFormatter.maximumFractionDigits = 2
        
        numberFormatter.groupingSeparator = ","
        numberFormatter.decimalSeparator = "."
        
        return numberFormatter.string(from: NSNumber(value: self)) ?? ""
    }
    
    func rounded(toPlaces places:Int) -> Double {
        let divisor = pow(10.0, Double(places))
        return (self * divisor).rounded() / divisor
    }
}

extension Float {
    func addComma(_ comma: String = ",") -> String {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        numberFormatter.minimumFractionDigits = 2
        numberFormatter.maximumFractionDigits = 2
        
        numberFormatter.groupingSeparator = ","
        numberFormatter.decimalSeparator = "."
        
        return numberFormatter.string(from: NSNumber(value: self)) ?? ""
    }
    
    func rounded(toPlaces places:Int) -> Double {
        let divisor = pow(10.0, Double(places))
        return (Double(self) * divisor).rounded() / divisor
    }
}

extension Int {
    func addComma(_ comma: String = ",") -> String {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        numberFormatter.minimumFractionDigits = 2
        numberFormatter.maximumFractionDigits = 2
        
        numberFormatter.groupingSeparator = ","
        numberFormatter.decimalSeparator = "."
        
        return numberFormatter.string(from: NSNumber(value: self)) ?? ""
    }
    

}



extension Double {
   
    
    func rounded(toPlaces places:Int) -> Double {
        let divisor = pow(10.0, Double(places))
        return (self * divisor).rounded() / divisor
    }
    
    func toDistanceString() -> String {
        if self > 1000 {
            return "\((self / 1000).rounded(toPlaces: 1)) km"
        } else {
            return "\((self).rounded(toPlaces: 1)) m"
        }
    }
}

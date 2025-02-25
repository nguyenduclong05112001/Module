//
//  BoolExtension.swift
//  LS
//
//  Created by macmini on 28/08/2023.
//

import Foundation

extension Bool {
    var intValue: Int {
        return self ? 1 : 0
    }
    
    /// use for case false = -1
    var intValue2: Int {
        return self ? 1 : -1
    }
}

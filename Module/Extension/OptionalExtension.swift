//
//  OptionalExtension.swift
//  LS
//
//  Created by macmini on 16/5/24.
//

import Foundation

protocol OptionalProtocol {
    var isNil: Bool { get }
}

extension Optional: OptionalProtocol {
    var isNil: Bool {
        switch self {
        case .none:
            return true
        case .some:
            return false
        }
    }
}

extension Optional where Wrapped == String {
    var defaultValue: String {
//        return self ?? "LS_NA".localize()
        if let value = self {
            return value.isEmpty ? "N/A" : value
        }
        return "N/A"
    }
    
//    var defaultValueWithEmpty: String {
//        return (self == "" || self == nil) ? "LS_NA".localize() : self ?? "LS_NA".localize()
//    }
    
    var defaultValueWithEmpty: String {
        if let value = self {
            return value.isEmpty ? "N/A" : value
        }
        return "N/A"
    }
}

extension Optional where Wrapped == Double {
    var defaultValue: String {
        switch self {
        case .some(let value):
            return String(value)
        case .none:
            return "-"
        }
    }
}

extension Optional where Wrapped == Int64 {
    var defaultValue: String {
        switch self {
        case .some(let value):
            return String(value)
        case .none:
            return "-"
        }
    }
}

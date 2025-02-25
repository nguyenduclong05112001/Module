//
//  Dictionary.swift
//  LS
//
//  Created by macmini on 15/08/2023.
//

import Foundation

extension Dictionary {
    func getCode() -> String {
        guard let dict = self as? [String: Any], let code = dict[ResponseKey.code.rawValue] as? String else {
            return ""
        }
        return code
    }
}

//MARK: ResponseKey
enum ResponseKey: String {
    case data = "data"
    case code = "code"
    case link = "link"
}

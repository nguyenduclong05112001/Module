//
//  ErrorExtension.swift
//  LS
//
//  Created by macmini on 26/09/2023.
//

import Foundation

extension Error {
    var errorCode: String {
        return String((self as NSError).code)
    }
}

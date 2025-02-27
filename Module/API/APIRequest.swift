//
//  APIRequest.swift
//  LS
//
//  Created by macmini on 04/08/2023.
//

import Foundation

enum APIMethod: String {
    case get = "GET"
    case post = "POST"
    case delete = "DELETE"
    case update = "UPDATE"
    case put = "PUT"
}

struct EmptyData: Decodable {}

struct APICommonResponse<T: Decodable>: Decodable {
    let code: String?
    let messages: String?
    let data: T?
}

enum APIError: Error {
    case serverError(code: String, message: String?)
    case unexpected(code: Int, message: String?)
    case insiderError(error: Error)
    case aiError(error: String)
}

public class Header {
    static let shared = Header()
    
    public static func getSimpleHeader() -> [String: Any] {
        var header: [String : Any] = [:]
        header.updateValue("application/json", forKey: "Content-Type")
        header.updateValue("max-age=0, no-cache, no-store, must-revalidate", forKey: "Cache-control")
        header.updateValue("*/*", forKey: "Accept")
        return header
    }
    
}

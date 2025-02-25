//
//  Encodable.swift
//  LS
//
//  Created by macmini on 15/08/2023.
//

import Foundation
extension Encodable {
    func asDictionary() -> [String: Any]? {
        do {
            let data = try JSONEncoder().encode(self)
            let dictionary = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String: Any]
            
//            let decoder = JSONDecoder()
//            decoder.keyDecodingStrategy = .convertFromSnakeCase
//            let data = Data(JSON.utf8)
//            let output = try decoder.decode(ProductSearchResult.self, from: data)
//            
            return dictionary
        }
        catch {
            return nil
        }
    }
    
    func asDictionary2()  -> [String: Any]? {
        do {
            let jsonEncoder = JSONEncoder()
            if #available(iOS 13.0, *) {
                jsonEncoder.outputFormatting = .withoutEscapingSlashes
            } else {
                // Fallback on earlier versions
            }
            let data = try jsonEncoder.encode(self)
            let dictionary = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
            return dictionary
        }
        catch {
            return nil
        }
    }
    
    func isValid(withoutNilInt: Bool = false, withoutNilDouble: Bool = false, withoutEmptyString: Bool = false) -> Bool {
        for child in Mirror(reflecting: self).children {
            if let optional = child.value as? OptionalProtocol, optional.isNil {
                return false
            }
            
            if withoutNilDouble, let double = child.value as? Double, double == 0 {
                return false
            }
            
            if withoutNilInt, let int = child.value as? Int, int == 0 {
                return false
            }
            
            if withoutEmptyString, let string = child.value as? String, string.isEmpty {
                return false
            }
        }
        return true
    }
}

class CustomJSONEncoder: JSONEncoder {
    override func encode<T>(_ value: T) throws -> Data where T : Encodable {
        self.outputFormatting = .prettyPrinted
        self.nonConformingFloatEncodingStrategy = .convertToString(positiveInfinity: "Infinity", negativeInfinity: "-Infinity", nan: "NaN")
        self.keyEncodingStrategy = .convertToSnakeCase

        return try super.encode(value)
    }
}

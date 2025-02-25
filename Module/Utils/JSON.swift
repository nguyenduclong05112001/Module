//
//  JSON.swift
//  LS
//
//  Created by macmini on 04/08/2023.
//

import Foundation

public class JSON {
    public static let shared = JSON()
    
    public  func convertJsonToArrayString(data: String?) -> [String] {
        var result: [String] = []
        if let imagesString =  data, let dataShelf = imagesString.data(using: .utf8) {
            do {
                if let jsonArray = try JSONSerialization.jsonObject(with: dataShelf, options : .allowFragments) as? [String]
                {
                    result = jsonArray
                }
            } catch let error as NSError {
                print(error)
            }
        }

        return result
    }
    
    public  func parseDataToArrImage(data: String?) -> [String] {
        if let imagesString = data, let dataShelf = imagesString.data(using: .utf8) {
            do {
                if let jsonArray = try JSONSerialization.jsonObject(with: dataShelf, options : .allowFragments) as? [String]
                {
                    return jsonArray
                }
            } catch let error as NSError {
                print(error)
            }
        }
        
        return []
    }
    
    public  func parseDataToString(data: Any) -> String {
        let jsonData = try! JSONSerialization.data(withJSONObject: data, options: .prettyPrinted)
        guard let jsonString = NSString(data: jsonData, encoding: String.Encoding.utf8.rawValue) as String? else {
            return ""
        }
        return jsonString
    }
    
    public  func parseDataToStringV2(data: Any) -> String {
        let jsonData = try! JSONSerialization.data(withJSONObject: data, options: [])
        guard let jsonString = NSString(data: jsonData, encoding: String.Encoding.utf8.rawValue) as String? else {
            return ""
        }
        return jsonString
    }
    
    public  func parseJsonToStringArray(jsonString: String) -> [String] {
        let data = Data(jsonString.utf8)
        do {
            if let array = try JSONSerialization.jsonObject(with: data) as? [String] {
                return array
            }
            return []
        } catch {
            Logger.shared.Logs(event: .error, message: "Contert parseJsonToStringArray error")
        }
        return []
    }
    
    public  func filterJson(_ data: Any) -> String {
        let jsonData = try! JSONSerialization.data(withJSONObject: data, options: JSONSerialization.WritingOptions.prettyPrinted)
        let jsonString = NSString(data: jsonData, encoding: String.Encoding.utf8.rawValue)! as String
        return jsonString
    }
    
    public  func toDict(_ text: String) -> [String: Any] {
        if let data = text.data(using: .utf8) {
            do {
                if let dict = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
                    return dict
                } else {
                    //logger.logs(event: .error, message: "dict nil")
                }
            } catch {
                //logger.logs(event: .error, message: "toDict FAIL with Error: \(error.localizedDescription)")
            }
        }
        return [:]
    }
    
    public  func toArrayDict(_ text: String) -> [[String: Any]]? {
        if let data = text.data(using: .utf8) {
            do {
                return try JSONSerialization.jsonObject(with: data, options: []) as? [[String: Any]]
            } catch {
                //print(error.localizedDescription)
            }
        }
        return nil
    }
    
    public  func parseDataToDict(_ data: Data) -> [String: Any]? {
        do {
            return try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
        } catch {
            //logger.logs(event: .error, message: "parseDataToDict FAIL with Error: \(error.localizedDescription)")
        }
        return nil
    }
    
    public  func convertToDictionary(_ text: String) -> [String: Any]? {
        if let data = text.data(using: .utf8) {
            do {
                return try JSONSerialization.jsonObject(with: data, options: []) as? [String: String]
            } catch {
                //print(error.localizedDescription)
            }
        }
        return nil
    }
    
    public  func dictStringToString(_ dict:[String: String]) -> String {
        let json = try? JSONSerialization.data(withJSONObject: dict, options: [])
        let content = String(data: json!, encoding: String.Encoding(rawValue: String.Encoding.utf8.rawValue))! as String
        return content
    }
    
    public  func dictToString(_ dict:[String: Any]) -> String {
        let json = try? JSONSerialization.data(withJSONObject: dict, options: [])
        let content = String(data: json!, encoding: String.Encoding(rawValue: String.Encoding.utf8.rawValue))! as String
        return content
    }
    
    public  func arrayDictToString(_ arrayDict:[[String: Any]]) -> String {
        let stringDictionaries: [[String: Any]] = arrayDict.map { dictionary in
            var dict: [String: Any] = [:]
            for (key, value) in dictionary {
                dict[key] = value
            }
            return dict
        }
        
        var string = String()
        string.append("[")
        for i in stringDictionaries {
            string.append(JSON.shared.dictToString(i))
            string.append(",")
        }
        string = String(string.dropLast())
        string.append("]")
        return string
    }
    
    public  func arrayToJsonString(_ data: [String]) -> String? {
        do {
            let jsonData = try JSONEncoder().encode(data)
            return String(data: jsonData, encoding: .utf8)
        } catch {
            print("Error encoding JSON: \(error)")
        }
        return nil
    }
    
    //Alias Func
    public  func toDictArr2(_ json: String?) -> [[String:Any]?]? {
        if (json != nil) {
            if let data = json!.data(using: .utf8) {
                do {
                    return try JSONSerialization.jsonObject(with: data, options: []) as? [[String: Any]?]
                } catch {
                    //print(error.localizedDescription)
                }
            }
        } else {
        }
        return nil
    }
    
    public  func toDict2(_ json: String?) -> [String:Any]? {
        if (json != nil) {
            if let data = json!.data(using: .utf8) {
                do {
                    return try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
                } catch {
                    //print(error.localizedDescription)
                }
            }
        }
        return nil
    }
    
    public  func getCodeRespone(_ json: [String:Any]) -> String {
        if let jsonCode = json["code"] as? String {
            return jsonCode
        }
        return ""
    }
    
    public  func getDataRespone(_ json: [String:Any]) -> String {
        if let jsonCode = json["data"] as? String {
            return jsonCode
        }
        return ""
    }
}

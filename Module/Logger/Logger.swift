//
//  Logger.swift
//  LS
//
//  Created by macmini on 04/08/2023.
//

import UIKit

public enum LogEvents: String {
    case debug = "✅ [DEBUG]"
    case info  = "📝 [INFO]"
    case event = "📆 [EVENT]"
    case warn  = "‼️ [WARNING]"
    case error = "🐞 [ERROR]"
}

public class Logger: NSObject {
    public static let shared = Logger()
    
    private class func getDateTime() -> String {
        let formatter = DateFormatter()
        formatter.locale = Locale.current
        formatter.timeZone = TimeZone.current
        formatter.dateFormat = "HH:mm:ss"
        return formatter.string(from: Date())
    }
    

    
    public func Logs(event: LogEvents = LogEvents.debug, message: Any, fileName: String = #file, funcName: String = #function, line: Int = #line) {
        #if !NDEBUG
        print("\(Logger.getDateTime()) \(event.rawValue) [\(Logger.sourceFileName(filePath: fileName))] \(funcName) [\(line)] - \(message)")
        #endif
    }
    
    // For beautiful logging
    public func DumpLogs(event: LogEvents = LogEvents.debug, message: Any, fileName: String = #file, funcName: String = #function, line: Int = #line) {
        #if !NDEBUG
        print("\(Logger.getDateTime()) \(event.rawValue) [\(Logger.sourceFileName(filePath: fileName))] \(funcName) [\(line)] - ")
        dump(message)
        #endif
    }
    
    private class func sourceFileName(filePath: String) -> String {
        let components = filePath.components(separatedBy: "/")
        return components.isEmpty ? "" : components.last!
    }
}

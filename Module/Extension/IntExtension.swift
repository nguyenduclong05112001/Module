//
//  Int.swift
//  LS
//
//  Created by macmini on 11/08/2023.
//

import Foundation

extension Int {
    var data: Data {
        var int = self
        return Data(bytes: &int, count: MemoryLayout<Int>.size)
    }
    
    func transformIntDate(_ date: Date) -> Int {
        return Int(date.timeIntervalSince1970)
    }
    
    var boolValue: Bool {
        return self != 0
    }
    
    /// use for case false = -1
    var boolValue2: Bool {
        return self != -1
    }
    
    func decimalFormat() -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        return String(formatter.string(from: NSNumber(value: self)) ?? "0")
    }
    
    func formatFileSize() -> String {
        let KB = 1024
        let MB = KB * 1024
        let GB = MB * 1024

        if self >= GB {
            let sizeInGB = Double(self) / Double(GB)
            return String(format: "%.2f GB", sizeInGB)
        } else if self >= MB {
            let sizeInMB = Double(self) / Double(MB)
            return String(format: "%.2f MB", sizeInMB)
        } else if self >= KB {
            let sizeInKB = Double(self) / Double(KB)
            return String(format: "%.2f KB", sizeInKB)
        } else {
            return "\(self) bytes"
        }
    }
}

extension Int64 {
    var currentTimeMillisToInt64: Int64 {
        let nowDouble = NSDate().timeIntervalSince1970
        return Int64(nowDouble * 1000)
    }
    
    func formatFileSize() -> String {
        let KB = 1024
        let MB = KB * 1024
        let GB = MB * 1024

        if self >= GB {
            let sizeInGB = Double(self) / Double(GB)
            return String(format: "%.2f GB", sizeInGB)
        } else if self >= MB {
            let sizeInMB = Double(self) / Double(MB)
            return String(format: "%.2f MB", sizeInMB)
        } else if self >= KB {
            let sizeInKB = Double(self) / Double(KB)
            return String(format: "%.2f KB", sizeInKB)
        } else {
            return "\(self) bytes"
        }
    }
}

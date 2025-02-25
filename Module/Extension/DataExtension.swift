//
//  DataExtension.swift
//  LocstockO2O
//
//  Created by Intelin MacHD on 06/11/2023.
//

import Foundation

extension Data {
    
    mutating func append(_ string: String) {
        if let data = string.data(using: .utf8) {
            self.append(data)
        }
    }
    
    private static let mimeTypeSignatures: [UInt8 : String] = [
        0xFF : "image/jpeg",
        0x89 : "image/png",
        0x47 : "image/gif",
        0x49 : "image/tiff",
        0x4D : "image/tiff",
        0x25 : "application/pdf",
        0xD0 : "application/vnd",
        0x46 : "text/plain",
    ]
    
    var mimeType: String {
        var c: UInt8 = 0
        copyBytes(to: &c, count: 1)
        return Data.mimeTypeSignatures[c] ?? "application/octet-stream"
    }
    
    private static var fileExtensions: [UInt8 : String] = [
        0xFF : "jpeg",
        0x89 : "png",
        0x47 : "gif",
        0x49 : "tiff",
        0x4D : "tiff",
        0x25 : "pdf",
        0xD0 : "vnd",
        0x46 : "txt",
    ]
    
    var fileExtension: String {
        var c: UInt8 = 0
        copyBytes(to: &c, count: 1)
        return Data.fileExtensions[c] ?? ""
    }
    
    var html2AttributedString: NSAttributedString? {
        do {
            return try NSAttributedString(data: self, options: [.documentType: NSAttributedString.DocumentType.html, .characterEncoding: String.Encoding.utf8.rawValue], documentAttributes: nil)
        } catch {
            print("error:", error)
            return  nil
        }
    }
    var html2String: String { html2AttributedString?.string ?? "" }
}

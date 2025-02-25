//
//  StringExtension.swift
//  LS
//
//  Created by macmini on 04/08/2023.
//

import UIKit

extension String {
    
//    func localize() -> String {
//        let language = UserDefaults.standard.string(forKey: Constant.languageApp)
//        var stringLanguage = ""
//        switch language {
//        case EnumLanguage.en.rawValue.uppercased():
//            guard let path = Bundle.main.path(forResource: EnumLanguage.en.rawValue, ofType: "lproj"), let bundle = Bundle.init(path: path) else {
//                return self
//            }
//            stringLanguage = bundle.localizedString(forKey: self, value: nil, table: nil)
//            return stringLanguage
//        case EnumLanguage.kh.rawValue.uppercased():
//            guard let path = Bundle.main.path(forResource: EnumLanguage.kh.rawValue, ofType: "lproj"), let bundle = Bundle.init(path: path) else {
//                return self
//            }
//            stringLanguage = bundle.localizedString(forKey: self , value: nil, table: nil)
//            return stringLanguage
//        default:
//            guard let path = Bundle.main.path(forResource: EnumLanguage.en.rawValue, ofType: "lproj"), let bundle = Bundle.init(path: path) else {
//                return self
//            }
//            stringLanguage = bundle.localizedString(forKey: self , value: nil, table: nil)
//            UserDefaults.standard.set(EnumLanguage.en.rawValue.uppercased(), forKey: Constant.languageApp)
//            return stringLanguage
//        }
//    }
    
//    func nsLocalized() -> String {
//        return String.localizedStringWithFormat(NSLocalizedString(self, comment: ""))
//    }
//    
//    public func localized(with arguments: [CVarArg]) -> String {
//            return String(format: self.localize(), locale: nil, arguments: arguments)
//    }
    
    func isValidAlphabetAndNum() -> Bool {
         let regEx = "^[a-zA-Z0-9 ]*$"
         let test = NSPredicate(format:"SELF MATCHES %@", regEx)
         return test.evaluate(with: self)
    }
    
    func isValidEmail() -> Bool {
        let regEx = #"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$"#
        let emailPredicate = NSPredicate(format: "SELF MATCHES %@", regEx)
        return emailPredicate.evaluate(with: self)
    }
    
    func isValidName() -> Bool {
         let regEx = "^[a-zA-Z0-9 ]{1,25}$"
         let test = NSPredicate(format:"SELF MATCHES %@", regEx)
         return test.evaluate(with: self)
    }
    
    func isValidNumb() -> Bool {
         let regEx = "^[0-9]*$"
         let test = NSPredicate(format:"SELF MATCHES %@", regEx)
         return test.evaluate(with: self)
    }
    
    func isStringNumber(locale: String = "en_US") -> Bool {
        let formatter = NumberFormatter()
        formatter.locale = Locale(identifier: locale)
        return formatter.number(from: self) != nil
    }
    
    func isValidInputUserNameForLogin() -> Bool {
         let regEx = "^[a-zA-Z0-9@;:,._+-]{6,50}$"
         let test = NSPredicate(format:"SELF MATCHES %@", regEx)
         return test.evaluate(with: self)
    }
    
    func isValidInputPassWord() -> Bool {
         return (self.count < 6 || self.count > 20) ? false : true
    }
    
    func isValidatePhoneNumber() -> Bool {
        guard self.utf16.count > 9 else {
            return false
        }
        return true
    }
    
    func condenseWhitespace() -> String {
         let components = self.components(separatedBy: .whitespacesAndNewlines)
         return components.filter { !$0.isEmpty }.joined(separator: " ")
    }

    func toBase64() -> String {
        return Data(self.utf8).base64EncodedString()
    }

    func replaceFoldingTextWithDD() -> String {
        var newText = self.folding(options: .diacriticInsensitive, locale: .current).lowercased()
        if self.contains("đ") {
            newText = newText.replace(string: "đ", replacement: "d")
        }
        return newText
    }
    
    func capitalizingFirstLetter() -> String {
        let first = String(prefix(1)).capitalized
        let other = String(dropFirst())
        return first + other
    }
    
    //replace #string by #replacement
    func replace(string: String, replacement: String) -> String {
        return self.replacingOccurrences(of: string, with: replacement, options: .literal, range: nil)
    }
    
    //remove Dot
    func removeDot() -> String! {
        return self.replace(string: ".", replacement: "")
    }
    
    //remove space
    func removeSpace() -> String {
        return self.replace(string: " ", replacement: "")
    }
    
    //remove space and new lines
    func removeSpaceAndNewLines() -> String {
        return self.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
    }
    
    //remove comma
    func removeComma() -> String! {
        return replace(string: ",", replacement: "")
    }
    
    //remove leading zero
    func removeLeadingZero() -> String {
        if self.hasPrefix("0") {
            return String(self.dropFirst())
        }
        return self
    }
    
    func convertToEngLowercase() -> String {
        var str = self.lowercased()
        let aVariant = ["à", "á", "ạ", "ả", "ã", "â", "ầ", "ấ", "ậ", "ẩ", "ẫ", "ă", "ằ", "ắ", "ặ", "ẳ", "ẵ"]
        for item in aVariant {
            str = str.replace(string: item, replacement: "a")
        }
        let eVariant = ["e", "é", "è", "ẻ", "ẽ", "ẹ", "ế", "ề", "ể", "ễ", "ệ", "ê"]
        for item in eVariant {
            str = str.replace(string: item, replacement: "e")
        }
        let iVariant = ["í", "ì", "ỉ", "ĩ", "ị"]
        for item in iVariant {
            str = str.replace(string: item, replacement: "i")
        }
        let oVariant = ["ó", "ò", "ỏ", "õ", "ọ", "ô", "ố", "ồ", "ổ", "ỗ", "ộ", "ơ", "ớ", "ờ", "ở", "ỡ", "ợ"]
        for item in oVariant {
            str = str.replace(string: item, replacement: "o")
        }
        let uVariant = ["u", "ú", "ù", "ủ", "ụ", "ũ", "ư", "ứ", "ừ", "ử", "ữ", "ự"]
        for item in uVariant {
            str = str.replace(string: item, replacement: "u")
        }
        let yVariant = ["ý", "ỳ", "ỷ", "ỹ", "ỵ"]
        for item in yVariant {
            str = str.replace(string: item, replacement: "y")
        }
        let dVariant = ["đ"]
        for item in dVariant {
            str = str.replace(string: item, replacement: "d")
        }
        
        return str
    }
    
    func checkIfVietnameseSymbol() -> Bool {
        let str = self.lowercased()
        let aVariant = ["à", "á", "ạ", "ả", "ã", "â", "ầ", "ấ", "ậ", "ẩ", "ẫ", "ă", "ằ", "ắ", "ặ", "ẳ", "ẵ"]
        for item in aVariant {
            if str.contains(item) { return true }
        }
        let eVariant = ["é", "è", "ẻ", "ẽ", "ẹ", "ế", "ề", "ể", "ễ", "ệ", "ê"]
        for item in eVariant {
            if str.contains(item) { return true }
        }
        let iVariant = ["í", "ì", "ỉ", "ĩ", "ị"]
        for item in iVariant {
            if str.contains(item) { return true }
        }
        let oVariant = ["ó", "ò", "ỏ", "õ", "ọ", "ô", "ố", "ồ", "ổ", "ỗ", "ộ", "ơ", "ớ", "ờ", "ở", "ỡ", "ợ"]
        for item in oVariant {
            if str.contains(item) { return true }
        }
        let uVariant = ["ú", "ù", "ủ", "ụ", "ũ", "ư", "ứ", "ừ", "ử", "ữ", "ự"]
        for item in uVariant {
            if str.contains(item) { return true }
        }
        let yVariant = ["ý", "ỳ", "ỷ", "ỹ", "ỵ"]
        for item in yVariant {
            if str.contains(item) { return true }
        }
        let dVariant = ["đ"]
        for item in dVariant {
            if str.contains(item) { return true }
        }
        
        return false
    }
    
    public func timestampToFormatedDate(format: String) -> String {
        let timestamp: Double = (self as NSString).doubleValue
        let eventDate = Date(timeIntervalSince1970: timestamp)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        return dateFormatter.string(from: eventDate)
    }
    
    func strikeThrough() -> NSAttributedString {
        let attributeString = NSMutableAttributedString(string: self)
        attributeString.addAttribute(NSAttributedString.Key.strikethroughStyle, value: NSUnderlineStyle.single.rawValue, range: NSMakeRange(0, attributeString.length))
        return attributeString
    }
    
    func heightWithConstrainedWidth(width: CGFloat, font: UIFont) -> CGFloat {
        let constraintRect = CGSize(width: width, height: .greatestFiniteMagnitude)
        let boundingBox = self.boundingRect(with: constraintRect, options: [.usesLineFragmentOrigin, .usesFontLeading], attributes: [NSAttributedString.Key.font: font], context: nil)
        return boundingBox.height
    }
    
    func widthWithConstrainedHeight(height: CGFloat, font: UIFont) -> CGFloat {
        let constraintRect = CGSize(width: .greatestFiniteMagnitude, height: height)
        let boundingBox = self.boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: font], context: nil)
        return ceil(boundingBox.width)
    }
    
    func heightNeededForLabel(_ label: UILabel) -> CGFloat {
        let width = label.frame.size.width
        guard let font = label.font else { return 0 }
        let constraintRect = CGSize(width: width, height: .greatestFiniteMagnitude)
        let boundingBox = self.boundingRect(with: constraintRect, options: [.usesLineFragmentOrigin, .usesFontLeading], attributes: [NSAttributedString.Key.font: font], context: nil)
        return boundingBox.height
    }
    
    subscript (i: Int) -> Character {
        return self[index(startIndex, offsetBy: i)]
    }
    
    subscript (bounds: CountableRange<Int>) -> Substring {
        let start = index(startIndex, offsetBy: bounds.lowerBound)
        let end = index(startIndex, offsetBy: bounds.upperBound)
        if end < start { return "" }
        return self[start..<end]
    }
    
    subscript (bounds: CountableClosedRange<Int>) -> Substring {
        let start = index(startIndex, offsetBy: bounds.lowerBound)
        let end = index(startIndex, offsetBy: bounds.upperBound)
        if end < start { return "" }
        return self[start...end]
    }
    
    subscript (bounds: CountablePartialRangeFrom<Int>) -> Substring {
        let start = index(startIndex, offsetBy: bounds.lowerBound)
        let end = index(endIndex, offsetBy: -1)
        if end < start { return "" }
        return self[start...end]
    }
    
    subscript (bounds: PartialRangeThrough<Int>) -> Substring {
        let end = index(startIndex, offsetBy: bounds.upperBound)
        if end < startIndex { return "" }
        return self[startIndex...end]
    }
    
    subscript (bounds: PartialRangeUpTo<Int>) -> Substring {
        let end = index(startIndex, offsetBy: bounds.upperBound)
        if end < startIndex { return "" }
        return self[startIndex..<end]
    }
    
    var htmlToAttributedString: NSAttributedString? {
        guard let data = data(using: .utf8) else { return nil }
        do {
            return try NSAttributedString(data: data, options: [.documentType: NSAttributedString.DocumentType.html, .characterEncoding:String.Encoding.utf8.rawValue], documentAttributes: nil)
        } catch {
            return nil
        }
    }
    
    public func convertHtmlToAttributedStringWithCSS(font: UIFont?) -> NSAttributedString? {
            guard let font = font else {
                return htmlToAttributedString
            }
            let modifiedString = "<style>body{font-family: '\(font.fontName)'; font-size:\(font.pointSize)px; }</style>\(self)";
            guard let data = modifiedString.data(using: .utf8) else {
                return nil
            }
            do {
                return try NSAttributedString(data: data, options: [.documentType: NSAttributedString.DocumentType.html, .characterEncoding: String.Encoding.utf8.rawValue], documentAttributes: nil)
            }
            catch {
                print(error)
                return nil
            }
        }
    
    var htmlToString: String {
        return htmlToAttributedString?.string ?? ""
    }
    
    func widthOfString(usingFont font: UIFont) -> CGFloat {
        let fontAttributes = [NSAttributedString.Key.font: font]
        let size = self.size(withAttributes: fontAttributes)
        return size.width
    }
    
    func heightOfString(usingFont font: UIFont) -> CGFloat {
        let fontAttributes = [NSAttributedString.Key.font: font]
        let size = self.size(withAttributes: fontAttributes)
        return size.height
    }
    
    func sizeOfString(usingFont font: UIFont) -> CGSize {
        let fontAttributes = [NSAttributedString.Key.font: font]
        return self.size(withAttributes: fontAttributes)
    }
    
    var currentTimeMillisToString: String {
        let nowDouble = NSDate().timeIntervalSince1970
        return String(Int64(nowDouble * 1000))
    }
    
    func toDoubleWithCustomDecimal(_ numberOfDecimals: Int = 1, numberStyle: NumberFormatter.Style = .decimal) -> String {
        var textCopy = self
        guard !textCopy.isEmpty else {
            return "0.0"
        }

        textCopy = self.replacingOccurrences(of: ",", with: ".")
        let components = textCopy.components(separatedBy: ".")
        if components.count > 2 {
            textCopy = components.dropLast().joined(separator: "") + "." + components.last!
        }
        if let dotIndex = textCopy.firstIndex(of: ".") {
            let integerPart = String(textCopy[..<dotIndex])
            if let decimalPart = textCopy.components(separatedBy: ".").last {
                
                if decimalPart.count > 1 {
                    textCopy = integerPart + "." + decimalPart.prefix(1)
                }
            }
        }
        
        guard let doubleValue = Double(textCopy) else {
            return "0.0"
        }
        
        return doubleValue.formatDoubleWithDecimals(numberOfDecimals, numberStyle: numberStyle)
    }
}

extension String {
    func replaceQuantity(textFieldString: String?, newCharacter: String) -> String {
        if let currentText = textFieldString {
            if currentText.count == 1 {
                if currentText == "0", newCharacter == "0" {
                    return "0"
                } else if currentText == "0", newCharacter != "0" {
                    return newCharacter
                }
            }
        }
        if self.first == "0" {
            return String(self.dropFirst())
        }
        return self
    }
    
    static let numberFormatter = NumberFormatter()
    
    var doubleValue: Double {
        String.numberFormatter.decimalSeparator = "."
        if let result =  String.numberFormatter.number(from: self) {
            return result.doubleValue
        } else {
            String.numberFormatter.decimalSeparator = ","
            if let result = String.numberFormatter.number(from: self) {
                return result.doubleValue
            }
        }
        return 0
    }
    
    func removeCurrencyCharacter() -> String {
        return self.replacingOccurrences(of: "$", with: "").trimmingCharacters(in: .whitespaces)
    }
    
    func changeCommaCurrencyCharacter() -> String {
        return self.replacingOccurrences(of: ",", with: ".").trimmingCharacters(in: .whitespaces)
    }
    
 
    
    func isValidFormatPrice() -> Bool {
        let pattern = #"^\d{1,3}(?:\.\d{3})*(?:,\d{2})?$"#

        do {
            let regex = try NSRegularExpression(pattern: pattern, options: [])
            let range = NSRange(location: 0, length: self.utf16.count)

            return regex.firstMatch(in: self, options: [], range: range) != nil
        } catch {
            print("Error creating regular expression: \(error)")
            return false
        }
    }
    
    func numberOfPeriods() -> Int {
        let commaCount = self.filter { $0 == "." }.count
        return commaCount
    }
    
//    func convertToCustomPrice(_ withouDecimal: Bool = false) -> String? {
//        if let pattern = ServiceManager.standard.currencyService.currentCurrency?.pattern, let decimalStep = ServiceManager.standard.currencyService.currentCurrency?.decimalPlaces {
//            let formatter = NumberFormatter()
//            formatter.locale = Locale(identifier: "en_US")  // Set the locale to use dot as the decimal separator
//            if let number = formatter.number(from: self.convertDoubleString()) {
//                if let jsonData = pattern.data(using: .utf8), let patternObject = try?  JSONDecoder().decode(CurrencyPattern.self, from: jsonData) {
//                    formatter.numberStyle = .decimal
//                    formatter.minimumFractionDigits = !withouDecimal ? decimalStep : 0
//                    formatter.maximumFractionDigits = !withouDecimal ? decimalStep : 0
//                    
//                    formatter.decimalSeparator = patternObject.decimalSeparator
//                    formatter.groupingSeparator = patternObject.thousandSeparator
//                    
//                    let formatString = formatter.string(from: number) ?? "-"
//                    return formatString
//                }
//                return nil
//            }
//            return nil
//
////            // Convert the input string to a number
////            if let number = formatter.number(from: self.convertDoubleString()) {
////                formatter.numberStyle = .decimal
////                formatter.minimumFractionDigits = decimalStep
////                formatter.maximumFractionDigits = decimalStep
////                formatter.positiveFormat = pattern
////                // Convert the number to a string with custom format
////                return formatter.string(from: number)
////            } else {
////                return nil
////            }
//        }
//        else {
//            let formatter = NumberFormatter()
//            formatter.locale = Locale(identifier: "en_US")
//            if let number = formatter.number(from: self.convertDoubleString()) {
//                formatter.numberStyle = .decimal
//                formatter.minimumFractionDigits = !withouDecimal ? 2 : 0
//                formatter.maximumFractionDigits = !withouDecimal ? 2 : 0
//                
//                formatter.decimalSeparator = "."
//                formatter.groupingSeparator = ","
//                
//                let formatString = formatter.string(from: number) ?? "-"
//                return formatString
//            }
//            return nil
//        }
//    }
    
    func convertPriceToDoubleFormat() -> String {
        return self.replacingOccurrences(of: ".", with: "").trimmingCharacters(in: .whitespaces).replacingOccurrences(of: ",", with: ".").trimmingCharacters(in: .whitespaces)
    }
    
    func convertPriceToDoubleFormat2() -> String {
        return self.replacingOccurrences(of: ",", with: "").trimmingCharacters(in: .whitespaces).replacingOccurrences(of: ".", with: ",").trimmingCharacters(in: .whitespaces)
    }
    
    func maskString() -> String {
        guard self.count > 6 else { return self }
        
        let startIndex = self.index(self.startIndex, offsetBy: 3)
        let endIndex = self.index(self.endIndex, offsetBy: -3)
        let prefix = self.prefix(3)
        let suffix = self.suffix(3)
        let middle = String(repeating: "*", count: self.count - 6)
        
        return "\(prefix)\(middle)\(suffix)"
    }
    
    func truncateStringIfNeeded(maxLength: Int) -> String {
        if self.count > maxLength {
            let truncatedString = "..." + self.suffix(maxLength)
            return String(truncatedString)
        }
        return self
    }
    
//    var defaultValue: String {
//        return self.isEmpty ? "-" : self
//    }
    
    func maskEmail() -> String {
        let components = self.components(separatedBy: "@")
        guard components.count == 2 else { return self } // Check if the email has correct format
        
        let username = components[0]
        let domain = components[1]
        
        if username.count <= 3 {
            return "\(username.prefix(1))***@\(domain)"
        } else {
            let prefix = username.prefix(3)
            let asterisks = String(repeating: "*", count: username.count - 3)
            return "\(prefix)\(asterisks)@\(domain)"
        }
    }
    
    func defaultValue() -> String {
        return !self.isEmpty ? self : "N/A"
    }
    
    func generateSKUCode() -> String {
        if self.count >= 3 {
            let firstTwoCharacters = self.prefix(2)
            let lastCharacter = self.suffix(1)
            return String(firstTwoCharacters + lastCharacter)//.uppercased()
        } else {
            return self//.uppercased()
        }
    }
    
    func shortString(_ count: Int = 15) -> String {
        if self.count > count {
            return String(self.prefix(count)) + "..."
        }
        return self
    }
    
    func maxString(_ n: Int) -> String {
        if self.count > n {
            let index = self.index(self.startIndex, offsetBy: n)
            return String(self[..<index])
        } else {
            return self
        }
    }
    
    func shortenFilename(length: Int) -> String {
        guard self.count > length else { return self }
        
        let fileExtension = (self as NSString).pathExtension
        let basename = (self as NSString).deletingPathExtension
        
        let partLength = (length - 3 - fileExtension.count) / 2
        let start = basename.prefix(partLength)
        let end = basename.suffix(partLength)
        
        return "\(start) ... \(end).\(fileExtension)"
    }

}

extension NSAttributedString {
    func attributedStringWithResizedImages(with maxWidth: CGFloat) -> NSAttributedString {
        let text = NSMutableAttributedString(attributedString: self)
        text.enumerateAttribute(NSAttributedString.Key.attachment, in: NSMakeRange(0, text.length), options: .init(rawValue: 0), using: { (value, range, stop) in
            if let attachement = value as? NSTextAttachment {
                let image = attachement.image(forBounds: attachement.bounds, textContainer: NSTextContainer(), characterIndex: range.location)!
                if image.size.width > maxWidth {
                    let newImage = image.resizeImage(scale: maxWidth/image.size.width)
                    let newAttribut = NSTextAttachment()
                    newAttribut.image = newImage
                    text.addAttribute(NSAttributedString.Key.attachment, value: newAttribut, range: range)
                }
            }
        })
        return text
    }
}





extension String {
    
    var utfData: Data {
        return Data(utf8)
    }
    
    var attributedHtmlString: NSAttributedString? {
        
        do {
            return try NSAttributedString(data: utfData, options: [
              .documentType: NSAttributedString.DocumentType.html,
              .characterEncoding: String.Encoding.utf8.rawValue
            ],
            documentAttributes: nil)
        } catch {
            print("Error:", error)
            return nil
        }
    }
    
    /*
     Below variable will convert youtube ID to embedded Youtube link.
    */
        var youtubeVideoURL: String?{
            let url = "https://www.youtube.com/embed/\(self.youtubeID ?? "")"
            return url
        }


    /*
    Here below variable return us Youtube ID from URL String.

    e.g. if Youtube link = "https://youtu.be/-zD8M66aAA4" then we'll get YoutubeID = "-zD8M66aAA4"
    */
        var youtubeID: String? {
            let pattern = "((?<=(v|V)/)|(?<=be/)|(?<=(\\?|\\&)v=)|(?<=embed/)|(?<=shorts/))([\\w-]++)"
            
            let regex = try? NSRegularExpression(pattern: pattern, options: .caseInsensitive)
            let range = NSRange(location: 0, length: count)

            guard let result = regex?.firstMatch(in: self, range: range) else {
                return nil
            }
            
            return (self as NSString).substring(with: result.range)
        }
}

extension UILabel {
   func setAttributedHtmlText(_ html: String) {
      if let attributedText = html.attributedHtmlString {
         self.attributedText = attributedText
      }
   }
}

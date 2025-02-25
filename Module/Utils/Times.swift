//
//  Times.swift
//  LS
//
//  Created by macmini on 04/08/2023.
//

import UIKit

public class Times {
    public static let shared = Times()
    
    public enum Component {
        case DAY
        case MONTH
        case YEAR
    }
    
    public static let MILLIS_PER_DAY: Int64 = 24*60*60*1000
    public static let MILLIS_PER_MIN: Int64 = 60*1000
    
    public func now() -> Int64 {
        return Int64(Date().timeIntervalSince1970 * 1000)
    }
    
    public func now2() -> Int64 {
        return Int64(Date().timeIntervalSince1970)
    }
    
    public func toTimeMillis(date: Date) -> Int64 {
        return Int64(date.timeIntervalSince1970 * 1000)
    }
    
    public func today() -> Date {
        return Date()
    }
    
    public func toDate(timeMillis: Int64) -> Date {
        return Date(timeIntervalSince1970: (Double(timeMillis) / 1000.0))
    }
    
    public func toDate2(timeMillis: Int64) -> Date {
        return Date(timeIntervalSince1970: Double(timeMillis))
    }
    
    public func addMonth(from: Date, offset: Int) -> Int64 {
        let result = Calendar.current.date(byAdding: Calendar.Component.month, value: offset, to: from as Date)
        return Times.shared.toTimeMillis(date: result!)
    }
    
    public func addDay(from: Date, offset: Int) -> Int64 {
        let result = Calendar.current.date(byAdding: Calendar.Component.day, value: offset, to: from as Date)
        return Times.shared.toTimeMillis(date: result!)
    }
    
    public func addYear(from: Date, offset: Int) -> Int64 {
        let result = Calendar.current.date(byAdding: Calendar.Component.year, value: offset, to: from as Date)
        return Times.shared.toTimeMillis(date: result!)
    }
    
    public func add(component: Component, offset: Int) -> Int64 {
        return add(component: component, from: today(), offset: offset)
    }
    
    public func add(component: Component, from: Date, offset: Int) -> Int64 {
        switch component {
        case .DAY:
            return Times.shared.addDay(from: from, offset: offset)
        case .MONTH:
            return Times.shared.addMonth(from: from, offset: offset)
        case .YEAR:
            return Times.shared.addYear(from: from, offset: offset)
        }
    }
    
    public func daysBetweenInt64Date(startDate: Int64, endDate: Int64) -> Double {
        return Double((endDate - startDate)/Times.MILLIS_PER_DAY)
    }
    
    public func daysBetweenUInt64Date(startDate: UInt64, endDate: UInt64) -> Double {
        return Double((endDate - startDate)/UInt64(Times.MILLIS_PER_DAY))
    }
    
    public func startOfDay() -> Int64 {
        var calendar = NSCalendar.current
        calendar.timeZone = NSTimeZone.local
        let dateAtMidnight = calendar.startOfDay(for: Date())
        return Int64(dateAtMidnight.timeIntervalSince1970 * 1000)
    }
    
    public func startOfDate(date: Date) -> Int64 {
        var calendar = NSCalendar.current
        calendar.timeZone = NSTimeZone.local
        let dateAtMidnight = calendar.startOfDay(for: date)
        return Int64(dateAtMidnight.timeIntervalSince1970 * 1000)
    }
    
    public func startOfDateToDate(date: Date, locale: String = "en_US", useUTC: Bool = false) -> Date {
        var calendar = NSCalendar.current
        calendar.locale = Locale(identifier: locale)
        if useUTC {
            calendar.timeZone = TimeZone(secondsFromGMT: 0) ?? .current
        }
        else {
            calendar.timeZone = NSTimeZone.local
        }
        let startOfDay = calendar.startOfDay(for: date)
        return startOfDay
    }
    
    public func getCountDay(startDate: Date, endDate: Date) -> Int {
        var totalMilis: Int64 = 0
        let milisStartDate = Times.shared.startOfDate(date: startDate)
        let milisEndDate = Times.shared.startOfDate(date: endDate)
        if milisEndDate > milisStartDate {
            totalMilis = milisEndDate - milisStartDate
        }
        if totalMilis > 0 {
            return Int(totalMilis / Times.MILLIS_PER_DAY)
        }
        return 0
    }
    
    public func getCountDayMilliseconds(_ startMilliseconds: Int64, _ endMilliseconds: Int64) -> Int {
        // Convert milliseconds to Date objects
        let startDate = Date(timeIntervalSince1970: TimeInterval(startMilliseconds) / 1000)
        let endDate = Date(timeIntervalSince1970: TimeInterval(endMilliseconds) / 1000)
        
        // Calculate the difference in days using Calendar
        let calendar = Calendar.current
        let components = calendar.dateComponents([.day], from: startDate, to: endDate)
        
        // Return the difference in days
        return components.day ?? 0
    }
    
    public func getCountMonth(startDate: Date, endDate: Date) -> Int {
        var startDateVar = startDate
        var milisStartDate = Times.shared.startOfDate(date: startDate)
        let milisEndDate = Times.shared.startOfDate(date: endDate)
        var countTimes = 0
        while (milisStartDate < milisEndDate) {
            startDateVar = Calendar.current.date(byAdding: .month, value: 1, to: startDateVar)!
            milisStartDate = Times.shared.startOfDate(date: startDateVar)
            countTimes += 1
        }
        return countTimes
    }
    
    public func getTotalTime(startDate: Date, endDate: Date, components: Calendar.Component) -> DateComponents {
        let calendar = Calendar.current
        let startDateX = calendar.dateComponents([.day,.month,.year], from: startDate)
        let endDateX = calendar.dateComponents([.day,.month,.year], from: endDate)
        return calendar.dateComponents([components], from: startDateX, to: endDateX)
    }
    
    public func getDateStringFromUInt64(dates: UInt64, type: String) -> String {
         //Convert to Date
         let date = NSDate(timeIntervalSince1970: Double(dates) / 1000)
         //Date formatting
         let dateFormatter = DateFormatter()
         dateFormatter.amSymbol = "AM"
         dateFormatter.pmSymbol = "PM"
         dateFormatter.dateFormat = type
         dateFormatter.locale = Locale(identifier: "vi_VN")
         //        dateFormatter.timeZone = NSTimeZone(name: "Asia/SaiGon") as TimeZone!
         //        dateFormatter.locale = Locale(identifier: localizationStr)
         return dateFormatter.string(from: date as Date)
    }
    
    public func getDateStringFromInt64(dates: Int64, type: String = "dd/MM/yyyy", locale: String = "en", isUseFullStyle: Bool = false) -> String {
        guard dates > 0 else {
            return ""
        }
        //Convert to Date
        let date = NSDate(timeIntervalSince1970: Double(dates) / 1000)
        //Date formatting
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: locale)
        dateFormatter.amSymbol = "AM"
        dateFormatter.pmSymbol = "PM"
        if isUseFullStyle {
            dateFormatter.dateStyle = .full
            dateFormatter.timeStyle = .none
        }
        else {
            dateFormatter.dateFormat = type
        }
//        dateFormatter.dateFormat = type
        //dateFormatter.locale = Locale(identifier: "vi_VN")
        //        dateFormatter.timeZone = NSTimeZone(name: "Asia/SaiGon") as TimeZone!
        //        dateFormatter.locale = Locale(identifier: localizationStr)
        return dateFormatter.string(from: date as Date)
    }
    
    public func getDateStringFromInt64NotPlus1000(dates: Int64, type: String) -> String {
         //Convert to Date
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = type
        return dateFormatter.string(from: toDate(timeMillis: dates))
    }
    
    public func getTimeFromSecond(seconds: Int64) -> String{
        let hour = seconds / 3600
        let minute = (seconds / 60) % 60
        var hourString = "\(hour)"
        if hour < 10 { hourString = "0\(hourString)"}
        var minuteString = "\(minute)"
        if minute < 10 { minuteString = "0\(minuteString)" }
        return "\(hourString):\(minuteString)"
    }
    
    public func getTimeFromSecondV2(seconds: Int64) -> String{
        let hour = seconds / 3600
        let minute = (seconds / 60) % 60
        var hourString = "\(hour)"
        let seconds = seconds - minute*60 - hour*3600
        if hour < 10 { hourString = "0\(hourString)"}
        var minuteString = "\(minute)"
        if minute < 10 { minuteString = "0\(minuteString)" }
        var seconString = "\(seconds)"
        if seconds < 10 { seconString = "0\(seconString)" }
//        \(hourString):
        return "\(minuteString):\(seconString)"
    }
    
    /// get date string from date picker
    /// - Parameter isUseFullStyle: set true if use khmer localized - if not use type
    public func getDateStringFromDatePicker(date: Date, type: String,locale: String = "vi_VN", isUseFullStyle: Bool = false) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: locale)
        if isUseFullStyle {
            dateFormatter.dateStyle = .full
            dateFormatter.timeStyle = .none
        }
        else {
            dateFormatter.dateFormat = type
        }
        return dateFormatter.string(from: date)
    }
    
    public func toDateString(timeMillis: Int64, type: String = "dd/MM/yyyy") -> String {
        if timeMillis == 0 { return "" }
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = type
        return dateFormatter.string(from: toDate(timeMillis: timeMillis))
    }
    
    /// convert from millis to date (+ n date) with default plus 1,5
    public func toPlusDateString(timeMillis: Int64, datePlus: Double = 1.5, type: String = "dd/MM/yyyy") -> String {
        if timeMillis == 0 { return "" }
        
        // Chuyển đổi timeMillis sang Date
        let date = Date(timeIntervalSince1970: TimeInterval(timeMillis) / 1000)
        
        // Thêm 1.5 ngày (1.5 * 24 * 60 * 60 giây)
        let updatedDate = date.addingTimeInterval(datePlus * 24 * 60 * 60)
        
        // Định dạng ngày
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = type
        return dateFormatter.string(from: updatedDate)
    }
    
    public func convertStringDateToTimeStamp(dateString: String) -> Int {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy"
        let date = dateFormatter.date(from: dateString)
        let dateStamp:TimeInterval = date!.timeIntervalSince1970
        let dateSt:Int = Int(dateStamp)
        return dateSt
    }
    
   
    
    public func toDateStringV2(timeMillis: Int64, type: String = "dd/MM/yyyy HH:mm") -> String {
        guard timeMillis > 0 else {
            return ""
        }
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = type
        return dateFormatter.string(from: toDate(timeMillis: timeMillis))
    }
    
    public func toDateStringV3(timeMillis: Int64) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "hh:mm a 'on' MMM d, yyyy "
        return dateFormatter.string(from: toDate(timeMillis: timeMillis))
    }
    
    public func toTimeString(timeMillis: Int64) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm"
        return dateFormatter.string(from: toDate(timeMillis: timeMillis))
    }
    
    public func toTimeString12Format(timeMillis: Int64) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "hh:mm a"
        return dateFormatter.string(from: toDate(timeMillis: timeMillis))
    }
    
    public func toDatesOfMonth(timeMillis: Int64, type: String = "dd", locale: String = "en_US") -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = type
        dateFormatter.locale = Locale(identifier: locale)
        return dateFormatter.string(from: toDate(timeMillis: timeMillis))
    }
    
    public func toDatesOfWeek(timeMillis: Int64, locale: String = "en_US") -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "E"
        dateFormatter.locale = Locale(identifier: locale)
        return dateFormatter.string(from: toDate(timeMillis: timeMillis))
    }
    
    public func toMonth(timeMillis: Int64, type: String = "MM", locale: String = "en_US") -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = type
        dateFormatter.locale = Locale(identifier: locale)
        return dateFormatter.string(from: toDate(timeMillis: timeMillis))
    }
    
    public func toYear(timeMillis: Int64) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy"
        return dateFormatter.string(from: toDate(timeMillis: timeMillis))
    }
    
    public func stringToDate(_ dateString: String, type: String = "dd/MM/yyyy", locale: String = "en_US", useUTC: Bool = false) -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = type
        dateFormatter.locale = Locale(identifier: locale)
        if useUTC {
            dateFormatter.timeZone = TimeZone(secondsFromGMT: 0) 
        }
        return dateFormatter.date(from: dateString)
    }
    
    /// use for check valid date
    /// if < numberOfYear -> false else true
    /// default numberOfYear: 150
    public func isValidDOB(_ dob: Date, numberOfYear: Int = 150) -> Bool {
        let calendar = Calendar.current
        let now = Date()

        // Ngày 150 năm trước
        guard let minDate = calendar.date(byAdding: .year, value: -numberOfYear, to: now) else {
            return false
        }

        return dob >= minDate && dob <= now
    }
    
    public func convertKmerDateStrToDate(khmerDate: String) -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd.MM.yyyy"
        dateFormatter.locale = Locale(identifier: "km-KH")
        //.replacingOccurrences(of: ".", with: "/")
        if let date = dateFormatter.date(from: khmerDate) {
            // Convert the Date object to a Unix timestamp (milliseconds since 1970)
            return date
        } else {
            // Handle the case where date parsing fails
            return nil
        }
    }
    
    public func convertKhmerDateStringToString(_ khmerDateString: String, with type: String = "dd/MM/yyyy") -> String? {
        if khmerDateString.isEmpty {
            return nil
        }
        
        let dateFormatter = DateFormatter()

        dateFormatter.locale = Locale(identifier: "km-KH")
        dateFormatter.dateFormat = "EEEE dd MMMM yyyy"

        guard let date = dateFormatter.date(from: khmerDateString) else {
            return nil
        }
        
        dateFormatter.locale = Locale(identifier: "en_US")
        dateFormatter.dateFormat = type
        let numericDateString = dateFormatter.string(from: date)
        
        return numericDateString
    }
    
    public func convertDateToString(_ date: Date, type: String = "dd MMM yyyy", locale: String = "en_US") -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = type
        dateFormatter.locale = Locale(identifier: locale)
        return dateFormatter.string(from: date)
    }
    
    public func getAllMonthOfYear() -> [String] {
        let formatter = DateFormatter()
        if let monthComponents = formatter.shortMonthSymbols {
            return monthComponents
        }
        return []
    }
    
    public func getAllYearFromCurrent(_ count: Int) -> [String] {
        let currentDate = Date()
        let calendar = Calendar.current
        let currentYear = calendar.component(.year, from: currentDate)
        let years = ((currentYear - count)...currentYear).map { String($0) }
        return years
    }
    
    public func getAllYearAfterCurrent(_ count: Int) -> [String] {
        let currentDate = Date()
        let calendar = Calendar.current
        let currentYear = calendar.component(.year, from: currentDate)
        let years = (currentYear...(currentYear + count)).map { String($0) }
        return years
    }
    
   
}

extension Date {
    var startOfDay : Date {
        var calendar = Calendar.current
        calendar.timeZone = TimeZone.init(secondsFromGMT: 7*3600)!
        let unitFlags = Set<Calendar.Component>([.year, .month, .day])
        let components = calendar.dateComponents(unitFlags, from: self)
        return calendar.date(from: components)!
   }

    var endOfDay : Date {
        var components = DateComponents()
        components.day = 1
        let date = Calendar.current.date(byAdding: components, to: self.startOfDay)
//        let timezoneOffset = TimeZone.current.secondsFromGMT()
        if let time = date?.addingTimeInterval(Double(-1)) {// + Double(timezoneOffset)
            return time
        }
        return startOfDay
    }
    
    static func dates(from fromDate: Date, to toDate: Date) -> [Date] {
        var dates: [Date] = []
        var date = fromDate
        
        while date <= toDate {
            dates.append(date)
            guard let newDate = Calendar.current.date(byAdding: .day, value: 1, to: date) else { break }
            date = newDate
        }
        return dates
    }
    
    func convertToString(with format: String) -> String{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        let stringDate = dateFormatter.string(from: self)
        return stringDate
    }
    
    var currentTimeZone : Date {
        let formatter = DateFormatter()
        formatter.timeZone = TimeZone.current
        return formatter.date(from: self.convertToString(with: "DD/MM/YYYY")) ?? self.startOfDay
    }
    
    var millisecondsSince1970: Int64 {
        Int64((self.timeIntervalSince1970 * 1000.0).rounded())
    }
    
    func getMondayByDate(myDate: Date) -> Date {
        let cal = Calendar.current
        var comps = cal.dateComponents([.weekOfYear, .yearForWeekOfYear], from: myDate)
        comps.weekday = 2 // Monday
        let mondayInWeek = cal.date(from: comps)!
        return mondayInWeek
    }
    
    func getWeekDates() -> (thisWeek:[Date],nextWeek:[Date]) {
        var tuple: (thisWeek:[Date],nextWeek:[Date])
        var arrThisWeek: [Date] = []
        for i in 0..<7 {
            arrThisWeek.append(Calendar.current.date(byAdding: .day, value: i, to: startOfWeek)!)
        }
        var arrNextWeek: [Date] = []
        for i in 1...7 {
            arrNextWeek.append(Calendar.current.date(byAdding: .day, value: i, to: arrThisWeek.last!)!)
        }
        tuple = (thisWeek: arrThisWeek,nextWeek: arrNextWeek)
        return tuple
    }
    
    var tomorrow: Date {
        return Calendar.current.date(byAdding: .day, value: 1, to: noon)!
    }
    var noon: Date {
        return Calendar.current.date(bySettingHour: 12, minute: 0, second: 0, of: self)!
    }
    
    var startOfWeek: Date {
        let gregorian = Calendar(identifier: .gregorian)
        let sunday = gregorian.date(from: gregorian.dateComponents([.yearForWeekOfYear, .weekOfYear], from: self))
        return gregorian.date(byAdding: .day, value: 1, to: sunday!)!
    }
    
    func getDayAgo(_ day: Int) -> Int64 {
        if let dayAgo = Calendar.current.date(byAdding: .day, value: day, to: Date()) {
            return Int64(dayAgo.timeIntervalSince1970 * 1000)
        } else {
            return 0
        }
    }
    
    func getMondayThisWeekInMilliseconds() -> Int64 {
        let arrWeekDates = getWeekDates()
        return arrWeekDates.thisWeek.first!.millisecondsSince1970
    }
    
    func getSundayThisWeekInMilliseconds() -> Int64 {
        let arrWeekDates = getWeekDates()
        return arrWeekDates.thisWeek[arrWeekDates.thisWeek.count - 1].millisecondsSince1970
    }
    
    func startOfMonth() -> Date {
        return Calendar.current.date(from: Calendar.current.dateComponents([.year, .month], from: Calendar.current.startOfDay(for: self)))!
    }
    
    func startOfMonthInMilliseconds() -> Int64 {
        return (Calendar.current.date(from: Calendar.current.dateComponents([.year, .month], from: Calendar.current.startOfDay(for: self)))!).millisecondsSince1970
    }
    
    func endOfMonthInMilliseconds() -> Int64 {
        return (Calendar.current.date(byAdding: DateComponents(month: 1, day: -1), to: self.startOfMonth())!).millisecondsSince1970
    }
    
    func startOfYearInMilliseconds() -> Int64 {
        let year = Calendar.current.component(.year, from: Date())
        return (Calendar.current.date(from: DateComponents(year: year, month: 1, day: 1))!).millisecondsSince1970
    }
    
    func endOfYearInMilliseconds() -> Int64 {
        let year = Calendar.current.component(.year, from: Date())
        if let firstOfNextYear = Calendar.current.date(from: DateComponents(year: year + 1, month: 1, day: 1)) {
            return (Calendar.current.date(byAdding: .day, value: -1, to: firstOfNextYear)!).millisecondsSince1970
        }
        return 0
    }
    
    func distance2(from date: Date, only component: Calendar.Component, calendar: Calendar = .current) -> Int? {
        return calendar.dateComponents([component], from: date, to: self).value(for: component)
    }
    
    func hasSame2(_ component: Calendar.Component, as date: Date, calendar: Calendar = .current) -> Bool {
        calendar.isDate(self, equalTo: date, toGranularity: component)
    }
    
    func distance(from date: Date, only component: Calendar.Component, calendar: Calendar = .current) -> Int {
        let days1 = calendar.component(component, from: self)
        let days2 = calendar.component(component, from: date)
        return days1 - days2
    }
    
    func hasSame(_ component: Calendar.Component, as date: Date) -> Bool {
        distance(from: date, only: component) == 0
    }
    
    func isSameMonth(_ date2: Date) -> Bool {
        let calendar = Calendar.current
        let components1 = calendar.dateComponents([.year, .month], from: self)
        let components2 = calendar.dateComponents([.year, .month], from: date2)
        
        return components1.year == components2.year && components1.month == components2.month
    }
    
    func isSameMonthOrGreater(_ date2: Date) -> Bool {
        let calendar = Calendar.current
        
        let components1 = calendar.dateComponents([.year, .month], from: self)
        let components2 = calendar.dateComponents([.year, .month], from: date2)
        
        if components1.year == components2.year && components1.month == components2.month {
            return true
        } else {
            return self > date2
        }
    }
}


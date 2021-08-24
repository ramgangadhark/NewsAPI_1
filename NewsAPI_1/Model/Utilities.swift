//
//  Utilities.swift
//  NewsAPI_1
//
//  Created by Ram on 24/08/21.
//

import Foundation
class Utilities: NSObject {
    static var shared = Utilities()
    
    private override init() {
        super.init()
    }
    
    static func calculateTimeDifference(from dateTime1: String, to dateTime2: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        
        let dateAsString = dateTime1
        let date1 = dateFormatter.date(from: dateAsString)!
        
        let dateAsString2 = dateTime2
        let date2 = dateFormatter.date(from: dateAsString2)!
        
        let components : NSCalendar.Unit = [.second, .minute, .hour, .day,.month, .year]
        let difference = (Calendar.current as NSCalendar).components(components, from: date1, to: date2, options: [])
        
        var dateTimeDifferenceString = ""
        
        if difference.day != 0 {
            dateTimeDifferenceString = "\(difference.day!) day \(difference.hour!) hours ago"
        } else if  difference.day == 0 {
            dateTimeDifferenceString = "\(difference.hour!) hours ago"
        }
        
        return dateTimeDifferenceString
        
    }
    
    static func getCurrentTime() -> String{
        let todayDate = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let currentTime = formatter.string(from: todayDate)
        
        return currentTime
    }
}



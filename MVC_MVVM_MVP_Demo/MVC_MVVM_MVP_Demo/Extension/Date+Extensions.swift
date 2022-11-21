//
//  Date+Extensions.swift
//  CommunityList
//
//  Created by Deepak on 23/02/21.
//

import Foundation

extension Date {
    // get difference to specific date
    func timeAgoDisplay(style: RelativeDateTimeFormatter.UnitsStyle = .full) -> String {
        let formatter = RelativeDateTimeFormatter()
        formatter.unitsStyle = style
        let value =  formatter.localizedString(for: self, relativeTo: Date())
        if value == "in 0 seconds"{
            return "0 seconds ago"
        }else{
            return value
        }
    }
    
    
    func daySuffix() -> String {
        let calendar = Calendar.current
        let components = (calendar as NSCalendar).components(.day, from: self)
        let dayOfMonth = components.day
        switch dayOfMonth {
        case 1, 21, 31:
            return "st"
        case 2, 22:
            return "nd"
        case 3, 23:
            return "rd"
        default:
            return "th"
        }
    }
    
    var millisecondsSince1970:Int64 {
        return Int64((self.timeIntervalSince1970 * 1000.0).rounded())
    }

    init(milliseconds:Int64) {
        self = Date(timeIntervalSince1970: TimeInterval(milliseconds) / 1000)
    }
    
}

//
//  String+Extensions.swift
//  MVC_MVVM_MVP_Demo
//
//

import Foundation

extension String {
    // get localized string of given string
    var localized: String {
        return NSLocalizedString(self, comment: "")
    }
    
    // returns true if string contains only numbers
    func isNumber() -> Bool {
        let decimalCharacters = CharacterSet.decimalDigits
        let decimalRange = rangeOfCharacter(from: decimalCharacters)
        if decimalRange != nil {
            return true
        } else {
            return false
        }
    }

    // returns true if string contains valid email address
    var isValidEmail: Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        
        let emailPred = NSPredicate(format: "SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: self)
    }
    
    var detectedLinks: [String] { DataDetector.find(all: .link, in: self) }
    var detectedFirstLink: String? { DataDetector.first(type: .link, in: self) }
    var detectedURLs: [URL] { detectedLinks.compactMap { URL(string: $0) } }
    var detectedFirstURL: URL? {
        guard let urlString = detectedFirstLink else { return nil }
        return URL(string: urlString)
    }
    
    //Compare two string dates
    func compareDates(fromTime:String , toTime: Date, formate:String) ->Bool{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = formate
        
        guard let fD = dateFormatter.date(from: fromTime) else {
            return false
        }
        
        dateFormatter.dateFormat = "yyyy-MM-dd"
        
        guard let nfd = dateFormatter.date(from: dateFormatter.string(from: fD)) else {
            return false
        }
        
        guard let ntd = dateFormatter.date(from: dateFormatter.string(from: toTime)) else {
            return false
        }
        let result = nfd.compare(ntd)
        if result == .orderedSame{
            return true
        }else{
            return false
        }
        
    }
    //change formate of string date
    func formateDate(fromFomatter:String, toFormatter:String) ->String{
        
        let dateFormatter = DateFormatter()
        
        dateFormatter.dateFormat = fromFomatter
        
        guard let date = dateFormatter.date(from: self) else {
            return ""
        }
        
        dateFormatter.dateFormat = toFormatter
        return dateFormatter.string(from: date)
        
    }
    
    var isValidText: Bool {
        guard !self.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty else {
            return false
        }
        
        return true
    }
    
    func getDate(fomatter:String) ->Date{
        
        let dateFormatter = DateFormatter()
        
        dateFormatter.dateFormat = fomatter
        
        guard let date = dateFormatter.date(from: self) else {
            return Date()
        }
        
        return date
        
    }
    func titleCase() -> String {
            return self
                .replacingOccurrences(of: "([A-Z])",
                                      with: " $1",
                                      options: .regularExpression,
                                      range: range(of: self))
                .trimmingCharacters(in: .whitespacesAndNewlines)
                .capitalized // If input is in llamaCase
        }
}

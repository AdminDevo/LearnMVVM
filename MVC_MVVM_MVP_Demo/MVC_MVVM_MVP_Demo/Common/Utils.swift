//
//  Utils.swift
//  MVC_MVVM_MVP_Demo
//
//

import Foundation
import Alamofire

//MARK: - Check Network
var isNetworkAvailable : Bool {
    return NetworkReachabilityManager()!.isReachable
   }
func printLog(_ printStr: Any...)
{
    if isDebug
    {
        print(printStr)
    }
}
var localTimeZoneIdentifier: String { return TimeZone.current.identifier }

var timeZoneAbbreviations: [String:String] { return TimeZone.abbreviationDictionary }
var currentTimeZone:String{
    for (key, value) in timeZoneAbbreviations {
        if value == localTimeZoneIdentifier{
            print(key)
            return key
            
        }
    }
    
    return ""
}
var currenOffset:Int{
    return TimeZone.current.secondsFromGMT()
}

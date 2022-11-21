//
//  Encodable+Extension.swift
//  MVC_MVVM_MVP_Demo
//
//

import Foundation
// get dictionary from encodable model
extension Encodable {
    subscript(key: String) -> Any? {
        return dictionary[key]
    }

    var dictionary: [String: Any] {
        return (try? JSONSerialization.jsonObject(with: JSONEncoder().encode(self))) as? [String: Any] ?? [:]
    }
    var toString: NSString? {
        guard let rowData = try? JSONEncoder().encode(self) else { return "" }
        guard let object = try? JSONSerialization.jsonObject(with: rowData, options: []),
              let data = try? JSONSerialization.data(withJSONObject: object, options: [.prettyPrinted]),
              let prettyPrintedString = NSString(data: data, encoding: String.Encoding.utf8.rawValue) else { return nil }
        return prettyPrintedString
    }
}

//
//  EndPoint.swift
//  MVC_MVVM_MVP_Demo
//
//

import Foundation
import Alamofire

let isDebug = true // true When Sharing Diawi Build & false when sharing Production build

// returning base url
extension URL {
    static var bashURL: URL {
        if  isDebug {
            return URL(string: URLConstant.devUrl)!
        } else {
            return URL(string: URLConstant.prodUrl)!
        }
    }
}

typealias Params = [String: Any]

// model for defining path and type of api request
struct EndPoint {
    let path: String
    let method: HTTPMethod

    var url: URL {
        return URL.bashURL.appendingPathComponent(path)
    }
}

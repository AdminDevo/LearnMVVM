//
//  APIManager.swift
//  MVC_MVVM_MVP_Demo
//
//

import Foundation
import Alamofire
import Foundation

// defining types of error message
enum ErrorMessage: Error {
    case noInternet
    case noData
    case other(String)
    var localString: String {
        switch self {
        case .noInternet:
            return "No internet connection"
        case .noData:
            return "No data available"
        case let .other(err):
            return err
        }
    }
}

class APIManager {
    private init() {}
    static let shared = APIManager()
    
    private var defaultParams: Parameters {
        return [:]
    }

    func apiRequest<T: Decodable>(endpoint: EndPoint,
                                  parameters: Params?, completionHandler: @escaping (Result<T, ErrorMessage>) -> Void){
        if !isNetworkAvailable{
            completionHandler(.failure(.noInternet))
            return
        }
        
        var params = defaultParams
        parameters?.forEach { key, value in
            params[key] = value
        }
        let token = UserDefaults.standard.value(forKey: UserDefaultsKeys.accessToken.rawValue) as? String ?? ""
        let header:HTTPHeaders = ["Authorization":token]
        
        printLog("URL: \(endpoint.url) endpoint.method \(endpoint.method)")
        printLog("PARAMS: \(params)")
        
        AF.request(endpoint.url, method: endpoint.method, parameters: params, headers: header).responseDecodable(completionHandler: {  (response: AFDataResponse<T>) in
            printLog(response)
            switch response.result{
            case .success( _):
                guard let data = response.data else {
                    completionHandler(.failure(.noData))
                    return
                }
                let decoder = JSONDecoder()
                do{
                    let value = try decoder.decode(T.self, from: data)
                        completionHandler(.success(value))
                    
                }catch let jsonErr{
                   // print("json error : \(jsonErr.localizedDescription)")

                    completionHandler(.failure(.other(jsonErr.localizedDescription)))
                }
            case .failure( _):
                completionHandler(.failure(.other(response.error?.localizedDescription ?? "")))
                print("failed: \(response.error?.localizedDescription ?? "")")
                //failHandler(error)
            }
        })
    }
    
    // api request for upload data
    func apiMultiPartRequest<T: Decodable>(endpoint: EndPoint, parameters: Params?, uploadParams: Params, completionHandler: @escaping (Result<T, ErrorMessage>) -> Void) {
        
        if !isNetworkAvailable{
            completionHandler(.failure(.noInternet))
            return
        }
        
        var params = defaultParams
        parameters?.forEach { key, value in
            params[key] = value
        }
        let token = UserDefaults.standard.value(forKey: UserDefaultsKeys.accessToken.rawValue) as? String ?? ""
        let header:HTTPHeaders = ["Authorization":token]
        
        printLog("URL: \(endpoint.url) endpoint.method \(endpoint.method)")
        printLog("PARAMS: \(params)")
        AF.upload(multipartFormData: { multipartFormData in
            for (key, value) in params {
                multipartFormData.append(((value as AnyObject).stringValue).data(using: .utf8)!, withName: key)
            }
            
            if uploadParams["fileType"] as? String ?? "" == "file"{
                for (key, value) in uploadParams {
                    if let fileURL = value as? URL{
                        let fileName = fileURL.lastPathComponent
                        let data = try! Data(contentsOf: fileURL)
                        multipartFormData.append(data, withName: key,fileName: fileName, mimeType: fileURL.mimeType())
                    }
                }
            }else{
                for (key, value) in uploadParams {
                    if let imageData = (value as? UIImage ?? UIImage()).jpegData(compressionQuality: 0.4){
                        print(imageData.count)
                        multipartFormData.append(imageData, withName: key, fileName: "\(Date().millisecondsSince1970)image.png", mimeType: "image/jpeg")
                    }
                }
            }
        },to: endpoint.url, method: endpoint.method,headers: header).responseDecodable(completionHandler: {  (response: AFDataResponse<T>) in
            
            switch response.result{
            case .success(let responseData):
                //print("API Response: \(responseData)")
                guard let data = response.data else {
                    completionHandler(.failure(.noData))
                    return
                }
                let decoder = JSONDecoder()
                do{
                    let value = try decoder.decode(T.self, from: data)
                        completionHandler(.success(value))
                    
                }catch let jsonErr{
                   // print("json error : \(jsonErr.localizedDescription)")

                    completionHandler(.failure(.other(jsonErr.localizedDescription)))
                }
            case .failure( _):
                completionHandler(.failure(.other(response.error?.localizedDescription ?? "")))
                print("failed: \(response.error?.localizedDescription ?? "")")
                //failHandler(error)
            }
        })
    }
}

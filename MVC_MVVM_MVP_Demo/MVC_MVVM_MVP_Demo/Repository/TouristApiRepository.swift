//
//  TouristApiRepository.swift
//  MVC_MVVM_MVP_Demo
//
//
// This is repository class
// Here you can add your all api call regarding with particular module.
import Foundation

class MVCTouristApiRepository {
  //get tourist list
    func getTouristList(model: MVCTouristRequestModel, completionHandler: @escaping (Result<MVCTouristListModel, ErrorMessage>) -> Void) {
        APIManager.shared.apiRequest(endpoint: EndPoint(path: URLConstant.MethodName.getTourist, method: .get), parameters: model.dictionary, completionHandler:  completionHandler)
    }
    
}

class TouristApiRepository {
  //get tourist list
    func getTouristList(model: TouristRequestModel, completionHandler: @escaping (Result<TouristListModel, ErrorMessage>) -> Void) {
        APIManager.shared.apiRequest(endpoint: EndPoint(path: URLConstant.MethodName.getTourist, method: .get), parameters: model.dictionary, completionHandler:  completionHandler)
    }
    
}

class MVPTouristApiRepository {
  //get tourist list
    func getTouristList(model: MVCTouristRequestModel, completionHandler: @escaping (Result<MVCTouristListModel, ErrorMessage>) -> Void) {
        APIManager.shared.apiRequest(endpoint: EndPoint(path: URLConstant.MethodName.getTourist, method: .get), parameters: model.dictionary, completionHandler:  completionHandler)
    }
    
}

class VIPERTouristApiRepository {
  //get tourist list
    func getTouristList(model: VIPERTouristRequestModel, completionHandler: @escaping (Result<EntityTouristListModel, ErrorMessage>) -> Void) {
        APIManager.shared.apiRequest(endpoint: EndPoint(path: URLConstant.MethodName.getTourist, method: .get), parameters: model.dictionary, completionHandler:  completionHandler)
    }
    
}

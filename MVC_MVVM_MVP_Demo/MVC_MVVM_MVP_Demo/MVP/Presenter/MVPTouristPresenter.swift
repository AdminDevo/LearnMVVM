//
//  MVPTouristPresenter.swift
//  MVC_MVVM_MVP_Demo
//

//

import Foundation
import UIKit

protocol PresenterViewDelegate: AnyObject {
    func updateLabel(getUser:[MVCTourist])
}

class PresenterTouristList {
    
    var delegate : PresenterViewDelegate?
    let api = MVPTouristApiRepository()
  
    func getTouristList1() {
        
        api.getTouristList(model: MVCTouristRequestModel(page: 1), completionHandler: { [weak self] result in
           
            switch result{
            case .success(let tourist):
               
                self?.delegate?.updateLabel(getUser: tourist.data ?? [])
                
            case .failure(let error):
                let msg = error.localString
                debugPrint(msg)
            }
        })
    }
    
    
}

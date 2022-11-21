//
//  Interactor.swift
//  MVC_MVVM_MVP_Demo
//

//

import Foundation
import UIKit

class TouristListInteractor: PresenterToInteractorTouristListProtocol {
    
    let api = VIPERTouristApiRepository()
    weak var presenter: InteractorToPresenterTouristListProtocol?
    
    func fetchTouristList() {
        api.getTouristList(model: VIPERTouristRequestModel(page: 1), completionHandler: { [weak self] result in
           
            switch result{
            case .success(let tourist):
               
                self?.presenter?.fetchTouristListSuccess(touristList: tourist.data!)
                
            case .failure(let error):
                let msg = error.localString
                self?.presenter?.fetchTouristListFailure(error: "Tourist list not found")
                debugPrint(msg)
            }
        })
    }
}

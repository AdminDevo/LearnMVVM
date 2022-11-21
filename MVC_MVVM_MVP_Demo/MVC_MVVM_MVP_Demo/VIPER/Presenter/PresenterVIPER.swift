//
//  PresenterVIPER.swift
//  MVC_MVVM_MVP_Demo
//

//

import Foundation

import UIKit

// MARK: - Contains the view logic to prepare the content for Display

class TouristListPresenter: ViewToPresenterTouristListProtocol{
     
    var touristList = [EntityTourist]()
    
    weak var view: PresenterToViewTouristListProtocol?
    var interactor: PresenterToInteractorTouristListProtocol?
    var router: PresenterToRouterTouristListProtocol?
    
    func viewDidLoad() {
        view?.showActivity()
        // Presenter is asking to Interactor to load new data:
        interactor?.fetchTouristList()
    }
}

extension TouristListPresenter: InteractorToPresenterTouristListProtocol {
    
    func fetchTouristListSuccess(touristList: [EntityTourist]) {
        view?.hideActivity()
        view?.onFetchTouristListSuccess(entityTouristFromView: touristList)
    }
    
    func fetchTouristListFailure(error: String) {
        view?.hideActivity()
        view?.onFetchTouristListFailure(error: "Fetch tourist error message-\(error)")
    }
    
}

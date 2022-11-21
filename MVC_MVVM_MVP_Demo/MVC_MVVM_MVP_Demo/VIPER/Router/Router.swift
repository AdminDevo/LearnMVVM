//
//  Router.swift
//  MVC_MVVM_MVP_Demo
//

//

import UIKit

// MARK: - Router Input (Presenter -> Router)
protocol PresenterToRouterTouristListProtocol {
    static func createModule() -> UIViewController?
}

class TouristRouter: PresenterToRouterTouristListProtocol {
    
    static func createModule() -> UIViewController? {
        
        let stryBoard = UIStoryboard(name: "Main", bundle: nil)
        let viewController = stryBoard.instantiateViewController(withIdentifier: "VIPERTourishListVc") as! VIPERTourishListVc
                
        let presenter: ViewToPresenterTouristListProtocol & InteractorToPresenterTouristListProtocol = TouristListPresenter()
        
        viewController.presenter = presenter
        viewController.presenter?.router = TouristRouter()
        viewController.presenter?.view = viewController
        viewController.presenter?.interactor = TouristListInteractor()
        viewController.presenter?.interactor?.presenter = presenter
        
        return viewController
    }
}



//
//  TouristProtocol.swift
//  MVC_MVVM_MVP_Demo
//
//

import Foundation

// MARK: - View Input (View -> Presenter)
protocol ViewToPresenterTouristListProtocol {
    var view: PresenterToViewTouristListProtocol? { get set }
    var interactor: PresenterToInteractorTouristListProtocol? { get set }
    var router: PresenterToRouterTouristListProtocol? { get set }
    func viewDidLoad()
}

// MARK: - View Output (Presenter -> View)
protocol PresenterToViewTouristListProtocol: AnyObject {
    func onFetchTouristListSuccess(entityTouristFromView: [EntityTourist])
    func onFetchTouristListFailure(error: String)
    func showActivity()
    func hideActivity()
}

// MARK: - Interactor Input (Presenter -> Interactor)
protocol PresenterToInteractorTouristListProtocol {
    var presenter: InteractorToPresenterTouristListProtocol? { get set }
    func fetchTouristList()
}

// MARK: - Interactor Output (Interactor -> Presenter)
protocol InteractorToPresenterTouristListProtocol: AnyObject {
    func fetchTouristListSuccess(touristList: [EntityTourist])
    func fetchTouristListFailure(error: String)
}

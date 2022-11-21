//
//  TouristViewModel.swift
//  MVC_MVVM_MVP_Demo
//
//
//View Model for your particular controller view.
import Foundation

class TouristViewModel {
    
    let api = TouristApiRepository()
    
    var touristList : [Tourist] = [Tourist](){
        didSet {
            self.reloadTableViewClosure?()
        }
    }
    var isLoading: Bool = false {
        didSet {
            self.updateLoadingStatus?()
        }
    }
    
    var alertMessage: String? {
        didSet {
            self.showAlertClosure?()
        }
    }
    
    var updateLoadingStatus: (()->())?
    var showAlertClosure: (()->())?
    var reloadTableViewClosure: (()->())?
    
    var numberOfCells: Int {
        return touristList.count
    }
    var page: Int = 1 {
        didSet {
            self.getTouristList()
        }
    }
    func getTouristList() {
       
        api.getTouristList(model: TouristRequestModel(page: 1), completionHandler: { [weak self] result in
            self?.isLoading = false
            switch result{
            case .success(let tourist):
               
                self?.touristList.append(contentsOf: tourist.data ?? [])
               
            case .failure(let error):
                self?.alertMessage = error.localString
            }
        })
    }
    //get data of particular indexpath.
    func getCellViewModel( at indexPath: IndexPath ) -> Tourist {
        return touristList[indexPath.row]
    }
}

//
//  TouristListViewController.swift
//  MVC_MVVM_MVP_Demo
//
//

import UIKit

class TouristListViewController: UIViewController {
    
    @IBOutlet private weak var tableView: UITableView!
    private var viewModel = TouristViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    func setup(){
        setupTableView()
        initVM()
    }
    
    private func setupTableView(){
        tableView.delegate = self
        tableView.dataSource = self
        tableView.loadControl?.heightLimit = 20.0
    }
   
    private func initVM() {
        //show any message or error from api on view.
        viewModel.showAlertClosure = { [weak self] in
            DispatchQueue.main.async {
                if let message = self?.viewModel.alertMessage {
                    self?.showAlert(message)
                }
            }
        }
        //show/hide loader for api call.
        viewModel.updateLoadingStatus = { [weak self] in
            DispatchQueue.main.async {
                let isLoading = self?.viewModel.isLoading ?? false
                if isLoading {
                    self?.view.showHud()
                }else{
                    self?.view.hideHud()
                }
            }
        }
        //set your data.
        viewModel.reloadTableViewClosure = { [weak self] in
            DispatchQueue.main.async {
                self?.tableView.loadControl?.endLoading()
                self?.tableView.reloadData()
            }
        }
        // call you api method.
        viewModel.getTouristList()
    }
    
}

//MARK: - Tableview Delegates
extension TouristListViewController: UITableViewDelegate, UITableViewDataSource {
   
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfCells
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier:  "TouristTVC") as! TouristTVC
        let data = viewModel.getCellViewModel(at: indexPath)
        cell.setData(model: data)
        cell.selectionStyle = .none
        return cell
    }

}


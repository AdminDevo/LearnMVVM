//
//  VIPERTourishListVc.swift
//  MVC_MVVM_MVP_Demo
//

//

import UIKit
import MBProgressHUD

class VIPERTourishListVc: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    var presenter: (ViewToPresenterTouristListProtocol & InteractorToPresenterTouristListProtocol)?
    var entityTourist : [EntityTourist] = [EntityTourist]()
   
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.viewDidLoad()
        setupTableView()
    }
    
    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.loadControl?.heightLimit = 20.0
    }

}

extension VIPERTourishListVc: PresenterToViewTouristListProtocol {
    
    func onFetchTouristListSuccess(entityTouristFromView: [EntityTourist]) {
        entityTourist = entityTouristFromView
        tableView?.reloadData()
    }
    
    func onFetchTouristListFailure(error: String) {
        // handle error:
        print(error)
    }
    
    func showActivity() {
        // show activity:
        self.view.showHud()
    }
    
    func hideActivity() {
        // hide activity:
        self.view.hideHud()
    }
}


//MARK: - Tableview Delegates
extension VIPERTourishListVc: UITableViewDelegate, UITableViewDataSource {
   
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return entityTourist.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier:  "VIPERTouristListCell") as! VIPERTouristListCell
        let data = entityTourist[indexPath.row]
        cell.setData(model: data)
        cell.selectionStyle = .none
        return cell
    }

}


class VIPERTouristListCell: UITableViewCell {
    
    @IBOutlet private weak var lblName: UILabel!
    @IBOutlet private weak var lblEmail: UILabel!
    @IBOutlet private weak var lblLocation: UILabel!
    @IBOutlet private weak var userImg: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    var model : EntityTourist? {
        didSet {
            lblName.text = model?.touristName ?? ""
            lblEmail.text = model?.touristEmail ?? ""
            lblLocation.text = model?.touristLocation ?? ""
            userImg.setImageFromUrl(url: model?.touristProfilepicture ?? "", placeHolder: UIImage(systemName: "person.fill"))
        }
    }
    //Another way to set data
    func setData(model : EntityTourist?){
        lblName.text = model?.touristName ?? ""
        lblEmail.text = model?.touristEmail ?? ""
        lblLocation.text = model?.touristLocation ?? ""
        userImg.setImageFromUrl(url: model?.touristProfilepicture ?? "", placeHolder: UIImage(systemName: "person.fill"))
    }
}

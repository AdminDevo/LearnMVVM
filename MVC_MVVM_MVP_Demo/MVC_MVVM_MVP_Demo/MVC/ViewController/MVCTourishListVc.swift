//
//  MVCTourishListVc.swift
//  MVC_MVVM_MVP_Demo
//

//

import UIKit
import MBProgressHUD
class MVCTourishListVc: UIViewController {
    
    @IBOutlet private weak var tblView: UITableView!
    
    var mvcTouristList : [MVCTourist] = [MVCTourist]()
    let api = MVCTouristApiRepository()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tblView.delegate = self
        tblView.dataSource = self
        getTouristList()
    }
    
    func getTouristList() {
        self.view.showHud()
        api.getTouristList(model: MVCTouristRequestModel(page: 1), completionHandler: { [weak self] result in
           
            switch result{
            case .success(let tourist):
                
                self?.mvcTouristList.append(contentsOf: tourist.data ?? [])
                self?.tblView.reloadData()
                self?.view.hideHud()
                
            case .failure(let error):
                self?.showAlert(error.localString)
            }
        })
    }
    
}

extension MVCTourishListVc: UITableViewDelegate, UITableViewDataSource {
   
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return mvcTouristList.count
    }
    
   
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tblView.dequeueReusableCell(withIdentifier:  "MVCTouristListCell") as! MVCTouristListCell
        //let data = viewModel.getCellViewModel(at: indexPath)
        let data = mvcTouristList[indexPath.row]
        cell.setData(model: data)
        cell.selectionStyle = .none
        return cell
    }
}

class MVCTouristListCell: UITableViewCell {
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
    var model : MVCTourist? {
        didSet {
            lblName.text = model?.touristName ?? ""
            lblEmail.text = model?.touristEmail ?? ""
            lblLocation.text = model?.touristLocation ?? ""
            userImg.setImageFromUrl(url: model?.touristProfilepicture ?? "", placeHolder: UIImage(systemName: "person.fill"))
        }
    }
    //Another way to set data
    func setData(model : MVCTourist?){
        lblName.text = model?.touristName ?? ""
        lblEmail.text = model?.touristEmail ?? ""
        lblLocation.text = model?.touristLocation ?? ""
        userImg.setImageFromUrl(url: model?.touristProfilepicture ?? "", placeHolder: UIImage(systemName: "person.fill"))
    }
}

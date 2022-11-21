//
//  MVPTouristListVc.swift
//  MVC_MVVM_MVP_Demo
//

//

import UIKit

class MVPTouristListVc: UIViewController {
    
    @IBOutlet private weak var tblView: UITableView!
    var mvcTouristList : [MVCTourist] = [MVCTourist]()
    
    private let presenter = PresenterTouristList()

    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.delegate = self
        presenter.getTouristList1()
        tblView.delegate = self
        tblView.dataSource = self
    }
    
   
}

extension MVPTouristListVc: PresenterViewDelegate {
    
    func updateLabel(getUser: [MVCTourist]) {
        mvcTouristList = getUser
        DispatchQueue.main.async {
            self.tblView.reloadData()
        }
    }
 
}

extension MVPTouristListVc: UITableViewDelegate, UITableViewDataSource {
   
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return mvcTouristList.count
    }
    
   
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tblView.dequeueReusableCell(withIdentifier:  "MVPTouristListCell") as! MVPTouristListCell
        //let data = viewModel.getCellViewModel(at: indexPath)
        let data = mvcTouristList[indexPath.row]
        cell.setData(model: data)
        cell.selectionStyle = .none
        return cell
    }
}

class MVPTouristListCell: UITableViewCell {
    
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



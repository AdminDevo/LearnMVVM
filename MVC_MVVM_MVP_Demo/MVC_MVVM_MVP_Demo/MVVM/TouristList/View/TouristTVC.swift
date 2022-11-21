//
//  TouristTVC.swift
//  MVC_MVVM_MVP_Demo
//
//

import UIKit

class TouristTVC: UITableViewCell {
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
    var model : Tourist? {
        didSet {
            lblName.text = model?.touristName ?? ""
            lblEmail.text = model?.touristEmail ?? ""
            lblLocation.text = model?.touristLocation ?? ""
            userImg.setImageFromUrl(url: model?.touristProfilepicture ?? "", placeHolder: UIImage(systemName: "person.fill"))
        }
    }
    //Another way to set data
    func setData(model : Tourist?){
        lblName.text = model?.touristName ?? ""
        lblEmail.text = model?.touristEmail ?? ""
        lblLocation.text = model?.touristLocation ?? ""
        userImg.setImageFromUrl(url: model?.touristProfilepicture ?? "", placeHolder: UIImage(systemName: "person.fill"))
    }
}

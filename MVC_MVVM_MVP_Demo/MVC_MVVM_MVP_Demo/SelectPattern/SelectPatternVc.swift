//
//  SelectPatternVc.swift
//  MVC_MVVM_MVP_Demo
//

//

import UIKit

class SelectPatternVc: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

    }

    @IBAction func btnAllPattern(_ sender: UIButton) {
        if sender.tag == 0 {
            let vc = storyboard?.instantiateViewController(withIdentifier: "MVCTourishListVc") as! MVCTourishListVc
            self.navigationController?.pushViewController(vc, animated: true)
        } else if sender.tag == 1 {
            let vc = TouristRouter.createModule()
            self.navigationController?.pushViewController(vc!, animated: true)
            
        } else if sender.tag == 2 {
            let vc = storyboard?.instantiateViewController(withIdentifier: "TouristListViewController") as! TouristListViewController
            self.navigationController?.pushViewController(vc, animated: true)
        } else if sender.tag == 3 {
            let vc = storyboard?.instantiateViewController(withIdentifier: "MVPTouristListVc") as! MVPTouristListVc
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
}

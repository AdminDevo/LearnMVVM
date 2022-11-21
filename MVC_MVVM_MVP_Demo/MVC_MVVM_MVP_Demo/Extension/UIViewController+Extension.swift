//
//  UIViewController+Extension.swift
//  MVC_MVVM_MVP_Demo
//
//

import Foundation
import UIKit

extension UIViewController{
    //Alert method
    func showAlert( _ message: String ) {
        let alert = UIAlertController(title: "Alert", message: message, preferredStyle: .alert)
        alert.addAction( UIAlertAction(title: "Ok", style: .cancel, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}

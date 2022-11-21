//
//  UIView+Extension.swift
//  MVC_MVVM_MVP_Demo
//
//

import Foundation
import MBProgressHUD
import UIKit

extension UIView {
    @IBInspectable var cornerRadiusV: CGFloat {
            get {
                return layer.cornerRadius
            }
            set {
                layer.cornerRadius = newValue
                layer.masksToBounds = newValue > 0
            }
        }

        @IBInspectable var borderWidthV: CGFloat {
            get {
                return layer.borderWidth
            }
            set {
                layer.borderWidth = newValue
            }
        }

        @IBInspectable var borderColorV: UIColor? {
            get {
                return UIColor(cgColor: layer.borderColor!)
            }
            set {
                layer.borderColor = newValue?.cgColor
            }
        }
    // show progressing view
    @discardableResult
    func showHud(text: String = "Please Wait") -> MBProgressHUD {
        let loadingNotification = MBProgressHUD.showAdded(to: self, animated: true)
        loadingNotification.mode = MBProgressHUDMode.indeterminate
        loadingNotification.label.text = text
        return loadingNotification
    }
    
    // hide progressing view
    func hideHud() {
        MBProgressHUD.hide(for: self, animated: true)
    }
}

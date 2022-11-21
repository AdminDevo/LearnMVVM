//
//  UIImageView+Extension.swift
//  MVC_MVVM_MVP_Demo
//
//

import Foundation
import SDWebImage

extension UIImageView {
    
    func setImageFromUrl(url: String, placeHolder: UIImage?){
        self.sd_imageIndicator = SDWebImageActivityIndicator.gray
        self.sd_setImage(with: URL(string: url), placeholderImage: placeHolder)

    }
}

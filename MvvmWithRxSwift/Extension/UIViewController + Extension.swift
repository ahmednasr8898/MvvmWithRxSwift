//
//  ViewController + Extension.swift
//  MvvmWithRxSwift
//
//  Created by Ahmed Nasr on 10/20/20.
//

import Foundation
import MBProgressHUD

extension UIViewController {
    func showIndicator(withTitle title: String, and description: String) {
        let indicator = MBProgressHUD.showAdded(to: self.view, animated: true)
        indicator.label.text = title
        indicator.isUserInteractionEnabled = false
        indicator.detailsLabel.text = description
        indicator.show(animated: true)
        self.view.isUserInteractionEnabled = false
    }
    func hideIndicator() {
        MBProgressHUD.hide(for: self.view, animated: true)
        self.view.isUserInteractionEnabled = true
    }
    func showAlert(title: String? , messege: String?){
        let alert = UIAlertController(title: title, message: messege, preferredStyle: .alert)
        let actionCancle = UIAlertAction(title: "Cancle", style: .cancel, handler: nil)
        alert.addAction(actionCancle)
        self.present(alert, animated: true, completion: nil)
    }
}

//
//  BasketViewControllerExtension.swift
//  LeLibro
//
//  Created by Ceyhun Məmmədli on 25.09.25.
//

import Foundation
import UIKit

extension BasketViewController {
    
    func alertForEmptyFields() {
        let alert = UIAlertController(title: "Unknown Address or Phone Number", message: "To finish your order, please, add address and phone number.", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default) { _ in
            let controller = self.storyboard?.instantiateViewController(withIdentifier: "ProfileViewController") as! ProfileViewController
            self.navigationController?.show(controller, sender: nil)
        }
        alert.addAction(okAction)
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        present(alert, animated: true)
    }
}

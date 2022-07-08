//
//  UIViewController + Extension.swift
//  RickAndMortyApp
//
//  Created by Eduard on 08.07.2022.
//

import UIKit

extension UIViewController {
    func showAlert(_ title: String, _ message: String, completion: @escaping() -> () = {}) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let actionButton = UIAlertAction(title: "Ok", style: .default) { _ in
            completion()
        }
        alertController.addAction(actionButton)
        
        self.present(alertController, animated: true)
    }
}

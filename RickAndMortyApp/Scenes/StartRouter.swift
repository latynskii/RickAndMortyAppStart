//
//  StartRouter.swift
//  RickAndMortyApp
//
//  Created by Eduard on 08.07.2022.
//

import UIKit

protocol StartRouterProtocol {
    
    init(_ viewC: UINavigationController)
    
    func showMore()
    
    func showAlert(_ title: String, _ message: String, completion: @escaping() -> ())
}

class StartRouter: StartRouterProtocol {
    
    let navigationVC: UINavigationController? 
    
    required init(_ navVC: UINavigationController) {
        self.navigationVC = navVC
    }
    
    func showMore() {
        //todo
    }
    
    func showAlert(_ title: String, _ message: String, completion: @escaping() -> ()) {
        DispatchQueue.main.async {
            guard let viewController = self.navigationVC?.viewControllers.first else { return }
            viewController.showAlert(title, message)
        }
    }
}

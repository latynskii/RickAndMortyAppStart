//
//  InitialRouter.swift
//  RickAndMortyApp
//
//  Created by Eduard on 08.07.2022.
//

import UIKit


//MARK: - Properties
protocol InitianalRouterProtocol {
    init(_ window: UIWindow)
    
    func start()
}

class InitianalRouter: InitianalRouterProtocol {
    //MARK: - Properties
    private let window: UIWindow

    required init(_ window: UIWindow) {
        self.window = window
    }

    //MARK: - Methods
    func start() {
        let viewController = StartViewController()
        let navVC = UINavigationController(rootViewController: viewController)
        let router = StartRouter(navVC)
        let presenter = StartPresenter(viewController, router: router)
        viewController.presenter = presenter
        
        window.rootViewController = navVC
        window.makeKeyAndVisible()
    }
}

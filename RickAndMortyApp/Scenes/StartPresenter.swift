//
//  StartPresenter.swift
//  RickAndMortyApp
//
//  Created by Eduard on 08.07.2022.
//

import Foundation

protocol StartViewProtocol: AnyObject {
    func reloadData()
}

protocol StartPresenterProtocol {
    var numberOfRows: Int { get }
    
    //todo Pagination
    var numberOfPage: Int { get set}
    var data: [Results] { get }
    init(_ view: StartViewProtocol, router: StartRouterProtocol)
    
    func showMoreTapped()
    
}

final class StartPresenter: StartPresenterProtocol {
    var data: [Results] = []
    
    var numberOfRows: Int {
        return data.count
    }
    var numberOfPage: Int = 1 {
        didSet {
            loadData(with: numberOfPage)
        }
    }
    weak var view: StartViewProtocol?
    private var router: StartRouterProtocol?
    private var networkManager: NetworkManagerProtocol?
    
    init(_ view: StartViewProtocol, router: StartRouterProtocol) {
        self.view = view
        self.networkManager = NetworkManager()
        self.router = router
        loadData(with: numberOfPage)
    }
    
    func showMoreTapped() {
        //TODO
    }
    
    private func loadData(with pageNumber: Int) {
        networkManager?.fetchAllCharaster(page: pageNumber, completed: { [unowned self] result in
            switch result {
            case .success(let result):
                DispatchQueue.main.async {
                    self.data = result
                    self.view?.reloadData()
                }
            case .failure(let error):
                router?.showAlert("Something wrong", error.rawValue) {
                    //todo check internet and make request again maybe
                }
            }
        })
    }
}

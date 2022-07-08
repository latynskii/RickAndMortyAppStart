//
//  NetworkManager.swift
//  RickAndMortyApp
//
//  Created by Eduard on 08.07.2022.
//

import Foundation

protocol NetworkManagerProtocol {
    func fetchAllCharaster(page : Int,completed : @escaping(Result<[Results],ErrorMess>) ->())
}

class NetworkManager: NetworkManagerProtocol {
    
    private let baseURL = "https://rickandmortyapi.com/api/character/"
    
    func fetchAllCharaster(page : Int,completed : @escaping(Result<[Results],ErrorMess>) ->()){
        let endpoint = baseURL + "?page=\(page)"
        guard let url = URL(string: endpoint) else{
            return
        }
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let _ = error {
                completed(.failure(.unableToComplete))
                return
            }
            guard let response = response as? HTTPURLResponse , response.statusCode == 200 else {
                completed(.failure(.invalidResponse))
                return
            }
            guard let data = data else {
                completed(.failure(.invalidData))
                return
            }
            do{
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let characters = try decoder.decode(Character.self, from: data)
                if let characters = characters.results {

                    completed(.success(characters))
                }else{
                    print("sıkıntı var")
                }
            }catch{
                completed(.failure(.invalidData))
            }
        }
        task.resume()
    }
}

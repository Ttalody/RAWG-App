//
//  NetworkService.swift
//  RAWG
//
//  Created by Артур on 27.02.2024.
//

import Foundation

final class NetworkService {
    static let shared = NetworkService()
    
    private let defaultSession = URLSession(configuration: .default)
    private var dataTask: URLSessionDataTask?
    
    private init() {}
    
    func requestTrending() {
        
    }
    
    func requestGames(completion: @escaping (Result<GameResponseModel, Error>) -> Void) {
        guard var urlComponents = URLComponents(string: APIContants.baseUrl.rawValue + APIContants.games.rawValue) else { return }
        
        urlComponents.queryItems =
        [URLQueryItem(name: APIContants.key.rawValue, value: APIContants.apiKey.rawValue)]
        
        guard let url = urlComponents.url else { return }
        
        var request = URLRequest(url: url)
        
        request.httpMethod = "GET"
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let jsonData = data {
                do {
                    
                    let gamesResponse = try JSONDecoder().decode(GameResponseModel.self, from: jsonData)
                    completion(.success(gamesResponse))
                } catch {
                    
                    completion(.failure(error))
                }
            }
        }.resume()
        
    }
    
    func requestSearched(text: String ,completion: @escaping (Result<GameResponseModel, Error>) -> Void) {
        guard var urlComponents = URLComponents(string: APIContants.baseUrl.rawValue + APIContants.games.rawValue) else { return }
        
        urlComponents.queryItems =
        [URLQueryItem(name: APIContants.key.rawValue, value: APIContants.apiKey.rawValue),
         URLQueryItem(name: APIContants.search.rawValue, value: text)]
        
        guard let url = urlComponents.url else { return }
        
        var request = URLRequest(url: url)
        
        request.httpMethod = "GET"
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let jsonData = data {
                do {
                    
                    let gamesResponse = try JSONDecoder().decode(GameResponseModel.self, from: jsonData)
                    completion(.success(gamesResponse))
                } catch {
                    
                    completion(.failure(error))
                }
            }
        }.resume()
    }
    
    func requestDetails(id: Int ,completion: @escaping (Result<GameDetailsModel, Error>) -> Void) {
        guard var urlComponents = URLComponents(string: APIContants.baseUrl.rawValue + APIContants.games.rawValue + "/" + String(id)) else { return }
        
        urlComponents.queryItems =
        [URLQueryItem(name: APIContants.key.rawValue, value: APIContants.apiKey.rawValue)]
        
        guard let url = urlComponents.url else { return }
        
        var request = URLRequest(url: url)
        
        request.httpMethod = "GET"
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let jsonData = data {
                do {
                    
                    let gamesResponse = try JSONDecoder().decode(GameDetailsModel.self, from: jsonData)
                    completion(.success(gamesResponse))
                } catch {
                    
                    completion(.failure(error))
                }
            }
        }.resume()
    }
    
    func requestNextPage(nextPageUrl: String ,completion: @escaping (Result<GameResponseModel, Error>) -> Void) {
        guard let url = URL(string: nextPageUrl) else { return }
        
        var request = URLRequest(url: url)
        
        request.httpMethod = "GET"
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let jsonData = data {
                do {
                    
                    let gamesResponse = try JSONDecoder().decode(GameResponseModel.self, from: jsonData)
                    completion(.success(gamesResponse))
                } catch {
                    
                    completion(.failure(error))
                }
            }
        }.resume()
    }
}

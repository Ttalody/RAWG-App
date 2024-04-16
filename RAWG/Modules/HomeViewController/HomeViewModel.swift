//
//  HomeViewModel.swift
//  RAWG
//
//  Created by Артур on 03.03.2024.
//

import UIKit

final class HomeViewModel {
    
    var trendingGameResponse: GameResponseModel? {
        didSet {
            if let newGames = trendingGameResponse?.results {
                if trendingGames == nil {
                    trendingGames = newGames
                } else {
                    trendingGames?.append(contentsOf: newGames)
                }
            }
        }
    }
    
    var trendingGames: [GameModel]? {
        didSet {
            trendingGamesDidChange?()
        }
    }
    
    var gameResponse: GameResponseModel? {
        didSet {
            if let newGames = gameResponse?.results {
                if games == nil {
                    games = newGames
                } else {
                    games?.append(contentsOf: newGames)
                }
            }
        }
    }
    
    var games: [GameModel]? {
        didSet {
            gameListDidChange?()
        }
    }
    
    var gameListDidChange: (() -> Void)?
    var trendingGamesDidChange: (() -> Void)?
    
    func loadGameList() {
        NetworkService.shared.requestGames { result in
            switch result {
            case .success(let gamesResponse): self.gameResponse = gamesResponse
            case .failure(let error): print(error.localizedDescription)
            }
        }
    }
    
    func loadTrending() {
        NetworkService.shared.requestTrending() { result in
            switch result {
            case .success(let gamesResponse): self.trendingGameResponse = gamesResponse
            case .failure(let error): print(error.localizedDescription)
            }
        }
    }
    
    func loadMoreGames() {
        guard let url = gameResponse?.next else { return }
        NetworkService.shared.requestNextPage(nextPageUrl: url) { result in
            switch result {
            case .success(let gameResponse): self.gameResponse = gameResponse
            case .failure(let error): print(error.localizedDescription)
            }
        }
    }
    
    func pushToDetailsVC(at index: Int, navController: UINavigationController, isTrending: Bool = false) {
        if isTrending {
            guard let game = trendingGames?[index] else { return }
            let gameDetailViewModel = DetailsViewModel(game: game)
            let gameDetailViewController = DetailsViewController()
            gameDetailViewController.configure(with: gameDetailViewModel)
            navController.isNavigationBarHidden = false
            navController.pushViewController(gameDetailViewController, animated: true)
        } else {
            guard let game = games?[index] else { return }
            let gameDetailViewModel = DetailsViewModel(game: game)
            let gameDetailViewController = DetailsViewController()
            gameDetailViewController.configure(with: gameDetailViewModel)
            navController.isNavigationBarHidden = false
            navController.pushViewController(gameDetailViewController, animated: true)
        }
        
    }
    
}


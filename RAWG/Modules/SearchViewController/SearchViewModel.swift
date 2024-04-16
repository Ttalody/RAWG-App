//
//  SearchViewModel.swift
//  RAWG
//
//  Created by Артур on 14.04.2024.
//

import UIKit

final class SearchViewModel {
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
            updateData?()
        }
    }
    
    var updateData: (() -> Void)?
    
    func loadGames(text: String) {
        games = []
        NetworkService.shared.requestSearched(text: text) { result in
            switch result {
            case .success(let gameResponse): self.gameResponse = gameResponse
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
    
    func pushToDetailsVC(at index: Int, navController: UINavigationController) {
        let detailsVC = DetailsViewController(nibName: String(describing: DetailsViewController.self), bundle: nil)
        detailsVC.game = games?[index]
        navController.isNavigationBarHidden = false
        navController.pushViewController(detailsVC, animated: true)
    }
}

//
//  HomeViewModel.swift
//  RAWG
//
//  Created by Артур on 03.03.2024.
//

import UIKit

final class HomeViewModel {
    
    var games: [GameModel]? {
        didSet {
            self.gameListDidChange
        }
    }
    
    var gameListDidChange: (() -> Void)?
    
    func loadGameList() {
        NetworkService.shared.requestGames { result in
            switch result {
            case .success(let gamesResponse): self.games = gamesResponse.results
            case .failure(let error): print(error.localizedDescription)
            }
        }
    }
}


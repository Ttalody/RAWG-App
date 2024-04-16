//
//  DetailsViewModel.swift
//  RAWG
//
//  Created by Артур on 29.03.2024.
//

import UIKit

final class DetailsViewModel {
    var game: GameModel
    
    var gameDetails: GameDetailsModel? {
        didSet {
            updateContentView?()
        }
    }
    
    var updateContentView: (() -> Void)?
    var updateCollectionView: (() -> Void)?
    
    init(game: GameModel) {
        self.game = game
    }
    
    func loadDetails() {
        guard let gameId = game.id else { return }
        NetworkService.shared.requestDetails(id: gameId) { result in
            switch result {
            case .success(let gameDetails): self.gameDetails = gameDetails
            case .failure(let error): print(error.localizedDescription)
            }
        }
    }
}

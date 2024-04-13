//
//  HomeViewController.swift
//  RAWG
//
//  Created by Артур on 25.02.2024.
//

import UIKit

class HomeViewController: UIViewController {
    
    var games: [GameModel]? {
        didSet {
            DispatchQueue.main.async { [weak self] in
                self?.tableView.reloadData()
                self?.collectionView.reloadData()
            }
        }
    }
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var collectionView: UICollectionView!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NetworkService.shared.requestGames { result in
            switch result {
            case .success(let gamesResponse): self.games = gamesResponse.results
            case .failure(let error): print(error.localizedDescription)
            }
        }
        
        setupListTableView()
        
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(UINib(nibName: String(describing: CollectionViewCell.self), bundle: nil), forCellWithReuseIdentifier: CollectionViewCell.identifier)
        
    }
    
    private func setupListTableView() {
        tableView.rowHeight = UITableView.automaticDimension
        
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.register(UINib(nibName: String(describing: GameTableViewCell.self), bundle: nil), forCellReuseIdentifier: GameTableViewCell.identifier)
    }

}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        games?.count ?? 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: GameTableViewCell.identifier, for: indexPath) as? GameTableViewCell else { return UITableViewCell()}
        cell.configure(game: games?[indexPath.row])
        
        cell.needsUpdateConstraints()
        cell.updateConstraintsIfNeeded()
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailsVC = DetailsViewController(nibName: String(describing: DetailsViewController.self), bundle: nil)
        detailsVC.game = games?[indexPath.row]
        self.present(detailsVC, animated: true)
    }

    
}


extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        6
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CollectionViewCell.identifier, for: indexPath) as? CollectionViewCell else { return UICollectionViewCell()}
        cell.configure(game: games?[indexPath.row])
        return cell
    }
    
    
}

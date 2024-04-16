//
//  HomeViewController.swift
//  RAWG
//
//  Created by Артур on 25.02.2024.
//

import UIKit

final class HomeViewController: UIViewController {
    
    private var viewModel: HomeViewModel!
    
    @IBOutlet weak private var tableView: UITableView!
    @IBOutlet weak private var trendingCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViewController()
    }
    
}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.games?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: GameTableViewCell.identifier, for: indexPath) as? GameTableViewCell else { return UITableViewCell()}
        cell.configure(game: viewModel.games?[indexPath.row])
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let navController = self.navigationController else { return }
        viewModel.pushToDetailsVC(at: indexPath.row, navController: navController)
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let lastSectionIndex = tableView.numberOfSections - 1
        let lastRowIndex = tableView.numberOfRows(inSection: lastSectionIndex) - 1
        
        if indexPath.section == lastSectionIndex && indexPath.row == lastRowIndex {
            
            viewModel.loadMoreGames()
        }
    }
    
}


extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel.trendingGames?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CollectionViewCell.identifier, for: indexPath) as? CollectionViewCell else { return UICollectionViewCell()}
        cell.configure(game: viewModel.trendingGames?[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let navController = self.navigationController else { return }
        viewModel.pushToDetailsVC(at: indexPath.row, navController: navController, isTrending: true)
    }
}

private extension HomeViewController {
    func setupViewController() {
        viewModel = HomeViewModel()
        
        viewModel.gameListDidChange = { [weak self] in
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
        }
        
        viewModel.trendingGamesDidChange = { [weak self] in
            DispatchQueue.main.async {
                self?.trendingCollectionView.reloadData()
            }
        }
        
        viewModel.loadGameList()
        viewModel.loadTrending()
        
        setupListTableView()
        setupTrendingCollectionView()
    }
    
    func setupListTableView() {
        tableView.rowHeight = UITableView.automaticDimension
        
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.register(UINib(nibName: String(describing: GameTableViewCell.self), bundle: nil), forCellReuseIdentifier: GameTableViewCell.identifier)
    }
    
    func setupTrendingCollectionView() {
        trendingCollectionView.delegate = self
        trendingCollectionView.dataSource = self
        trendingCollectionView.register(UINib(nibName: String(describing: CollectionViewCell.self), bundle: nil), forCellWithReuseIdentifier: CollectionViewCell.identifier)
    }
}

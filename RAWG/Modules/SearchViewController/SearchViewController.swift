//
//  SearchViewController.swift
//  RAWG
//
//  Created by Артур on 25.02.2024.
//

import UIKit

class SearchViewController: UIViewController {
    
    private var viewModel: SearchViewModel!
    
    @IBOutlet weak private var searchBar: UISearchBar!
    
    @IBOutlet weak private var listTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViewContoller()
    }
}

extension SearchViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.games?.count ?? 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: GameTableViewCell = tableView.dequeueReusableCell(for: indexPath)
        
        cell.configure(game: viewModel.games?[indexPath.row])
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let navController = navigationController else { return }
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

extension SearchViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        if let searchText = searchBar.text {
            viewModel.loadGames(text: searchText)
        }
        searchBar.resignFirstResponder()
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchBar.showsCancelButton = true
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.showsCancelButton = false
        searchBar.resignFirstResponder()
    }
}

private extension SearchViewController {
    
    func setupViewContoller() {
        viewModel = SearchViewModel()
        setupListTableView()
        setupSearchBar()
        
        viewModel.updateData = { [weak self] in
            DispatchQueue.main.async {
                self?.listTableView.reloadData()
            }
        }
    }
    
    func setupListTableView() {
        listTableView.delegate = self
        listTableView.dataSource = self
        listTableView.register(GameTableViewCell.self)
    }
    
    func setupSearchBar() {
        searchBar.delegate = self
    }
}

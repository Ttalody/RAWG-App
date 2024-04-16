//
//  DetailsViewController.swift
//  RAWG
//
//  Created by Артур on 12.03.2024.
//

import UIKit

class DetailsViewController: UIViewController {
    
    var viewModel: DetailsViewModel!
    
    @IBOutlet weak private var contentTableView: UITableView!
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var headerView: UIView!
    
    @IBOutlet weak private var screenshotCollectionView: UICollectionView!
    
    @IBOutlet weak var ratingLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel.loadDetails()
        
        setupViewController()
    }
    
    func configure(with viewModel: DetailsViewModel) {
        self.viewModel = viewModel
    }
    
    private func setupViewController() {
        
        
        setupScreenhsotCollectionView()
        
        setupContentTableView()
        setupRatingLabel()
        
        viewModel.updateContentView = { [weak self] in
            DispatchQueue.main.async {
                self?.contentTableView.reloadData()
            }
        }
        
        viewModel.updateCollectionView = { [weak self] in
            DispatchQueue.main.async {
                self?.screenshotCollectionView.reloadData()
            }
        }
    }
    
    private func setupRatingLabel() {
        guard let rating = viewModel.game.metacritic else { return }
        
        ratingLabel.text = String(rating)
        
        if rating >= 70 {
            ratingLabel.textColor = .green
        } else if rating >= 40 && rating < 70 {
            ratingLabel.textColor = .yellow
        } else {
            ratingLabel.textColor = .red
        }
    }
    
    private func setupScreenhsotCollectionView() {
        screenshotCollectionView.delegate = self
        screenshotCollectionView.dataSource = self
        screenshotCollectionView.register(UINib(nibName: String(describing: ScreenshotCollectionViewCell.self), bundle: nil), forCellWithReuseIdentifier: ScreenshotCollectionViewCell.identifier)
    }
    
    private func setupContentTableView() {
        titleLabel.text = viewModel.game.name?.removeHTMLTags() ?? ""
        
        contentTableView.rowHeight = UITableView.automaticDimension
        
        contentTableView.delegate = self
        contentTableView.dataSource = self
        
        contentTableView.register(DescriptionTableViewCell.self)
        contentTableView.register(PlatformTableViewCell.self)
        contentTableView.register(BasicInfoTableViewCell.self)
    }
}

// MARK: Section

extension DetailsViewController {
    private enum Section: Int, CaseIterable {
        case description
        case genres
        case tags
        case developer
        case releaseDate
        case playtime
        case ageRating
        case platforms
        
        var title: String {
            switch self {
            case .description: return "Description"
            case .platforms: return "Platforms"
            case .developer: return "Developer"
            case .genres: return "Genres"
            case .tags: return "Tags"
            case .releaseDate: return "Release Date"
            case .playtime: return "Average Playtime"
            case .ageRating: return "Age Rating"
            }
        }
    }
}

// MARK: TableView

extension DetailsViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        Section.allCases.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let sectionType = DetailsViewController.Section(rawValue: section),
              let platformsCount = viewModel.game.platforms?.count,
              let developerCount = viewModel.gameDetails?.developers?.count else { return 0 }
        switch sectionType {
        case .description:
            return 1
        case .platforms:
            return platformsCount
        case .developer:
            return developerCount
        case .genres:
            return 1
        case .tags:
            return 1
        case .releaseDate:
            return 1
        case .playtime:
            return 1
        case .ageRating:
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let sectionType = Section(rawValue: indexPath.section) else { return UITableViewCell() }
        switch sectionType {
        case .description:
            let cell: DescriptionTableViewCell = tableView.dequeueReusableCell(for: indexPath)
            
            cell.configure(game: viewModel.gameDetails)
            
            return cell
        case .platforms:
            let cell: PlatformTableViewCell = tableView.dequeueReusableCell(for: indexPath)
            
            let platform = viewModel.gameDetails?.platforms?[indexPath.row]
            
            cell.configure(platform: platform)
            
            return cell
            
        case .developer:
            let cell: BasicInfoTableViewCell = tableView.dequeueReusableCell(for: indexPath)
            
            cell.configure(viewModel.gameDetails?.developers?[indexPath.row].name)
            
            return cell
            
            
        case .genres:
            let cell: BasicInfoTableViewCell = tableView.dequeueReusableCell(for: indexPath)
            
            let genreNames = viewModel.gameDetails?.genres?.map { $0.name }
            
            let genreNamesStr = genreNames?.joined(separator: ", ")
            
            cell.configure(genreNamesStr)
            
            return cell
            
        case .tags:
            let cell: BasicInfoTableViewCell = tableView.dequeueReusableCell(for: indexPath)
            
            let tagsNames = viewModel.gameDetails?.tags?.map { $0.name }
            
            let tagsStr = tagsNames?.joined(separator: ", ")
            
            cell.configure(tagsStr)
            
            return cell
            
        case .releaseDate:
            let cell: BasicInfoTableViewCell = tableView.dequeueReusableCell(for: indexPath)
            
            let releaseDate = DateFormatterService.shared.makePretty(viewModel.game.released ?? "")
            
            cell.configure(releaseDate)
            
            return cell
            
            
        case .playtime:
            let cell: BasicInfoTableViewCell = tableView.dequeueReusableCell(for: indexPath)
            
            let playtime = String(viewModel.game.playtime ?? 0)
            
            cell.configure(playtime)
            
            return cell
            
        case .ageRating:
            let cell: BasicInfoTableViewCell = tableView.dequeueReusableCell(for: indexPath)
            
            let ageRating = viewModel.gameDetails?.esrbRating?.name
            
            cell.configure(ageRating ?? "")
            
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.width, height: 40))
        headerView.backgroundColor = UIColor(named: "mainColor")
        
        let titleLabel = UILabel(frame: CGRect(x: 8, y: 0, width: tableView.frame.width - 16, height: 40))
        titleLabel.font = UIFont.systemFont(ofSize: 26, weight: .heavy)
        titleLabel.textColor = UIColor.white
        titleLabel.textAlignment = .left
        
        guard let sectionType = Section(rawValue: section) else { return nil }
        titleLabel.text = sectionType.title
        
        headerView.addSubview(titleLabel)
        return headerView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
}

// MARK: CollectionView

extension DetailsViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel.game.screenshots?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ScreenshotCollectionViewCell.identifier, for: indexPath) as? ScreenshotCollectionViewCell else { return UICollectionViewCell()}
        cell.configure(imageUrl: viewModel.game.screenshots?[indexPath.row].image ?? "")
        return cell
    }
    
}

extension DetailsViewController: UIScrollViewDelegate {
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        if velocity.y < 0 {
            navigationController?.setNavigationBarHidden(false, animated: true)
        }
        
    }
}

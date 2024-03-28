//
//  DetailsViewController.swift
//  RAWG
//
//  Created by Артур on 12.03.2024.
//

import UIKit

class DetailsViewController: UIViewController {
    
    var game: GameModel?
    var gameDetails: GameDetailsModel?
    
    var gameScreenshots: [ScreenshotsModel]? {
        didSet {
            DispatchQueue.main.async { [weak self] in
                self?.screenshotCollectionView.reloadData()
            }
        }
    }
    
    @IBOutlet weak var scrollView: UIScrollView!
    
    @IBOutlet weak var contentView: UIView!
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var descriptionLabel: UILabel!
    
    @IBOutlet weak var descriptionTextView: UITextView!
    
    @IBOutlet weak var ratingLabel: UILabel!
    
    @IBOutlet weak var ratingValueLabel: UILabel!
    
    @IBOutlet weak var releaseDateLabel: UILabel!
    
    @IBOutlet weak var releaseDateValueLabel: UILabel!
    
    @IBOutlet weak var lastUpdateLabel: UILabel!
    
    @IBOutlet weak var lastUpdateValueLabel: UILabel!
    
    @IBOutlet weak var playtimeLabel: UILabel!
    
    @IBOutlet weak var playtimeValueLabel: UILabel!
    
    @IBOutlet weak var platformsLabel: UILabel!
    
    @IBOutlet weak var platformsValueLabel: UILabel!
    
    @IBOutlet weak var requirementsLabel: UILabel!
    @IBOutlet weak var reqsRecommendedTextView: UITextView!
    
    @IBOutlet weak var reqsMinimumTextView: UITextView!
    
    @IBOutlet weak private var screenshotCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupCollectionView()
        
        getScreenshots()
        
        getInfo()
    }

    private func setupInfo(gameDetails: GameDetailsModel?){
        let releaseDate = DateFormatterService.shared.makePretty(gameDetails?.released ?? "")
        let updateDate = DateFormatterService.shared.makePretty(gameDetails?.updated ?? "")
        let platforms = gameDetails?.platforms?.compactMap {$0.platform?.name}
        let platformsNames = platforms?.joined(separator: "\n")
        
        DispatchQueue.main.async { [weak self] in
            self?.titleLabel.text = gameDetails?.name
            self?.descriptionTextView.text = gameDetails?.description
            self?.ratingValueLabel.text = String(gameDetails?.rating ?? 0)
            self?.releaseDateValueLabel.text = releaseDate
            self?.lastUpdateValueLabel.text = updateDate
            self?.playtimeValueLabel.text = String(gameDetails?.playtime ?? 0)
            self?.platformsValueLabel.text = platformsNames
            self?.reqsRecommendedTextView.text = gameDetails?.platforms?[0].requirements?.recommended
            self?.reqsMinimumTextView.text = gameDetails?.platforms?[0].requirements?.minimum
        }
        
    }
    
    private func setupCollectionView() {
        screenshotCollectionView.delegate = self
        screenshotCollectionView.dataSource = self
        screenshotCollectionView.register(UINib(nibName: String(describing: ScreenshotCollectionViewCell.self), bundle: nil), forCellWithReuseIdentifier: ScreenshotCollectionViewCell.identifier)
    }
    
    private func getScreenshots() {
        guard let game = game, let gameId = game.id else { return }
        NetworkService.shared.requestScreenshots(id: gameId) { result in
            switch result {
            case .success(let response): self.gameScreenshots = response.results

            case .failure(let error): print(error.localizedDescription)
            }
        }
    }
    
    private func getInfo() {
        guard let game = game, let gameId = game.id else { return }
        NetworkService.shared.requestDetails(id: gameId) { result in
            switch result {
            case .success(let gameDetails): self.gameDetails = gameDetails
                self.setupInfo(gameDetails: gameDetails)
            case .failure(let error): print(error.localizedDescription)
            }
        }
    }
    
    private func setupContentView() {
        
    }
}

extension DetailsViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        gameScreenshots?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ScreenshotCollectionViewCell.identifier, for: indexPath) as? ScreenshotCollectionViewCell else { return UICollectionViewCell()}
        cell.configure(imageUrl: gameScreenshots?[indexPath.row].image ?? "")
        return cell
    }
    
    
}

//
//  CollectionViewCell.swift
//  RAWG
//
//  Created by Артур on 27.02.2024.
//

import UIKit
import SDWebImage

final class CollectionViewCell: UICollectionViewCell {
    
    static let identifier = "CollectionViewCell"
    
    @IBOutlet weak private var titleLabel: UILabel!
    
    @IBOutlet weak private var ratingLabel: UILabel!
    
    @IBOutlet weak private var posterImageView: UIImageView!
    
    @IBOutlet weak private var customView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.layer.cornerRadius = 20
    }
    
    func configure(game: GameModel?) {
        if let url = URL(string: game?.backgroundImage ?? "") {
            self.posterImageView.sd_setImage(with: url)
        }
        self.titleLabel.text = game?.name
        if let rating = game?.metacritic {
            self.ratingLabel.text = String(rating)
            
            if rating >= 70 {
                ratingLabel.textColor = .green
            } else if rating >= 40 && rating < 70 {
                ratingLabel.textColor = .yellow
            } else {
                ratingLabel.textColor = .red
            }
        }
    }
    
}

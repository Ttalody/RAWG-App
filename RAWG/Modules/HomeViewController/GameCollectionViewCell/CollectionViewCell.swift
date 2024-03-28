//
//  CollectionViewCell.swift
//  RAWG
//
//  Created by Артур on 27.02.2024.
//

import UIKit
import SDWebImage

class CollectionViewCell: UICollectionViewCell {
    
    static let identifier = "CollectionViewCell"
    
    @IBOutlet weak private var titleLabel: UILabel!

    @IBOutlet weak var posterImageView: UIImageView!
    
    @IBOutlet weak var customView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.layer.cornerRadius = 20
    }
    
    func configure(game: GameModel?) {
        if let url = URL(string: game?.backgroundImage ?? "") {
            self.posterImageView.sd_setImage(with: url)
        }
        self.titleLabel.text = game?.name
    }

}

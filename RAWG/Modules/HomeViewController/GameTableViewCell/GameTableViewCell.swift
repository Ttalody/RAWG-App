//
//  GameTableViewCell.swift
//  RAWG
//
//  Created by Артур on 03.03.2024.
//

import UIKit
import SDWebImage

class GameTableViewCell: UITableViewCell {
    
    static let identifier = "GameTableViewCell"
    
    @IBOutlet weak private var posterImageView: UIImageView!
    @IBOutlet weak private var titleLabel: UILabel!
    @IBOutlet weak private var ratingLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        
//        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 5, left: 0, bottom: 5, right: 0))
        contentView.layer.cornerRadius = 20
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        self.selectionStyle = .none
        
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

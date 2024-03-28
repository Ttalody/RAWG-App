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
        
        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 5, left: 0, bottom: 5, right: 0))
        contentView.layer.cornerRadius = 20
        ratingLabel.layer.cornerRadius = 12
        ratingLabel.clipsToBounds = true
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
        self.ratingLabel.text = String(game?.rating ?? 0)
    }
    
}

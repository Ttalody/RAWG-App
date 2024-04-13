//
//  DescriptionTableViewCell.swift
//  RAWG
//
//  Created by Артур on 12.04.2024.
//

import UIKit

class DescriptionTableViewCell: UITableViewCell {
    
    static let identifier = "DescriptionTableViewCell"
    
    @IBOutlet weak private var descriptionLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configure(game: GameDetailsModel?) {
        guard let game = game else { return }
        descriptionLabel.text = game.description?.removeHTMLTags()
    }
}

//
//  BasicInfoTableViewCell.swift
//  RAWG
//
//  Created by Артур on 12.04.2024.
//

import UIKit

class BasicInfoTableViewCell: UITableViewCell {
    
    static let identifier = "BasicInfoTableViewCell"
    
    @IBOutlet weak private var infoLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configure(_ str: String?) {
        infoLabel.text = str
    }
    
}

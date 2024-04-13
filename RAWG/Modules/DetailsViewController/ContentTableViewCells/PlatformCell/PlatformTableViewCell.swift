//
//  PlatformTableViewCell.swift
//  RAWG
//
//  Created by Артур on 12.04.2024.
//

import UIKit

class PlatformTableViewCell: UITableViewCell {
    
    static let identifier = "PlatformTableViewCell"
    
    @IBOutlet weak private var platformTitleLabel: UILabel!
    @IBOutlet weak private var requirementsRecLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configure(platform: PlatformInfoModel?) {
        guard let platform = platform else { return }
        platformTitleLabel.text = platform.platform?.name
        requirementsRecLabel.text = platform.requirements?.recommended
    }
    
}

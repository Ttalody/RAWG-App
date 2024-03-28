//
//  ScreenshotCollectionViewCell.swift
//  RAWG
//
//  Created by Артур on 13.03.2024.
//

import UIKit
import SDWebImage

class ScreenshotCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "ScreenshotCollectionViewCell"
    
    @IBOutlet weak var screenshotImageView: UIImageView!
    
    @IBOutlet weak var customView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        contentView.layer.cornerRadius = 20
        contentView.clipsToBounds = true
    }

    func configure(imageUrl: String) {
        guard let url = URL(string: imageUrl) else { return }
        self.screenshotImageView.sd_setImage(with: url)
    }
    
}

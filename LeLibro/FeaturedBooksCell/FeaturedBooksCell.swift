//
//  FeaturedBooksCell.swift
//  LeLibro
//
//  Created by Ceyhun Məmmədli on 18.09.25.
//

import UIKit

class FeaturedBooksCell: UICollectionViewCell {
    @IBOutlet weak var coverImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        coverImage.layer.cornerRadius = 16
    }

}

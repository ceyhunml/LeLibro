//
//  GenreCollectionCell.swift
//  LeLibro
//
//  Created by Ceyhun Məmmədli on 15.09.25.
//

import UIKit

class GenreCollectionCell: UICollectionViewCell {
    @IBOutlet weak var backView: UIView!
    @IBOutlet weak var genreLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        genreLabel.font = UIFont(name: "Rosarivo", size: 16)
        backView.layer.cornerRadius = 10
        self.layer.cornerRadius = 10
        self.layer.masksToBounds = true
    }

}

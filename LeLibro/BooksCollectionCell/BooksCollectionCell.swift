//
//  BooksCollectionCell.swift
//  LeLibro
//
//  Created by Ceyhun Məmmədli on 16.09.25.
//

import UIKit

class BooksCollectionCell: UICollectionViewCell {
    @IBOutlet weak var starField: UIView!
    @IBOutlet weak var bookRating: UILabel!
    @IBOutlet weak var bookCover: UIImageView!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var priceField: UIView!
    @IBOutlet weak var basketButton: UIButton!
    @IBOutlet weak var bookNameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        starField.layer.cornerRadius = 15
        bookCover.layer.cornerRadius = 15
        priceField.layer.cornerRadius = 12
        bookNameLabel.font = UIFont(name: "Rosarivo", size: 14)
    }
    
    @IBAction func basketButtonPressed(_ sender: Any) {
    }
    
}

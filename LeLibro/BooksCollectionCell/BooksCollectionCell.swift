//
//  BooksCollectionCell.swift
//  LeLibro
//
//  Created by Ceyhun Məmmədli on 16.09.25.
//

import UIKit

class BooksCollectionCell: UICollectionViewCell {
    @IBOutlet private weak var starField: UIView!
    @IBOutlet private weak var bookRating: UILabel!
    @IBOutlet private weak var bookCover: UIImageView!
    @IBOutlet private weak var priceLabel: UILabel!
    @IBOutlet private weak var priceField: UIView!
    @IBOutlet private weak var basketButton: UIButton!
    @IBOutlet private weak var bookNameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        starField.layer.cornerRadius = 15
        bookCover.layer.cornerRadius = 15
        priceField.layer.cornerRadius = 12
        starField.layer.maskedCorners = [.layerMinXMinYCorner,
                                          .layerMaxXMaxYCorner]
        bookNameLabel.font = UIFont(name: "Rosarivo", size: 16)
    }
    
    @IBAction func basketButtonPressed(_ sender: Any) {
    }
    
    func configure(bookName: String, bookCover: String, bookPrice: String, bookRating: String) {
        self.bookNameLabel.text = bookName
        self.bookCover.image = UIImage(named: bookCover)
        self.priceLabel.text = bookPrice
        self.bookRating.text = bookRating
    }
}

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
    @IBOutlet private weak var favoritesButton: UIButton!
    @IBOutlet private weak var bookNameLabel: UILabel!
    
    var book: Book?
    
    var onFavoriteToggle: ((Book) -> Void)?
    
    var onBasketToggle: ((Book) -> Void)?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        starField.layer.cornerRadius = 15
        bookCover.layer.cornerRadius = 15
        priceField.layer.cornerRadius = 12
        starField.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMaxYCorner]
        bookNameLabel.font = UIFont(name: "Rosarivo", size: 16)
        favoritesButton.layer.cornerRadius = 12
        favoritesButton.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMinYCorner]
    }
    
    func configure(bookName: String,
                   bookCover: String,
                   bookPrice: String,
                   bookRating: String,
                   book: Book,
                   currentUser: UserEntity?) {
        self.book = book
        self.bookNameLabel.text = bookName
        self.priceLabel.text = bookPrice
        self.bookRating.text = bookRating
        self.bookCover.image = UIImage(named: bookCover)
        
        if let currentUser = currentUser {
            updateFavoriteIcon(for: book, currentUser: currentUser)
            updateBasketIcon(for: book, currentUser: currentUser)
        }
    }
    
    func updateFavoriteIcon(for book: Book, currentUser: UserEntity) {
        let isFavorite = currentUser.favoritesArray.contains(book.id)
        let imageName = isFavorite ? "heart.fill" : "heart"
        favoritesButton.setImage(UIImage(systemName: imageName), for: .normal)
    }

    func updateBasketIcon(for book: Book, currentUser: UserEntity) {
        let inBasket = currentUser.basketArray.contains(book.id)
        let imageName = inBasket ? "cart.fill" : "cart"
        basketButton.setImage(UIImage(systemName: imageName), for: .normal)
    }
    
    @IBAction func favoriteTapped(_ sender: UIButton) {
        guard let book = book else { return }
        onFavoriteToggle?(book)
    }
    
    @IBAction func basketButtonPressed(_ sender: UIButton) {
        guard let book = book else { return }
        onBasketToggle?(book)
    }
}


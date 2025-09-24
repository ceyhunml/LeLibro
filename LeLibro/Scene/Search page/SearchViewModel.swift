//
//  SearchViewModel.swift
//  LeLibro
//
//  Created by Ceyhun Məmmədli on 24.09.25.
//

import Foundation
import UIKit

class SearchViewModel {
    
    var books = [BookEntity]()
    
    var filteredBooks = [BookEntity]()
    
    let manager = CoreDataManager.shared
    
    let appearance = UINavigationBarAppearance()
    
    func toggleFavorite(for book: BookEntity, currentUser: UserEntity) {
        if let favorites = currentUser.favorites as? Set<BookEntity>,
           favorites.contains(where: { $0.objectID == book.objectID }) {
            currentUser.removeFromFavorites(book)
        } else {
            currentUser.addToFavorites(book)
        }
        CoreDataManager.shared.saveContext()
    }

    func toggleBasket(for book: BookEntity, currentUser: UserEntity) {
        if let basket = currentUser.basket as? Set<BookEntity>,
           basket.contains(where: { $0.objectID == book.objectID }) {
            currentUser.removeFromBasket(book)
        } else {
            currentUser.addToBasket(book)
        }
        CoreDataManager.shared.saveContext()
    }
}

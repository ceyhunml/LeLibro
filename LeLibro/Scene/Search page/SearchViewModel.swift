//
//  SearchViewModel.swift
//  LeLibro
//
//  Created by Ceyhun Məmmədli on 24.09.25.
//

import Foundation
import UIKit

class SearchViewModel {
    
    var books = [Book]()
    
    var filteredBooks = [Book]()
    
    let manager = CoreDataManager.shared
    
    let appearance = UINavigationBarAppearance()
    
    func toggleFavorite(for book: Book, currentUser: UserEntity) {
        var favorites = currentUser.favoritesArray
        if favorites.contains(book.id) {
            favorites.removeAll { $0 == book.id }
        } else {
            favorites.append(book.id)
        }
        currentUser.favoritesArray = favorites
        CoreDataManager.shared.saveContext()
    }
    
    func toggleBasket(for book: Book, currentUser: UserEntity) {
        var basket = currentUser.basketArray
        if basket.contains(book.id) {
            basket.removeAll { $0 == book.id }
        } else {
            basket.append(book.id)
        }
        currentUser.basketArray = basket
        CoreDataManager.shared.saveContext()
    }
}

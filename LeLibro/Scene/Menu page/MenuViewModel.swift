//
//  MenuViewModel.swift
//  LeLibro
//
//  Created by Ceyhun Məmmədli on 23.09.25.
//

import Foundation

class MenuViewModel {
    
    var books = [BookEntity]()
    
    var genres = [GenreSection]()
    
    var selectedGenre: String?
    
    var filteredBooks = [BookEntity]()
    
    let manager = CoreDataManager.shared
    
    var featuredBooks : [FeaturedBooks] = [
        FeaturedBooks(title: "The Fellowship of the Ring", bannerImage: "fellowship_banner"),
        FeaturedBooks(title: "The Two Towers", bannerImage: "two_towers_banner"),
        FeaturedBooks(title: "The Return of the King", bannerImage: "return_king_banner")
    ]
    
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
    
    func groupBooksByGenre() {
        genres = Dictionary(grouping: books) { $0.genre ?? "Unknown" }
            .map { GenreSection(genre: $0.key,
                                books: $0.value.sorted { ($0.title ?? "") < ($1.title ?? "") }) }
            .sorted { $0.genre < $1.genre }
    }
}

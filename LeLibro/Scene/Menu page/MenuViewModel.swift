//
//  MenuViewModel.swift
//  LeLibro
//
//  Created by Ceyhun Məmmədli on 23.09.25.
//

import Foundation

class MenuViewModel {
    
    var books = [Book]()
    
    var genres = [GenreSection]()
    
    var selectedGenre: String? = "All"
    
    var filteredBooks = [Book]()
    
    let manager = BookDataManager.shared
    
    let featuredBooks : [FeaturedBooks] = [
        FeaturedBooks(title: "The Fellowship of the Ring", bannerImage: "fellowship_banner"),
        FeaturedBooks(title: "The Two Towers", bannerImage: "two_towers_banner"),
        FeaturedBooks(title: "The Return of the King", bannerImage: "return_king_banner")
    ]
    
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
    
    func groupBooksByGenre() {
        let grouped = Dictionary(grouping: books) { $0.genre }
            .map { GenreSection(genre: $0.key,
                                books: $0.value.sorted { $0.title < $1.title }) }
            .sorted { $0.genre < $1.genre }
        
        genres = [GenreSection(genre: "All", books: books.sorted { $0.title < $1.title })] + grouped
    }
}

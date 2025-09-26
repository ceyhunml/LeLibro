//
//  GenreSection.swift
//  LeLibro
//
//  Created by Ceyhun Məmmədli on 16.09.25.
//

import Foundation

struct Book: Codable {
    let id: Int
    let title: String
    let author: String
    let publishedDate: String
    let genre: String
    let summary: String
    let coverImage: String
    let rating: Double
    let price: Double
}

struct GenreSection {
    let genre: String
    let books: [Book]
}

struct FeaturedBooks {
    let title: String
    let bannerImage: String
}

struct BasketItem {
    var book: Book
    var quantity: Int
}

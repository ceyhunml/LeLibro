//
//  GenreSection.swift
//  LeLibro
//
//  Created by Ceyhun Məmmədli on 16.09.25.
//

import Foundation

struct GenreSection {
    let genre: String
    let books: [BookEntity]
}

struct FeaturedBooks {
    let title: String
    let bannerImage: String
}

struct BasketItem {
    var book: BookEntity
    var quantity: Int
}

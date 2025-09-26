//
//  JSONDataManager.swift
//  LeLibro
//
//  Created by Ceyhun Məmmədli on 26.09.25.
//

import Foundation

final class BookDataManager {
    
    static let shared = BookDataManager()
    private init() {}
    
    var books = [Book]()
    
    func loadBooks() {
        
        guard let url = Bundle.main.url(forResource: "books", withExtension: "json") else { return }
        
        do {
            let data = try Data(contentsOf: url)
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            books = try decoder.decode([Book].self, from: data)
        } catch {
            print(error.localizedDescription)
        }
    }
}

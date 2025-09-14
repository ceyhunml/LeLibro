//
//  BookEntity+CoreDataProperties.swift
//  LeLibro
//
//  Created by Ceyhun Məmmədli on 14.09.25.
//
//

import Foundation
import CoreData


extension BookEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<BookEntity> {
        return NSFetchRequest<BookEntity>(entityName: "BookEntity")
    }

    @NSManaged public var title: String?
    @NSManaged public var author: String?
    @NSManaged public var publishedDate: Date?
    @NSManaged public var genre: String?
    @NSManaged public var summary: String?
    @NSManaged public var coverImage: String?
    @NSManaged public var rating: Double
    @NSManaged public var price: Double
    @NSManaged public var favorite: Bool
    @NSManaged public var inCart: Bool

}

extension BookEntity : Identifiable {

}

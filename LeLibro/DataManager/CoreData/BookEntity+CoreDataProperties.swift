//
//  BookEntity+CoreDataProperties.swift
//  LeLibro
//
//  Created by Ceyhun Məmmədli on 23.09.25.
//
//

import Foundation
import CoreData


extension BookEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<BookEntity> {
        return NSFetchRequest<BookEntity>(entityName: "BookEntity")
    }

    @NSManaged public var author: String?
    @NSManaged public var coverImage: String?
    @NSManaged public var genre: String?
    @NSManaged public var price: Double
    @NSManaged public var publishedDate: Date?
    @NSManaged public var rating: Double
    @NSManaged public var summary: String?
    @NSManaged public var title: String?
    @NSManaged public var usersFavorite: NSSet?
    @NSManaged public var usersBasket: NSSet?

}

// MARK: Generated accessors for usersFavorite
extension BookEntity {

    @objc(addUsersFavoriteObject:)
    @NSManaged public func addToUsersFavorite(_ value: UserEntity)

    @objc(removeUsersFavoriteObject:)
    @NSManaged public func removeFromUsersFavorite(_ value: UserEntity)

    @objc(addUsersFavorite:)
    @NSManaged public func addToUsersFavorite(_ values: NSSet)

    @objc(removeUsersFavorite:)
    @NSManaged public func removeFromUsersFavorite(_ values: NSSet)

}

// MARK: Generated accessors for usersBasket
extension BookEntity {

    @objc(addUsersBasketObject:)
    @NSManaged public func addToUsersBasket(_ value: UserEntity)

    @objc(removeUsersBasketObject:)
    @NSManaged public func removeFromUsersBasket(_ value: UserEntity)

    @objc(addUsersBasket:)
    @NSManaged public func addToUsersBasket(_ values: NSSet)

    @objc(removeUsersBasket:)
    @NSManaged public func removeFromUsersBasket(_ values: NSSet)

}

extension BookEntity : Identifiable {

}

//
//  UserEntity+CoreDataProperties.swift
//  LeLibro
//
//  Created by Ceyhun Məmmədli on 22.09.25.
//
//

import Foundation
import CoreData


extension UserEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<UserEntity> {
        return NSFetchRequest<UserEntity>(entityName: "UserEntity")
    }

    @NSManaged public var email: String?
    @NSManaged public var password: String?
    @NSManaged public var mobileNumber: String?
    @NSManaged public var address: String?
    @NSManaged public var favorites: NSSet?
    @NSManaged public var basket: NSSet?

}

// MARK: Generated accessors for favorites
extension UserEntity {

    @objc(addFavoritesObject:)
    @NSManaged public func addToFavorites(_ value: BookEntity)

    @objc(removeFavoritesObject:)
    @NSManaged public func removeFromFavorites(_ value: BookEntity)

    @objc(addFavorites:)
    @NSManaged public func addToFavorites(_ values: NSSet)

    @objc(removeFavorites:)
    @NSManaged public func removeFromFavorites(_ values: NSSet)

}

// MARK: Generated accessors for basket
extension UserEntity {

    @objc(addBasketObject:)
    @NSManaged public func addToBasket(_ value: BookEntity)

    @objc(removeBasketObject:)
    @NSManaged public func removeFromBasket(_ value: BookEntity)

    @objc(addBasket:)
    @NSManaged public func addToBasket(_ values: NSSet)

    @objc(removeBasket:)
    @NSManaged public func removeFromBasket(_ values: NSSet)

}

extension UserEntity : Identifiable {

}

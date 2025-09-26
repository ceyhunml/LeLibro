//
//  UserEntity+CoreDataProperties.swift
//  LeLibro
//
//  Created by Ceyhun Məmmədli on 26.09.25.
//
//

import Foundation
import CoreData

extension UserEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<UserEntity> {
        return NSFetchRequest<UserEntity>(entityName: "UserEntity")
    }

    @NSManaged public var address: String?
    @NSManaged public var email: String?
    @NSManaged public var mobileNumber: String?
    @NSManaged public var password: String?
    @NSManaged public var basket: NSObject?
    @NSManaged public var favorites: NSObject?

}

extension UserEntity : Identifiable {
    
    var basketArray: [Int] {
        get { basket as? [Int] ?? [] }
        set { basket = newValue as NSArray }
    }
    
    var favoritesArray: [Int] {
        get { favorites as? [Int] ?? [] }
        set { favorites = newValue as NSArray }
    }
}

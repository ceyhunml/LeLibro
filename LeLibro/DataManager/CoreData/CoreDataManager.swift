//
//  CoreDataManager.swift
//  LeLibro
//
//  Created by Ceyhun Məmmədli on 14.09.25.
//

import Foundation
import CoreData
import UIKit

final class CoreDataManager {
    
    static let shared = CoreDataManager()
    let context: NSManagedObjectContext
    
    private init() {
        let app = UIApplication.shared.delegate as! AppDelegate
        context = app.persistentContainer.viewContext
    }
    
    func saveContext() {
        guard context.hasChanges else { return }
        do { try context.save() }
        catch let error as NSError {
            print(error.localizedDescription)
        }
    }
    
    
    // MARK: - USER FUNCTIONS
    
    func fetchUsers() -> [UserEntity] {
        do {
            return try context.fetch(UserEntity.fetchRequest()) as? [UserEntity] ?? []
        } catch {
            print(error.localizedDescription)
            return []
        }
    }
    
    func registerUser(email: String, password: String) -> UserEntity? {
        let normalizedEmail = email.lowercased().trimmingCharacters(in: .whitespacesAndNewlines)
        
        if fetchUser(byEmail: normalizedEmail) != nil {
            return nil
        }
        
        let user = UserEntity(context: context)
        user.email = normalizedEmail
        user.password = password
        user.mobileNumber = nil
        user.address = nil
        
        saveContext()
        return user
    }
    
    func loginUser(email: String, password: String) -> UserEntity? {
        let normalizedEmail = email.lowercased().trimmingCharacters(in: .whitespacesAndNewlines)
        
        if let user = fetchUser(byEmail: normalizedEmail) {
            return user.password == password ? user : nil
        }
        return nil
    }
    
    func updateUserProfile(user: UserEntity, mobile: String?, address: String?) {
        user.mobileNumber = mobile
        user.address = address
        saveContext()
    }
    
    func fetchUser(byEmail email: String) -> UserEntity? {
        let request: NSFetchRequest<UserEntity> = UserEntity.fetchRequest()
        request.predicate = NSPredicate(format: "email == %@", email)
        request.relationshipKeyPathsForPrefetching = ["favorites", "basket"]
        do {
            return try context.fetch(request).first
        } catch {
            print("Error fetching user by email: \(error)")
            return nil
        }
    }
}

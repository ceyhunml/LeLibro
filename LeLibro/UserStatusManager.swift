//
//  UserManager.swift
//  LeLibro
//
//  Created by Ceyhun Məmmədli on 22.09.25.
//

import Foundation

class UserStatusManager {
    
    static let shared = UserStatusManager()
    
    private init() {}

    var currentUser: UserEntity?
    
    let manager = CoreDataManager.shared

    var isLoggedIn: Bool {
        return currentUser != nil
    }

    func login(user: UserEntity) {
        currentUser = user
        UserDefaults.standard.set(user.email, forKey: "loggedInEmail")
    }

    func logout() {
        currentUser = nil
        UserDefaults.standard.removeObject(forKey: "loggedInEmail")
    }
    
    func restoreUser() {
        if let email = UserDefaults.standard.string(forKey: "loggedInEmail") {
            if let user = manager.fetchUser(byEmail: email) {
                self.currentUser = user
            }
        }
    }
}

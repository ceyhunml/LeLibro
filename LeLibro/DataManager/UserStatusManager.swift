//
//  UserManager.swift
//  LeLibro
//
//  Created by Ceyhun Məmmədli on 22.09.25.
//

import Foundation
import UIKit

class UserStatusManager {
    
    static let shared = UserStatusManager()
    private init() {}

    var currentUser: UserEntity?
    let manager = CoreDataManager.shared
    
    weak var tabBarController: UITabBarController?
    
    var isLoggedIn: Bool {
        return currentUser != nil
    }

    func login(user: UserEntity) {
        currentUser = user
        UserDefaults.standard.set(user.email, forKey: "loggedInEmail")
        updateBadges()
    }

    func logout() {
        currentUser = nil
        UserDefaults.standard.removeObject(forKey: "loggedInEmail")
        updateBadges()
    }
    
    func restoreUser() {
        if let email = UserDefaults.standard.string(forKey: "loggedInEmail"),
           let user = manager.fetchUser(byEmail: email) {
            self.currentUser = user
        }
        updateBadges()
    }
    
    func updateBadges() {
        guard let tabBarController = tabBarController,
              let user = currentUser else {
            tabBarController?.tabBar.items?[2].badgeValue = nil
            tabBarController?.tabBar.items?[3].badgeValue = nil
            return
        }

        let favoritesCount = user.favorites?.count ?? 0
        let basketCount = user.basket?.count ?? 0

        tabBarController.tabBar.items?[2].badgeValue = favoritesCount > 0 ? "\(favoritesCount)" : nil
        tabBarController.tabBar.items?[3].badgeValue = basketCount > 0 ? "\(basketCount)" : nil
    }
}

//
//  AppearanceManager.swift
//  LeLibro
//
//  Created by Ceyhun Məmmədli on 26.09.25.
//

import Foundation

import UIKit

final class AppearanceManager {
    
    static func setupTabBarAppearance() {
        let appearance = UITabBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = .backgroundLayer
        
        let itemAppearance = UITabBarItemAppearance()
        itemAppearance.normal.iconColor = .gray
        itemAppearance.normal.titleTextAttributes = [
            .font: UIFont(name: "Gill Sans", size: 14) ?? UIFont.systemFont(ofSize: 14),
            .foregroundColor: UIColor.gray
        ]
        
        itemAppearance.selected.iconColor = .main
        itemAppearance.selected.titleTextAttributes = [
            .font: UIFont(name: "GillSans-Bold", size: 14) ?? UIFont.systemFont(ofSize: 14, weight: .bold),
            .foregroundColor: UIColor.main
        ]
        
        itemAppearance.normal.badgeBackgroundColor = .main
        itemAppearance.normal.badgeTextAttributes = [.foregroundColor: UIColor.black]
        itemAppearance.selected.badgeBackgroundColor = .main
        itemAppearance.selected.badgeTextAttributes = [.foregroundColor: UIColor.black]
        
        appearance.stackedLayoutAppearance = itemAppearance
        appearance.inlineLayoutAppearance = itemAppearance
        appearance.compactInlineLayoutAppearance = itemAppearance
        
        UITabBar.appearance().standardAppearance = appearance
        UITabBar.appearance().scrollEdgeAppearance = appearance
        
        UITabBarItem.appearance().setTitleTextAttributes(
            [.font: UIFont(name: "Gill Sans", size: 14) ?? UIFont.systemFont(ofSize: 14),
             .foregroundColor: UIColor.gray],
            for: .normal
        )
        
        UITabBarItem.appearance().setTitleTextAttributes(
            [.font: UIFont(name: "GillSans-Bold", size: 14) ?? UIFont.systemFont(ofSize: 14, weight: .bold),
             .foregroundColor: UIColor.main],
            for: .selected
        )
    }
}

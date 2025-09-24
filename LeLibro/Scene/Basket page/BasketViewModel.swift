//
//  BasketViewModel.swift
//  LeLibro
//
//  Created by Ceyhun Məmmədli on 24.09.25.
//

import Foundation
import CoreData

class BasketViewModel {
    
    var basketItems = [BookEntity]()
    
    var quantities: [NSManagedObjectID: Int] = [:]
    
}

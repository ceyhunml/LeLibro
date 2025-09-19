//
//  SearchViewController.swift
//  LeLibro
//
//  Created by Ceyhun Məmmədli on 19.09.25.
//

import UIKit

class SearchViewController: UIViewController {

    var books = [BookEntity]()
    
    let manager = CoreDataManager()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        books = manager.fetchBooks()
    }
    

}


extension 

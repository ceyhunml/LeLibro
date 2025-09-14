//
//  MenuViewController.swift
//  LeLibro
//
//  Created by Ceyhun Məmmədli on 14.09.25.
//

import UIKit
import CoreData

class MenuViewController: UIViewController {

    @IBOutlet weak var collection: UICollectionView!
    
    let manager = CoreDataManager()
    
    var books = [BookEntity]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.titleView = makeNavigationLogoView(imageName: "mainLogo", size: 180)
        books = manager.fetchBooks()
        print(books)
        print(books.count)
    }
    

}


//extension MenuViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
//    
//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        2
//    }
//    
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        let cell = collectionView.
//    }
//    
//}

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
    
    var genres = [GenreSection]()
    
    let manager = CoreDataManager()
    
    var filteredBooks = [BookEntity]()
    
    var books = [BookEntity]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.titleView = makeNavigationLogoView(imageName: "mainLogo", size: 180)
        books = manager.fetchBooks()
        groupBooksByGenre()
        collection.collectionViewLayout = createLayout()
        collection.delegate = self
        collection.dataSource = self
        collection.register(UINib(nibName: "GenreCollectionCell", bundle: nil), forCellWithReuseIdentifier: "GenreCollectionCell")
        collection.register(UINib(nibName: "BooksCollectionCell", bundle: nil), forCellWithReuseIdentifier: "BooksCollectionCell")
        collection.reloadData()
    }
    
    func groupBooksByGenre() {
        genres = Dictionary(grouping: books) { $0.genre ?? "Unknown" }
            .map { GenreSection(genre: $0.key,
                                books: $0.value.sorted { ($0.title ?? "") < ($1.title ?? "") }) }
            .sorted { $0.genre < $1.genre }
    }
    
    func createLayout() -> UICollectionViewLayout {
        return UICollectionViewCompositionalLayout { sectionIndex, environment -> NSCollectionLayoutSection? in
            
            if sectionIndex == 0 {
                
                let itemSize = NSCollectionLayoutSize(widthDimension: .absolute(140),
                                                      heightDimension: .absolute(40))
                let item = NSCollectionLayoutItem(layoutSize: itemSize)
                
                let groupSize = NSCollectionLayoutSize(widthDimension: .absolute(140),
                                                       heightDimension: .absolute(40))
                let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
                group.interItemSpacing = .fixed(20)
                
                let section = NSCollectionLayoutSection(group: group)
                section.orthogonalScrollingBehavior = .continuous
                section.contentInsets = NSDirectionalEdgeInsets(top: 12, leading: 16, bottom: 12, trailing: 16)
                return section
                
            } else {
                let itemSize = NSCollectionLayoutSize(
                    widthDimension: .fractionalWidth(0.5),
                    heightDimension: .absolute(230)
                )
                let item = NSCollectionLayoutItem(layoutSize: itemSize)
                item.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 8, bottom: 0, trailing: 8)
                
                let groupSize = NSCollectionLayoutSize(
                    widthDimension: .fractionalWidth(1.0),
                    heightDimension: .absolute(230)
                )
                let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item, item])
                
                let section = NSCollectionLayoutSection(group: group)
                section.interGroupSpacing = 16
                section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 16, bottom: 16, trailing: 16)
                return section
            }
        }
    }
}


extension MenuViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 0 {
            return genres.count
        } else {
            return filteredBooks.isEmpty ? books.count : filteredBooks.count
        }
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.section == 0 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "GenreCollectionCell", for: indexPath) as! GenreCollectionCell
            cell.genreLabel.text = genres[indexPath.item].genre
            return cell
       } else {
           let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "BooksCollectionCell", for: indexPath) as! BooksCollectionCell
           cell.layer.cornerRadius = 12
           cell.priceLabel.text = "\(String(books[indexPath.row].price))$"
           cell.bookCover.image = UIImage(named: books[indexPath.row].coverImage ?? "")
           cell.bookNameLabel.text = books[indexPath.row].title
           cell.bookRating.text = String(books[indexPath.row].rating)
           return cell
       }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.section == 0 {
            
            let selectedGenre = genres[indexPath.item].genre
            filteredBooks = books.filter { $0.genre == selectedGenre }
            
            collectionView.reloadSections(IndexSet(integer: 1))
        }
    }
}

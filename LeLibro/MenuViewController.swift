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
    
    var selectedGenre: String?
    
    let manager = CoreDataManager()
    
    var filteredBooks = [BookEntity]()
    
    var featuredBooks = [FeaturedBooks]()
    
    var books = [BookEntity]()
    
    func showBookDetail(item: Any) {
        print(item)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.titleView = makeNavigationLogoView(imageName: "mainLogo", size: 140)
        books = manager.fetchBooks()
        groupBooksByGenre()
        featuredBooks = [
            FeaturedBooks(title: "The Fellowship of the Ring", bannerImage: "fellowship_banner"),
            FeaturedBooks(title: "The Two Towers", bannerImage: "two_towers_banner"),
            FeaturedBooks(title: "The Return of the King", bannerImage: "return_king_banner")
        ]
        collection.collectionViewLayout = createLayout()
        collection.delegate = self
        collection.dataSource = self
        collection.register(UINib(nibName: "GenreCollectionCell", bundle: nil), forCellWithReuseIdentifier: "GenreCollectionCell")
        collection.register(UINib(nibName: "BooksCollectionCell", bundle: nil), forCellWithReuseIdentifier: "BooksCollectionCell")
        collection.register(UINib(nibName: "FeaturedBooksCell", bundle: nil),
                            forCellWithReuseIdentifier: "FeaturedBooksCell")
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
                let itemSize = NSCollectionLayoutSize(
                    widthDimension: .estimated(80),
                    heightDimension: .absolute(34)
                )
                let item = NSCollectionLayoutItem(layoutSize: itemSize)
                
                let groupSize = NSCollectionLayoutSize(
                    widthDimension: .estimated(80),
                    heightDimension: .absolute(44)
                )
                let group = NSCollectionLayoutGroup.horizontal(
                    layoutSize: groupSize,
                    subitems: [item]
                )
                group.interItemSpacing = .fixed(12)
                
                let section = NSCollectionLayoutSection(group: group)
                section.orthogonalScrollingBehavior = .continuous
                section.interGroupSpacing = 12
                section.contentInsets = NSDirectionalEdgeInsets(top: 18, leading: 16, bottom: 12, trailing: 16)
                return section
                
            } else if sectionIndex == 1 {
                let itemSize = NSCollectionLayoutSize(
                    widthDimension: .fractionalWidth(0.9),
                    heightDimension: .absolute(220)
                )
                let item = NSCollectionLayoutItem(layoutSize: itemSize)
                
                let groupSize = itemSize
                let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
                
                let section = NSCollectionLayoutSection(group: group)
                section.orthogonalScrollingBehavior = .groupPagingCentered
                section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 16, trailing: 0)
                return section
            } else {
                let itemSize = NSCollectionLayoutSize(
                    widthDimension: .fractionalWidth(0.5),
                    heightDimension: .absolute(360)
                )
                let item = NSCollectionLayoutItem(layoutSize: itemSize)
                item.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 8, bottom: 0, trailing: 8)
                
                let groupSize = NSCollectionLayoutSize(
                    widthDimension: .fractionalWidth(1.0),
                    heightDimension: .absolute(360)
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
        return 3
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch section {
            case 0:
                return genres.count
            case 1:
                return featuredBooks.count
            case 2:
                return filteredBooks.isEmpty ? books.count : filteredBooks.count
            default:
                return 0
            }
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch indexPath.section {
        case 0:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "GenreCollectionCell", for: indexPath) as! GenreCollectionCell
            let genre = genres[indexPath.item].genre
            cell.genreLabel.text = genre
            cell.contentView.layer.cornerRadius = 12
            return cell
            
        case 1:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FeaturedBooksCell", for: indexPath) as! FeaturedBooksCell
            let item = featuredBooks[indexPath.item]
            cell.coverImage.image = UIImage(named: item.bannerImage)
            return cell
            
        case 2:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "BooksCollectionCell", for: indexPath) as! BooksCollectionCell
            cell.layer.cornerRadius = 12
            let book = filteredBooks.isEmpty ? books[indexPath.row] : filteredBooks[indexPath.row]
            cell.priceLabel.text = "\(String(book.price))$"
            cell.bookCover.image = UIImage(named: book.coverImage ?? "")
            cell.bookNameLabel.text = book.title
            cell.bookRating.text = String(book.rating)
            return cell
            
        default:
            return UICollectionViewCell()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch indexPath.section {
        case 0:
            let selectedGenre = genres[indexPath.item].genre
            filteredBooks = books.filter { $0.genre == selectedGenre }
            collectionView.reloadSections(IndexSet(integer: 2))
            
        case 1:
            let item = featuredBooks[indexPath.item]
            if let book = books.first(where: { $0.title == item.title }) {
                showBookDetail(item: book)
            }
            
        case 2:
            let book = filteredBooks.isEmpty ? books[indexPath.row] : filteredBooks[indexPath.row]
            showBookDetail(item: book)
            
        default: break
        }
    }
}

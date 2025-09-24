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
    
    let viewModel = MenuViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    func setup() {
        navigationItem.titleView = makeNavigationLogoView(imageName: "mainLogo", size: 140)
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = .backgroundLayer
        appearance.shadowColor = .clear
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
        viewModel.books = viewModel.manager.fetchBooks()
        viewModel.groupBooksByGenre()
        collection.collectionViewLayout = createLayout()
        collection.register(UINib(nibName: "GenreCollectionCell", bundle: nil), forCellWithReuseIdentifier: "GenreCollectionCell")
        collection.register(UINib(nibName: "BooksCollectionCell", bundle: nil), forCellWithReuseIdentifier: "BooksCollectionCell")
        collection.register(UINib(nibName: "FeaturedBooksCell", bundle: nil),
                            forCellWithReuseIdentifier: "FeaturedBooksCell")
        collection.delegate = self
        collection.dataSource = self
        collection.reloadData()
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
                
                let itemWidth = environment.container.effectiveContentSize.width * 0.9
                let itemSize = NSCollectionLayoutSize(
                    widthDimension: .absolute(itemWidth),
                    heightDimension: .absolute(220)
                )
                let item = NSCollectionLayoutItem(layoutSize: itemSize)
                
                let groupSize = NSCollectionLayoutSize(
                    widthDimension: .absolute(itemWidth),
                    heightDimension: .absolute(220)
                )
                let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
                
                let section = NSCollectionLayoutSection(group: group)
                section.orthogonalScrollingBehavior = .groupPagingCentered
                section.interGroupSpacing = 10
                
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
        3
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch section {
        case 0:
            return viewModel.genres.count
        case 1:
            return viewModel.featuredBooks.count
        case 2:
            return viewModel.filteredBooks.isEmpty ? viewModel.books.count : viewModel.filteredBooks.count
        default:
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch indexPath.section {
        case 0:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "GenreCollectionCell", for: indexPath) as! GenreCollectionCell
            let genre = viewModel.genres[indexPath.item].genre
            cell.configure(genreName: genre)
            cell.contentView.layer.cornerRadius = 12
            return cell
            
        case 1:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FeaturedBooksCell", for: indexPath) as! FeaturedBooksCell
            let item = viewModel.featuredBooks[indexPath.item]
            cell.configure(coverImage: item.bannerImage)
            return cell
            
        case 2:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "BooksCollectionCell", for: indexPath) as! BooksCollectionCell
            cell.layer.cornerRadius = 12
            let book = viewModel.filteredBooks.isEmpty ? viewModel.books[indexPath.row] : viewModel.filteredBooks[indexPath.row]
            
            cell.configure(bookName: book.title ?? "",
                           bookCover: book.coverImage ?? "",
                           bookPrice: "\(String(book.price))$",
                           bookRating: String(book.rating),
                           book: book,
                           currentUser: UserStatusManager.shared.currentUser)
            
            cell.onFavoriteToggle = { book in
                guard let user = UserStatusManager.shared.currentUser else { return }
                self.viewModel.toggleFavorite(for: book, currentUser: user)
                cell.updateFavoriteIcon(for: book, currentUser: user)
            }
            
            cell.onBasketToggle = { book in
                guard let user = UserStatusManager.shared.currentUser else { return }
                self.viewModel.toggleBasket(for: book, currentUser: user)
                cell.updateBasketIcon(for: book, currentUser: user)
            }
            
            return cell
            
        default:
            return UICollectionViewCell()
            
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch indexPath.section {
        case 0:
            let selectedGenre = viewModel.genres[indexPath.item].genre
            viewModel.filteredBooks = viewModel.books.filter { $0.genre == selectedGenre }
            collectionView.reloadSections(IndexSet(integer: 2))
            
        case 1:
            let item = viewModel.featuredBooks[indexPath.item]
            if let book = viewModel.books.first(where: { $0.title == item.title }) {
                let controller = storyboard?.instantiateViewController(withIdentifier: "BookViewController") as! BookViewController
                controller.book = book
                navigationController?.show(controller, sender: nil)
            }
            
        case 2:
            let book = viewModel.filteredBooks.isEmpty ? viewModel.books[indexPath.row] : viewModel.filteredBooks[indexPath.row]
            let controller = storyboard?.instantiateViewController(withIdentifier: "BookViewController") as! BookViewController
            controller.book = book
            navigationController?.show(controller, sender: nil)
            
        default: break
            
        }
    }
}

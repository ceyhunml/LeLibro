//
//  BasketViewController.swift
//  LeLibro
//
//  Created by Ceyhun Məmmədli on 24.09.25.
//

import UIKit
import CoreData

class BasketViewController: UIViewController {
    
    @IBOutlet weak var table: UITableView!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var orderButton: UIButton!
    
    let viewModel = BasketViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        orderButton.applyGillSansFont(title: "Order", size: 20)
        navigationItem.titleView = makeNavigationLogoView(imageName: "mainLogo", size: 140)
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = UIColor.backgroundLayer
        appearance.shadowColor = UIColor.clear
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
        table.register(UINib(nibName: "BasketTableViewCell", bundle: nil), forCellReuseIdentifier: "BasketTableViewCell")
        table.dataSource = self
        table.delegate = self
        reloadBasket()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        reloadBasket()
    }
    
    func updateTotalPrice() {
        var total = 0.0
        for book in viewModel.basketItems {
            let qty = viewModel.quantities[book.objectID] ?? 1
            total += book.price * Double(qty)
        }
        priceLabel.text = "Total: \(String(format: "%.2f", total))$"
    }
    
    @IBAction func orderButtonPressed(_ sender: Any) {
    }
    
    private func reloadBasket() {
        if let user = UserStatusManager.shared.currentUser,
           let basket = user.basket as? Set<BookEntity> {
            viewModel.basketItems = Array(basket).sorted { ($0.title ?? "") < ($1.title ?? "") }
        } else {
            viewModel.basketItems = []
        }
        table.reloadData()
        
        if viewModel.basketItems.isEmpty {
            let label = UILabel()
            label.text = "Basket is empty"
            label.font = UIFont(name: "Gill Sans", size: 28)
            label.textColor = .main
            label.textAlignment = .center
            table.backgroundView = label
            orderButton.isEnabled = false
            orderButton.alpha = 0.5
            priceLabel.text = ""
        } else {
            table.backgroundView = nil
            orderButton.isEnabled = true
            orderButton.alpha = 1.0
            updateTotalPrice()
        }
    }
}

extension BasketViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.basketItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "BasketTableViewCell", for: indexPath) as! BasketTableViewCell
        let book = viewModel.basketItems[indexPath.row]
        let quantity = viewModel.quantities[book.objectID] ?? 1
        
        cell.configure(book: book, quantity: quantity)
        
        cell.quantityChanged = { newQty in
            self.viewModel.quantities[book.objectID] = newQty
            self.updateTotalPrice()
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let book = viewModel.basketItems[indexPath.row]
        let controller = storyboard?.instantiateViewController(withIdentifier: "BookViewController") as! BookViewController
        controller.book = book
        navigationController?.show(controller, sender: nil)
    }
    
    func tableView(_ tableView: UITableView,
                   commit editingStyle: UITableViewCell.EditingStyle,
                   forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let book = viewModel.basketItems[indexPath.row]
            
            if let user = UserStatusManager.shared.currentUser {
                user.removeFromBasket(book)
                CoreDataManager.shared.saveContext()
            }
            
            viewModel.basketItems.remove(at: indexPath.row)
            viewModel.quantities.removeValue(forKey: book.objectID)
            
            tableView.deleteRows(at: [indexPath], with: .automatic)
            reloadBasket()
            UserStatusManager.shared.updateBadges()
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        100
    }
}

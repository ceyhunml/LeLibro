//
//  BasketViewController.swift
//  LeLibro
//
//  Created by Ceyhun Məmmədli on 24.09.25.
//

import UIKit
import CoreData

class BasketViewController: BaseViewController {
    
    @IBOutlet private weak var table: UITableView!
    @IBOutlet private weak var priceLabel: UILabel!
    @IBOutlet private weak var orderButton: UIButton!
    
    let viewModel = BasketViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    private func setup() {
        orderButton.applyGillSansFont(title: "Order", size: 20)
        table.register(UINib(nibName: "BasketTableViewCell", bundle: nil), forCellReuseIdentifier: "BasketTableViewCell")
        table.dataSource = self
        table.delegate = self
        reloadBasket()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        reloadBasket()
    }
    
    private func updateTotalPrice() {
        var total = 0.0
        for book in viewModel.basketItems {
            let qty = viewModel.quantities[book.id] ?? 1
            total += book.price * Double(qty)
        }
        priceLabel.text = "Total: \(String(format: "%.2f", total))$"
    }
    
    @IBAction private func orderButtonPressed(_ sender: Any) {
        guard let user = UserStatusManager.shared.currentUser else { return }
        
        let address = user.address ?? ""
        let number = user.mobileNumber ?? ""
        
        if address.isEmpty || number.isEmpty {
            alertForEmptyFields()
            return
        }
        user.basketArray = []
        CoreDataManager.shared.saveContext()
        alertFor(title: "Thank You!", message: "Your order has been placed. We will contact you soon.")
        reloadBasket()
        UserStatusManager.shared.updateBadges()
    }

    private func reloadBasket() {
        guard let user = UserStatusManager.shared.currentUser else {
            viewModel.basketItems = []
            table.reloadData()
            return
        }
        let basketIDs = user.basketArray
        let allBooks = BookDataManager.shared.books
        viewModel.basketItems = allBooks.filter { basketIDs.contains($0.id) }

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
        let quantity = viewModel.quantities[book.id] ?? 1
        
        cell.configure(book: book, quantity: quantity)
        
        cell.quantityChanged = { newQty in
            self.viewModel.quantities[book.id] = newQty
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
                if let index = user.basketArray.firstIndex(of: book.id) {
                    user.basketArray.remove(at: index)
                    CoreDataManager.shared.saveContext()
                    UserStatusManager.shared.updateBadges()
                }
            }
            
            viewModel.basketItems.remove(at: indexPath.row)
            viewModel.quantities.removeValue(forKey: book.id)
            
            tableView.deleteRows(at: [indexPath], with: .automatic)
            reloadBasket()
            UserStatusManager.shared.updateBadges()
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        100
    }
}

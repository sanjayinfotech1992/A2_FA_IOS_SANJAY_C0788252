//
//  ViewController.swift
//  Final assignment
//
//  Created by Sanjay Prajapati (c0788252)
//  Copyright © 2021 sanjay.H. All rights reserved.
//

import UIKit

class ProductListViewController: UIViewController {

    @IBOutlet weak var tblView: UITableView!
    @IBOutlet weak var txtSearch: UITextField!

    var products: [Product] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        tblView.tableFooterView = UIView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.txtSearch.text = ""
        self.fetchProductsFromDB()
    }
    
    
    func fetchProductsFromDB()  {
        if let product = DataBaseManager().readAllProducts() {
            self.products.removeAll()
            self.products.append(contentsOf: product)
            tblView.reloadData()
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        self.txtSearch.resignFirstResponder()
        if let controller = segue.destination as? ProductDetailViewController {
            controller.product = sender as? Product
        }
    }
}

extension ProductListViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        products.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let labelItem = cell.viewWithTag(10) as? UILabel// tage of label is 10
        let product = products[indexPath.row]
        labelItem?.text = product.productName
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let product = products[indexPath.row]
        self.performSegue(withIdentifier: "productListToDetail", sender: product)
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let product = products[indexPath.row]
            products.remove(at: indexPath.row)
            DataBaseManager().deleteProduct(product)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }

}

extension ProductListViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField,
                   shouldChangeCharactersIn range: NSRange,
                   replacementString string: String) -> Bool {
        if let text = textField.text, let textRange = Range(range, in: text) {
            let updatedText = text.replacingCharacters(in: textRange, with: string).lowercased()
            
            if let product = DataBaseManager().readAllProducts() {
                if updatedText.isEmpty {
                    self.products.removeAll()
                    self.products.append(contentsOf: product)
                }
                else {
                    let items = product.filter({($0.productName!.lowercased().contains(updatedText))})
                    self.products.removeAll()
                    self.products.append(contentsOf: items)
                }
                self.tblView.reloadData()
            }
        }
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }

}

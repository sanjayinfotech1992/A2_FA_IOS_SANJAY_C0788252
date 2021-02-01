//
//  ProviderListViewController.swift
//  Final assignment
//
//  Created by Sanjay Prajapati (c0788252)
//  Copyright © 2021 Sanjay.H. All rights reserved.
//

import UIKit

class ProviderListViewController: UIViewController {
    @IBOutlet weak var tblView: UITableView!
    var products: [Product] = []
    var providers:[String : Int]?


    override func viewDidLoad() {
        super.viewDidLoad()
        self.fetchProductsFromDB()
    }
    
    func fetchProductsFromDB()  {
        if let product = DataBaseManager().readAllProducts() {
            self.products.removeAll()
            self.products.append(contentsOf: product)
            let grouped = Dictionary(grouping: products.map({$0.productProvider ?? ""}), by: { $0 }).mapValues { items in items.count }
            providers = grouped
            tblView.reloadData()
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let controller = segue.destination as? ProviderProductListViewController {
            controller.products = sender as? [Product]
        }
    }
}

extension ProviderListViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        providers?.keys.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let labelItem = cell.viewWithTag(10) as? UILabel
        let labelCount = cell.viewWithTag(11) as? UILabel
        if let providers = providers {
            let keys = Array(providers.keys)
            let provider = keys[indexPath.row]
            labelItem?.text = provider
            labelCount?.text = String(providers[provider] ?? 1)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let providers = providers {
            let keys = Array(providers.keys)
            let provider = keys[indexPath.row]
            let providerProducts = products.filter({$0.productProvider == provider})
            self.performSegue(withIdentifier: "providerListToProduct", sender: providerProducts)

        }
    }

}

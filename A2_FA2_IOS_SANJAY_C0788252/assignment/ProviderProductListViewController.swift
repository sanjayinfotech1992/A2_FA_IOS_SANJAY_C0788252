//
//  ProviderProviderProductListViewController.swift
//  Final assignment
//
//  Created by Sanjay Prajapati (c0788252)
//  Copyright © 2021 Sanjay.H. All rights reserved.
//

import UIKit


class ProviderProductListViewController: UIViewController {

    @IBOutlet weak var tblView: UITableView!
    var products: [Product]?

    override func viewDidLoad() {
        super.viewDidLoad()
        tblView.tableFooterView = UIView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let controller = segue.destination as? ProductDetailViewController {
            controller.product = sender as? Product
        }
    }
}

extension ProviderProductListViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        products?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let labelItem = cell.viewWithTag(10) as? UILabel// tage of label is 10
        let product = products?[indexPath.row]
        labelItem?.text = product?.productName
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let product = products?[indexPath.row]
        self.performSegue(withIdentifier: "providerProductToDetail", sender: product)
    }

}


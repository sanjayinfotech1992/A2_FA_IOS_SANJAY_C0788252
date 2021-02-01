//
//  ProductDetailViewController.swift
//  Final assignment
//
//  Created by Sanjay Prajapati (c0788252)
//  Copyright © 2021 Sanjay.H. All rights reserved.
//

import UIKit

class ProductDetailViewController: UIViewController, AddOrEditDelegate {
    
    @IBOutlet var labelItems: [UILabel]!
    
    var product: Product?

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.updateItems()
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let controller = segue.destination as? AddOrEditViewController {
            controller.product = product
            controller.delegate = self
        }
    }
    
    func updateProductItems(_ product: Product?) {
        self.product = product
    }
    
    func updateItems()  {
        labelItems[0].text = "Product ID: " + String(product?.productId ?? 0)
        labelItems[1].text = "Product Name: " + (product?.productName ?? "")
        labelItems[2].text = "Product Price: " + String(product?.productPrice ?? 0)
        labelItems[3].text = "Product Provider: " + (product?.productProvider ?? "")
        labelItems[4].text = "Product Description: " + (product?.productDescription ?? "")
    }
}

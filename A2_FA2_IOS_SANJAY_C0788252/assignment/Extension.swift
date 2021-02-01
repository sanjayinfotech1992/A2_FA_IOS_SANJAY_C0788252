//
//  Extension.swift
//  Final assignment
//
//  Created by Sanjay Prajapati (c0788252)
//  Copyright © 2021 sanjay.H. All rights reserved.
//

import UIKit

extension UIView {
    
    @IBInspectable
    var cornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
        }
    }
    
    @IBInspectable
    var borderWidth: CGFloat {
        get {
            return layer.borderWidth
        }
        set {
            layer.borderWidth = newValue
        }
    }
    
    @IBInspectable
    var borderColor: UIColor? {
        get {
            if let color = layer.borderColor {
                return UIColor(cgColor: color)
            }
            return nil
        }
        set {
            if let color = newValue {
                layer.borderColor = color.cgColor
            } else {
                layer.borderColor = nil
            }
        }
    }    
}

extension UIViewController {
    func showAlert(title: String = "", message: String, options: [String]? = nil, completion: ((Int) -> Void)?) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        if let options = options {
            for (index, option) in options.enumerated() {
                alertController.addAction(UIAlertAction(title: option, style: .default, handler: { (action) in
                    completion?(index)
                }))
            }
        }
        self.present(alertController, animated: true, completion: nil)
    }
}

//
//  ViewController+Extenstions.swift
//  
//
//  Created by Kyle Lei on 2021/12/26.
//

import UIKit

extension UIViewController {
    
    func spin (spinner: UIActivityIndicatorView) {
        spinner.startAnimating()
        
        Timer.scheduledTimer(withTimeInterval: 2, repeats: false) { _ in
            spinner.stopAnimating()
            spinner.hidesWhenStopped = true
        }
    }
}

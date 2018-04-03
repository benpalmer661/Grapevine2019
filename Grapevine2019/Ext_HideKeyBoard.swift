//
//  Ext_HideKeyBoard.swift
//  Grapevine2018
//
//  Created by Ben Palmer on 31/12/17.
//  Copyright © 2017 Ben Palmer. All rights reserved.
//

import Foundation
import UIKit


extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    func dismissKeyboard() {
        view.endEditing(true)
    }
}




//// Put this piece of code anywhere you like
//extension UIViewController {
//    func hideKeyboardWhenTappedAround() {
//        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
//        tap.cancelsTouchesInView = false
//        view.addGestureRecognizer(tap)
//    }
//    
//    func dismissKeyboard() {
//        view.endEditing(true)
//    }
//}
//Now in every UIViewController, all you have to do is call this function:
//
//override func viewDidLoad() {
//    super.viewDidLoad()
//    self.hideKeyboardWhenTappedAround()
//}



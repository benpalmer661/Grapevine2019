//
//  Ext_statusBar.swift
//  Grapevine2018
//
//  Created by Ben Palmer on 2/1/18.
//  Copyright © 2018 Ben Palmer. All rights reserved.
//

import Foundation
import UIKit


extension UIApplication {
    var statusBarView: UIView? {
        return value(forKey: "statusBar") as? UIView
    }
}



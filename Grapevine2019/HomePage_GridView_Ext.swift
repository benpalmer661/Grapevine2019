//
//  HomePage_GridView_Ext.swift
//  Grapevine 2017
//
//  Created by Ben Palmer on 28/11/17.
//  Copyright © 2017 Ben Palmer. All rights reserved.
//

import Foundation
import UIKit
import Firebase
import FirebaseAuth
import CoreLocation


extension HomePage{
    
    
    
   
    func didChangeToGridView() {
        isGridView = true
        
        collectionView?.reloadData()
    }
    
    
    func didChangeToListView() {
        
        isGridView = false
        collectionView?.reloadData()
    }
    

    
    
}

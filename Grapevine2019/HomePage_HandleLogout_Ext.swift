//
//  HomePage_HandleLogout_Ext.swift
//  Grapevine 2017
//
//  Created by Ben Palmer on 28/11/17.
//  Copyright © 2017 Ben Palmer. All rights reserved.
//

import Foundation


import Foundation
import UIKit
import Firebase
import FirebaseAuth
import CoreLocation


extension HomePage{
    
    
    func handleLogout() {
        
        guard let uid = Auth.auth().currentUser?.uid else { return }
        
        let db = Firestore.firestore()
        
        
        db.collection("Users").document(uid).setData(["Online Offline Status": "Offline","Offline" : true, "Online" : false ], options: SetOptions.merge())
        
        
       
        
        do {
            print("attempting to log out user")
            try Auth.auth().signOut()
        } catch let logoutError {
            print("logout error found\(logoutError)")
        }
        
        
        let signInVC = SignInVC()
        signInVC.HomePage = self
        
//        let storyboard = UIStoryboard(name: "Main", bundle: nil) //"Main" - name of the storyboard
//       
//        let loginViewController = storyboard.instantiateViewController(withIdentifier: "loginVC") as! SignInVC
//
//        self.present(loginViewController, animated: true, completion: nil)
        
        
         self.present(signInVC, animated: true, completion: nil)
        
    }
    
    

    
    
    
    
}

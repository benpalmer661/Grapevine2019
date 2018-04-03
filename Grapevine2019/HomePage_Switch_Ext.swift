//
//  HomePage_Switch_Ext.swift
//  Grapevine 2017
//
//  Created by Ben Palmer on 28/11/17.
//  Copyright © 2017 Ben Palmer. All rights reserved.
//


import UIKit
import Firebase
import FirebaseAuth
import CoreLocation


extension HomePage {
    
    
    
    func setupSwitch() {
        
        let mySwitch = UISwitch()
        mySwitch.center = view.center
        mySwitch.setOn(false, animated: false)
        
        mySwitch.addTarget(self, action: #selector(switchValueDidChange(sender:)), for: UIControlEvents.valueChanged)
        self.navigationItem.leftBarButtonItem = UIBarButtonItem.init(customView: mySwitch)
        
        
        guard let onlineStatus = self.currentUser?.onlineOfflineStatus else { return }
        
     
        if onlineStatus == "Online" {
            print("user is online")
           
            mySwitch.setOn(true, animated: true)
        } else {
            print("user is offline")
            
            mySwitch.setOn(false, animated: true)
            
        }
        
    }
    
    
    
    
    
    
    func switchValueDidChange(sender:UISwitch!)
    {
        
        guard let uid = Auth.auth().currentUser?.uid else { return }
        
      
        if sender.isOn {
            print("online")
            
            Firestore.firestore().collection("Users").document(uid).setData(["Online Offline Status": "Online", "Online" : true, "Offline" : false], options: SetOptions.merge())
            
            
            
            
            
        } else{
            
          
            Firestore.firestore().collection("Users").document(uid).setData(["Online Offline Status": "Offline","Offline" : true, "Online" : false ], options: SetOptions.merge())
            
            
        }
        
        firestoreFetchCurrentUser()
        
    }

    
    
    
    
    
}

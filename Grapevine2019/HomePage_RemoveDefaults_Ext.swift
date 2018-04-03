//
//  HomePage_RemoveDefaults_Ext.swift
//  Grapevine2019
//
//  Created by Ben Palmer on 16/1/18.
//  Copyright © 2018 Ben Palmer. All rights reserved.
//

import Foundation
import UIKit
import Firebase
import FirebaseAuth
import CoreLocation


extension HomePage {
    
    func removeAndPrintOutDefaults(){
    
        
        
//        defaults contain:
//        
//        accountTypePreference
//        searchLocation
//        connectionStatusPreference
//        genderTypePreference

  
 //code to remove defaults for text purposes

//  let prefs = UserDefaults.standard
//        prefs.removeObject(forKey:"genderTypePreference")
//     prefs.removeObject(forKey:"accountTypePreference")
//    prefs.removeObject(forKey:"distancePreference")
//        
//        
//        prefs.removeObject(forKey:"searchLocation")
//        
//        prefs.removeObject(forKey:"LowerAgePreference")
//        
//        prefs.removeObject(forKey:"HigherAgePreference")
//        
//        prefs.removeObject(forKey:"Location")
//        
//        prefs.removeObject(forKey:"connectionStatusPreference")
//        
//        
//        
//        SetDefaultsForUserSearchRefinementsIfNil()
//        

//code below prints out the key: Value Pairs for user defaults.

for (key, value) in UserDefaults.standard.dictionaryRepresentation() {
    print("\(key) = \(value) \n")
    
        }
        
    }
    
}

//
//  User2.swift
//  Grapevine 2017
//
//  Created by Ben Palmer on 30/9/17.
//  Copyright © 2017 Ben Palmer. All rights reserved.
//

import Foundation
import UIKit



struct User2 {
    let DisplayName: String
    let profileImageURL: String
    let accountTypeImageUrl: String
    let subtitle: String
    let uid: String
    let latitude: String
    let longitude: String
    let distanceFrom: String
    var toId: String?
    var fromId: String?
    var id: String?
   
    var email: String?
    var accountType: String?
    var onlineOfflineStatus: String?
    var contactNumber: String?
    var gender: String?
    var age: Int?
    var username: String?
    var actualLatitude: String?
    var actualLongitude: String?
    var LastTimeActualLocationWasUpdated: String?
    var tagWords: String?
    var Location: String?
    
    init(uid: String,distanceFrom: String, dictionary: [String: Any]) {
        
        
        
        self.Location = dictionary["Location"] as? String ?? "Location Unknown"
        
        
          self.onlineOfflineStatus = dictionary["Online Offline Status"] as? String ?? ""
        
        
        self.tagWords = dictionary["Tag Words"] as? String ?? ""
        
        self.actualLatitude = dictionary["Actual Latitude"] as? String ?? "-34.9286600"
        
        
        self.actualLongitude = dictionary["Actual Longitude"] as? String ?? "138.5986300"
        
        
self.LastTimeActualLocationWasUpdated = dictionary["Last Time Actual Location Was Updated"] as? String ?? "567345"
        
        
        
        self.username = dictionary["Username"] as? String ?? "Not Yet Selected"
        self.gender = dictionary["Gender"] as? String ?? "NA"

        self.age = dictionary["Age"] as? Int ?? 25
        self.contactNumber = dictionary["Contact Number"] as? String ?? "Ph:"
        
        self.onlineOfflineStatus = dictionary["Online Offline Status"] as? String
        
        self.accountType = dictionary["Account Type"] as? String 
        self.DisplayName = dictionary["Display Name"] as? String ?? "Not Yet Selected"
        self.email = dictionary["Email"] as? String ?? "Not Yet Selected"
        self.id = dictionary["UID"] as? String ?? "Not Yet Selected"
        
        self.distanceFrom = distanceFrom as? String ?? "Not Yet Selected"
    
        
        self.profileImageURL = dictionary["profileImageUrl"]  as? String ?? ""
        self.accountTypeImageUrl = dictionary["AccountTypeImageURL"] as? String ?? ""
        self.subtitle = dictionary["Subtitle"] as? String ?? "Not Yet Selected"
        self.uid = dictionary["UID"] as? String ?? ""
        self.longitude = dictionary["Longitude"] as? String ?? ""
        self.latitude = dictionary["Latitude"] as? String ?? ""
    }
}







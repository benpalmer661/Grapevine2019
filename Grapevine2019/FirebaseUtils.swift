//
//  FirebaseUtils.swift
//  Grapevine 2017
//
//  Created by Ben Palmer on 29/9/17.
//  Copyright © 2017 Ben Palmer. All rights reserved.
//


import Foundation
import UIKit
import Firebase
import CoreLocation
import UIKit
import FirebaseDatabase
import FirebaseAuth
import FirebaseCore
import FirebaseStorage
import FirebaseInstanceID

extension Database {
    
    

   
    
 static func firestorefetchUserWithUID(uid: String, completion:@escaping (User2) -> ()) {
        
        print("fire store fetch user with uid called")
        
        let defaults = UserDefaults.standard
        
        
        
        let db = Firestore.firestore()
        
        let docRef = db.collection("Users").document(uid)
        
        docRef.getDocument { (document, error) in
            
            
            if (document?.exists)! {
                
            
            
            if let document = document {
                
                
                
                
                print("kkkkkkkkkk Document data: \(document.data())")
         

     
                guard let dictionary = document.data() as? [String: Any] else {
                    
                    print("error 1245")
                    return }
                
                
                guard let searchingFromLatitude = defaults.string(forKey: "SearchingFromLatitude")
                    else {
                        print("error 1234324245")
                        return }
                guard let searchingFromLongitude = defaults.string(forKey: "SearchingFromLongitude") else {
                    print("error 18835")
                    return }
                guard let DoubleLatitude = Double(searchingFromLatitude) else {
                    return }
                guard let DoubleLongitude = Double(searchingFromLongitude) else {
                    return }
                
                
                
                //////////////Start of distanceFrom code///////////////////////////////////
                
                //get user's actual long and latitude to later compare against current users searching from long and lat
                guard let latitude = dictionary["Actual Latitude"] as? String else
                {
                    
                     print("error 87518835")
                    return }
                guard let longitude = dictionary["Actual Longitude"] as? String else {
                    print("error 8757835")
                    return }
                guard let latDouble = Double(latitude) else {
                    return }
                guard let longDouble = Double(longitude) else {
                    return }
                let usersActualLocation = CLLocation(latitude:latDouble, longitude: longDouble)
                
                
                let Current_Users_Searching_From_Location2 = CLLocation(latitude:DoubleLatitude, longitude: DoubleLongitude)
                let theDistanceInMeters = Current_Users_Searching_From_Location2.distance(from: usersActualLocation)
                let distanceInKms = Int(theDistanceInMeters/1000)
                
                /////////////////end of distanceFrom code///////////////////////////////////
                
                
               
            
            let user = User2(uid: uid, distanceFrom: "\(distanceInKms)", dictionary: dictionary)
                
                 completion(user)
            
            } else {
                print("Document does not exist")
            }
        }
    }

    }
    
    
    }










extension Database {
    static func fetchUserWithUID(uid: String, completion:@escaping (User2) -> ()) {
        
        Database.database().reference().child("Users").child(uid).observeSingleEvent(of: .value, with: { (snapshot) in
            
            guard let userDictionary = snapshot.value as? [String: Any] else { return }
            
            
            
            let user = User2(uid: uid, distanceFrom: "any", dictionary: userDictionary)
            
            
            completion(user)
            
            
        }) { (err) in
            print("Failed to fetch user for posts:", err)
        }
        
        
    }
}


extension Database {
    static func fetchUserWithUID2(uid: String, completion:@escaping (User2) -> ()) {
        
        Database.database().reference().child("Users").child(uid).observeSingleEvent(of: .value, with: { (snapshot) in
            
            guard let userDictionary = snapshot.value as? [String: Any] else { return }
            
            
            let user = User2(uid: "any", distanceFrom: "distance", dictionary: userDictionary)
            
            
            completion(user)
            
            
        }) { (err) in
            print("Failed to fetch user for posts:", err)
        }
        
        
    }
}

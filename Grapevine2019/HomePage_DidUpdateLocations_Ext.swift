//
//  HomePage_DidUpdateLocations_Ext.swift
//  Grapevine2019
//
//  Created by Ben Palmer on 20/1/18.
//  Copyright © 2018 Ben Palmer. All rights reserved.
//

import Foundation
import CoreLocation
import Firebase


extension HomePage {

    

    
    
//updates the current users Actual location. so they can be found in the search and then updates the user location label in the header.
func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation])
{
    
    
    
    
    
    
    
    let db = Firestore.firestore()
    

    
    
    
    
    
    // create variables of Ints and Doubles from GPS coordinates
    guard let uid = Auth.auth().currentUser?.uid else { return }
    
    let location = locations[0]
    
    let actualLatitude = String(location.coordinate.latitude)
    
    let actualLongitude = String(location.coordinate.longitude)
    
    guard let doubleActualLatitude = Double(actualLatitude) else { return }
    
    guard let doubleActualLongitude = Double(actualLongitude) else { return }
    
    
    
    
    //check to see that the user profile header kms away is giving the righ values now you are updating defaults actualLatitude and actualLongitude, and also make sure the kms from search location are working properly
    
    
    
    defaults.set(actualLatitude, forKey: "ActualLatitude")
    
    defaults.set(actualLongitude, forKey: "ActualLongitude")
    
    
    db.collection("Users").document(uid).setData(["Actual Latitude":actualLatitude,"Actual Longitude":actualLongitude ], options: SetOptions.merge())
    

    
    
    
   // let timestamp = String(Int(Date().timeIntervalSince1970))
    
    
    
   
    ///if search coordinate's are nil set them to the users current latitude and longitude.
    
    let searchLatitude = self.defaults.string(forKey:"SearchingFromLatitude")
    if searchLatitude == nil{
        defaults.set(actualLatitude, forKey: "SearchingFromLatitude")
}
    
    let searchLongitude = self.defaults.string(forKey:"SearchingFromLongitude")
    if searchLongitude == nil{
        defaults.set(actualLongitude, forKey: "SearchingFromLongitude")
    }

    
    
    
    
    
    let usersCurrentLocation = CLLocation(latitude: doubleActualLatitude, longitude: doubleActualLongitude)
    
//    
//    Ballarat/Coordinates
//    37.5622° S, 143.8503° E
//    
//    
////////////
//"Ballarat": CLLocation(latitude: -37.5622, longitude: 143.8503),
////////////////// 
//    
    
    let citiesArray = ["Adelaide": CLLocation(latitude: -34.9286600, longitude: 138.5986300),"Albury": CLLocation(latitude: -36.0737, longitude: 146.9135),"Alice Springs": CLLocation(latitude: -23.6980, longitude: 133.8807),"Armadale": CLLocation(latitude: -32.1530, longitude: 116.0150),"Ballarat": CLLocation(latitude: -37.5622, longitude: 143.8503),"Brisbane": CLLocation(latitude: -27.470125, longitude: 153.021072),"Bunbury": CLLocation(latitude: -33.3256, longitude: 115.6396),
                 "Busselton": CLLocation(latitude: -33.6555, longitude: 115.3500),"Darwin":CLLocation(latitude: -12.462827, longitude: 130.841782),"Geelong": CLLocation(latitude: -38.1499, longitude: 144.3617),"Gold Coast": CLLocation(latitude: -28.0167, longitude: 153.4000),"Gosford": CLLocation(latitude: -33.4267, longitude: 151.3417),
                 "Hobart":CLLocation(latitude: -42.837284, longitude: 147.505005),
                    "Joondalup":CLLocation(latitude: -32.5361, longitude: 115.7424),"Katherine": CLLocation(latitude: -14.4521, longitude: 132.2715),"Launceston": CLLocation(latitude: -41.4332, longitude: 147.1441),"Mandurah": CLLocation(latitude: -32.5361, longitude: 115.7424),"Margaret River": CLLocation(latitude: -33.9536, longitude: 115.07391),
                    "Melbourne": CLLocation(latitude: -37.81425, longitude: 144.963169),"Newcastle": CLLocation(latitude: -32.9283, longitude: 151.7817),"Perth": CLLocation(latitude: -31.953512, longitude: 115.857048),"Port Augusta": CLLocation(latitude: -32.4952, longitude: 137.7894),"Port Pirie": CLLocation(latitude: -33.1708, longitude: 138.0089),"Rockingham": CLLocation(latitude: -32.2810, longitude: 115.7270),"Sunshine Coast": CLLocation(latitude: -26.6500, longitude: 153.0667),
                    "Sydney": CLLocation(latitude: -33.865143, longitude: 151.209900),"Wagga Wagga": CLLocation(latitude: -35.1082, longitude: 147.3598)]
    
    
     let cities = citiesArray.sorted { $0.value.distance(from: usersCurrentLocation) < $1.value.distance(from: usersCurrentLocation) }
    
    
    guard let closestCity = cities.first else {  return }
    
 
    guard let secondClosestCity = cities.dropFirst(1).first else {  return }
    
    
    guard let thirdClosestCity = cities.dropFirst(2).first else { return }
 
    
    //set closest city
   db.collection("Users").document(uid).setData(["Location": closestCity.key], options: SetOptions.merge())
//    
    // set second closest city
    db.collection("Users").document(uid).setData(["Second Closest Location": secondClosestCity.key], options: SetOptions.merge())
    
    // set third closest city
        db.collection("Users").document(uid).setData(["Third Closest Location": thirdClosestCity.key], options: SetOptions.merge())
    
    
    
    
    
}

}

    
    
    



//
//  HomePage.swift
//  Grapevine 2017
//
//  Created by Ben Palmer on 28/9/17.
//  Copyright © 2017 Ben Palmer. All rights reserved.
//
import UIKit
import Firebase
import FirebaseAuth
import CoreLocation



class HomePage: UICollectionViewController, UICollectionViewDelegateFlowLayout, HomePageHeaderDelegate,HomePageHeaderClosedDelegate, CLLocationManagerDelegate, UISearchBarDelegate {
    
    
    
    let defaults = UserDefaults.standard
    
    var isGridView = true
    
    let cellId = "cellId"
    
    let cellIdLarge = "cellIdLarge"
    
    let headerId = "headerId"
    
    let headerIdClosed = "headerIdClosed"
    
    var userId: String?
    
    var currentUserLocation: CLLocation?
    
   
var headerOpen = true
    
    
    
    
    
    func closeOpenHeader(){
        
        if headerOpen == true {
            headerOpen = false
            print("header open is false")

            collectionView?.reloadData()
        } else if headerOpen == false {
        
           headerOpen = true
            print("header open is true")

            collectionView?.reloadData()
        }
        
        
    }
    
    
    
    //were are upto making the homepage cell large and switching between the two
    
    var largeCell = false
    
    
    func changeCellTypeToLarge(){
        if largeCell == false {
            largeCell = true
            print("header open is false")
            
            collectionView?.reloadData()
        }
        
        }
        
         func changeCellTypeToSmall(){
        
            if largeCell == true{
                largeCell = false
                 collectionView?.reloadData()
            }
            
        }
        
    
    
    
    
    
    func uploadPhoto(){
        let photoSelectorController = PhotoSelectorController(collectionViewLayout: UICollectionViewFlowLayout())
        
        navigationController?.pushViewController(photoSelectorController, animated: true)
        
        
    }
    
    
    
    func homePageShowAdvancedSearchController() {
        
        let advancedSearchController = AdvancedSearchController()
        
        navigationController?.pushViewController(advancedSearchController, animated: true)
        
    }
    
    
    
    
    override func viewWillAppear(_ animated: Bool) {
        
        
        setupSwitch()
        //users.removeAll()
        
        fetchArrayOfUsersBlockingTheCurrentUser()
        firestoreFetchCurrentUser()
        
        
        searchBar.isHidden = false
    }
    
    
    override func viewWillDisappear(_ animated: Bool) {
        searchBar.isHidden = true
        users.removeAll()
        
        self.collectionView?.reloadData()
        
    }
    
    
    
    let manager = CLLocationManager()
    
    
    
    
    lazy var searchBar: UISearchBar = {
        let sb = UISearchBar()
        sb.placeholder = "Search"
        sb.barTintColor = .gray
        UITextField.appearance(whenContainedInInstancesOf: [UISearchBar.self]).backgroundColor = UIColor.rgb(red: 230, green: 230, blue: 230)
        sb.delegate = self
        return sb
    }()
    
    
    var isFriendsRequest = false
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        users.removeAll()
        
        
        if Auth.auth().currentUser?.uid == nil {
            
            
            let signInVC = SignInVC()
            signInVC.HomePage = self
            
            
            self.present(signInVC, animated: true, completion: nil)
            
            
        }
        
        
        
        
       checkForPendingFriendRequests()
        
        
        navigationController?.navigationBar.addSubview(searchBar)
        
        let navBar = navigationController?.navigationBar
        
        searchBar.anchor(top: navBar?.topAnchor, left: navBar?.leftAnchor, bottom: navBar?.bottomAnchor, right: navBar?.rightAnchor, paddingTop: 0, paddingLeft: 75, paddingBottom: 0, paddingRight: 50, width: 0, height: 0)
        
        
        
        manager.delegate = self
        manager.distanceFilter = 1000
        manager.desiredAccuracy = kCLLocationAccuracyKilometer
        manager.requestAlwaysAuthorization()
        manager.requestWhenInUseAuthorization()
        manager.startUpdatingLocation()
        
        
        //removeAndPrintOutDefaults()
        
        
        collectionView?.register(HomePageCell.self, forCellWithReuseIdentifier: cellId)
        
        
        
        collectionView?.register(HomePageCellLarge.self, forCellWithReuseIdentifier: cellIdLarge)
        
        
        collectionView?.register(HomePageHeader.self, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: headerId)
        
        //we are up to making another header which will just be a closed header so more cells will fit on the screen.
        
        collectionView?.register(HomePageHeaderClosed.self, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: headerIdClosed)
        
        collectionView?.backgroundColor = .white
        
        navigationItem.title = ""
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "gear").withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(handleLogout))
        
        setupSwitch()
        
        
        //we want to save a date string or timestamp for the last time someone updated their location then we want to return this as seconds ago then we want to filter out people who didn't updated their location < 1000 seconds ago but we will have options of 5mins/300 seconds , 10 mins/600 seconds, 30mins/1800 seconds
        
        //we can then go on to block messages from user for 5mins/300 seconds , we simply get the current time stamp and do a sum timestamp+300  and do a func which is called when one trys to messages another if time stamp < (less than) block from messages = true and if block from messages == true do not allow them to message.
        
        //setElapsedTime()
        
        SetDefaultsForUserSearchRefinementsIfNil()
        
        
        
    }//viewDidLoad
    
    
    
    
    
    func checkForPendingFriendRequests(){
       
        print("checking for pending friends requests")
        
        guard let uid = Auth.auth().currentUser?.uid else { return }
        
        
        let db = Firestore.firestore()
        
        db.collection("Users").document(uid).collection("Pending Requests").getDocuments() { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                for document in querySnapshot!.documents {
                    
                    if document.exists{
                        
                      
                        self.alertTheUser(title: "New Friend Request", message: "")
                        
                        self.isFriendsRequest = true
                        
                        
//                    print("\(document.documentID) => \(document.data())")
                        
                        let frc =  FriendsRequestsController(collectionViewLayout: UICollectionViewFlowLayout())
                        
                        let navController = UINavigationController(rootViewController: frc)
                frc.HomePage = self
                        
                        self.present(navController, animated: true, completion: nil)
                    }
                    }
                }
            }
    }
    
    
    
    
    
    func SetDefaultsForUserSearchRefinementsIfNil() {
        
        
        
        
        
        
        ////////   "Online & Offline" ///////
        
        let onlineOffline = "Online & Offline"
        
        
        let csp = self.defaults.string(forKey: "connectionStatusPreference")
        
        if csp == nil {
            
            defaults.set(onlineOffline, forKey: "connectionStatusPreference")
        }
        
        ////////
        
        
        
        
        /// search location ///
        // needs to be updated as defaulting everyone to Sydney is not the best solution.
        
        
        let sl = self.defaults.string(forKey: "searchLocation")
        
        if sl == nil {
            
            let location = "Sydney"
            
            self.defaults.set(location, forKey: "searchLocation")
            
        }
        
        
        
        
        
        
        
        //// lower age preferences /////
        
        let one = 1
        
        
        let lap = self.defaults.string(forKey: "LowerAgePreference")
        
        if lap == nil {
            
            
            defaults.set(one, forKey: "LowerAgePreference")
        }
        
        
        
        //// higher age preferences /////
        
        let eighty = 80
        
        let hap = self.defaults.string(forKey: "HigherAgePreference")
        
        if hap == nil {
            
            defaults.set(eighty, forKey: "HigherAgePreference")
            
        }
        
        
        
        
        //Account Type Preference
        let allAccounts = "All Account Types"
        
        let atp = self.defaults.string(forKey: "accountTypePreference")
        
        if atp == nil {
            
            print(atp as Any, "atp was nil")
            self.defaults.set(allAccounts, forKey: "accountTypePreference")
        }
        
        
        
        //GenderTypePreference
        
        let bothGenders = "All Genders"
        
        let gtp = self.defaults.string(forKey: "genderTypePreference")
        
        if gtp == nil {
            
            print(atp as Any, "gender type preference was nil")
            self.defaults.set(bothGenders, forKey: "genderTypePreference")
        }
        
        
        
        
        
        
        
        
        //distance preference
        
        let distance = 2000000
        
        let dp = self.defaults.string(forKey: "distancePreference")
        
        if dp == nil {
            
            print(dp as Any, "distance preference was nil")
            self.defaults.set(distance, forKey: "distancePreference")
        }
        
        
        
    }// end of SetDefaultsForUserSearchRefinementsIfNil func
    
    
    
    
    
    
    var profilePage: UserProfileController?
    var profilePageHeader: UserProfileHeader?
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let user = users[indexPath.item]
        
        let profilePage = UserProfileController(collectionViewLayout: UICollectionViewFlowLayout())
        
        profilePage.user = user
        
        navigationController?.pushViewController(profilePage, animated: true)
    }
    
    
    
    
    
    func firestoreFetchCurrentUser(){
        let db = Firestore.firestore()
        
        guard let uid = Auth.auth().currentUser?.uid else { return }
        
        let docRef = db.collection("Users").document(uid)
        
        docRef.getDocument { (document, error) in
            if let document = document {
                
                if document.exists {
                    
                    //print("Document data: \(document.data())")
                    
                    
                    guard let dictionary = document.data() as? [String: Any] else { return }
                    
                    //guard let displayName = dictionary["Display Name"] as? String else { return }
                    
                    guard let latitude = dictionary["Actual Latitude"] as? String else {
                        
                        self.alertTheUser(title: "Location Not Set", message: "Please Set Location")
                        return
                  }
                    
                    //////////////Start of distanceFrom code///////////////////////////////////
                  
                    
                    
                    self.currentUser = User2(uid: "any", distanceFrom: "any", dictionary: dictionary)
                    
                }
                
                let signInVC = SignInVC()
                
                signInVC.HomePage = self
                
                self.setupSwitch()
                
                self.header?.reloadInputViews()
                self.collectionView?.reloadData()
                
            }
            
            if let error = error {
                print("failed to fetch user", error)
            }
        }
    }
    
    
    
    
    
    func alertTheUser(title: String , message: String) {
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let ok = UIAlertAction(title: "OK", style: .default, handler: nil);
        alert.addAction(ok);
        present(alert, animated: true, completion: nil);
    }
    
    
    
    
    
    var usersLocation = String()
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    var UsersBlockingCurrentUserArray = [String]()
    //{
    // didSet{
    //            users.removeAll()
    //         fireStoreFetchUsers()
    //        }
    //
    //    }
    
    
    func fetchArrayOfUsersBlockingTheCurrentUser() {
        
        guard let uid = Auth.auth().currentUser?.uid else { return }
        
        let db = Firestore.firestore()
        
        let docRef =  db.collection("Users").document(uid).collection("Users Blocking Me")
        
        docRef.getDocuments() { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                for document in querySnapshot!.documents {
                    
                    
                    
                    let d = document.documentID
                    
                    
                    
                    self.UsersBlockingCurrentUserArray.append(d)
                    
                    
                }
                
                self.fireStoreFetchUsers()
            }
        }
        
        
        
    }
    
    
    
    
    
    
    var users = [User2]()
    
    
    func fireStoreFetchUsers(){
        
        guard let searchingFromLatitude = self.defaults.string(forKey: "SearchingFromLatitude")
            else {
                return }
        guard let searchingFromLongitude = self.defaults.string(forKey: "SearchingFromLongitude") else {
            return }
        guard let DoubleLatitude = Double(searchingFromLatitude) else {
            return }
        guard let DoubleLongitude = Double(searchingFromLongitude) else {
            return }
        
        
        
        guard let uid = Auth.auth().currentUser?.uid else { return }
        
        guard (Auth.auth().currentUser?.uid) != nil else { return }
        
        let db = Firestore.firestore()
        let grapevineUsers = db.collection("Users")
        guard let searchLocation = self.defaults.string(forKey: "searchLocation") else { return }
        
        guard let accountTypePreference = self.defaults.string(forKey: "accountTypePreference") else { return }
        
        guard let serviceTypePreference =  self.defaults.string(forKey: "Service being searched") else { return }
        
        guard let connectionStatusPreference = self.defaults.string(forKey: "connectionStatusPreference") else { return }
        
        guard let genderTypePreference = self.defaults.string(forKey: "genderTypePreference") else { return }
        
        
        print("genderTypePreference is", genderTypePreference)
        
        let lower = self.defaults.integer(forKey: "LowerAgePreference")
        
        let higher = self.defaults.integer(forKey: "HigherAgePreference")
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        ///All Accounts, Personal, "Location"
        
        
        if accountTypePreference == "All Account Types" {
            //aimed at persons users
            
            grapevineUsers.whereField("Persons Account", isEqualTo: true).whereField("Location", isEqualTo: searchLocation).whereField(connectionStatusPreference, isEqualTo: true).whereField(genderTypePreference, isEqualTo: true).whereField("Age", isGreaterThanOrEqualTo: lower).whereField("Age", isLessThanOrEqualTo: higher)
                .getDocuments() { (querySnapshot, err) in
                    
                    if let err = err {
                        print("Error getting documents: \(err)")
                    } else {
                        for document in querySnapshot!.documents {
                            
                            let dictionary = document.data()
                            
                         
                          
                            
                            //////////////Start of distanceFrom code///////////////////////////////////
                            
                            guard let latitude = dictionary["Actual Latitude"] as? String,
                                let longitude = dictionary["Actual Longitude"] as? String,
                                let latDouble = Double(latitude),
                                let longDouble = Double(longitude) else {
                                    return }
                            
                            let usersActualLocation = CLLocation(latitude:latDouble, longitude: longDouble)
                            
                            let Current_Users_Searching_From_Location2 = CLLocation(latitude:DoubleLatitude, longitude: DoubleLongitude)
                            
                            let theDistanceInMeters = Current_Users_Searching_From_Location2.distance(from: usersActualLocation)
                            
                            let distanceInKms = Int(theDistanceInMeters/1000)
                            
                            /////////////////end of distanceFrom code///////////
                            
                            
                            
                            
                            
                            
                            let user = User2(uid: "", distanceFrom: "\(distanceInKms)", dictionary: dictionary)
                            
                            guard let distancePreference = self.defaults.string(forKey: "distancePreference") else { return }
                            guard let distancePreferenceInt = Int(distancePreference) else { return }
                            if distanceInKms > distancePreferenceInt { continue }
                            
                            if uid == user.uid { continue }
                            
                            
                            
                            if self.UsersBlockingCurrentUserArray.contains(user.uid) { continue }
                            
                            
                            
                            self.users.append(user)
                            
                            
                            self.users.sort(by: { (p1, p2) -> Bool in
                                return p1.distanceFrom.compare(p2.distanceFrom) == .orderedAscending
                                
                                
                            })
                            
                            self.collectionView?.reloadData()
                            
                            
                        }
                    }
                    
            }
            
            
            
            
            
            
            
            ///All Accounts, Personal, "Second Closest Location"
            
            
            
            grapevineUsers.whereField("Persons Account", isEqualTo: true).whereField("Second Closest Location", isEqualTo: searchLocation).whereField(connectionStatusPreference, isEqualTo: true).whereField(genderTypePreference, isEqualTo: true).whereField("Age", isGreaterThanOrEqualTo: lower).whereField("Age", isLessThanOrEqualTo: higher)
                .getDocuments() { (querySnapshot, err) in
                    
                    if let err = err {
                        print("Error getting documents: \(err)")
                    } else {
                        for document in querySnapshot!.documents {
                            
                            let dictionary = document.data()
                            
                            
                            
                            //////////////Start of distanceFrom code///////////////////////////////////
                            
                            guard let latitude = dictionary["Actual Latitude"] as? String,
                                let longitude = dictionary["Actual Longitude"] as? String,
                                let latDouble = Double(latitude),
                                let longDouble = Double(longitude) else {
                                    return }
                            
                            let usersActualLocation = CLLocation(latitude:latDouble, longitude: longDouble)
                            
                            let Current_Users_Searching_From_Location2 = CLLocation(latitude:DoubleLatitude, longitude: DoubleLongitude)
                            
                            let theDistanceInMeters = Current_Users_Searching_From_Location2.distance(from: usersActualLocation)
                            
                            let distanceInKms = Int(theDistanceInMeters/1000)
                            
                            /////////////////end of distanceFrom code///////////
                            
                            let user = User2(uid: "", distanceFrom: "\(distanceInKms)", dictionary: dictionary)
                            
                            guard let distancePreference = self.defaults.string(forKey: "distancePreference") else { return }
                            guard let distancePreferenceInt = Int(distancePreference) else { return }
                            if distanceInKms > distancePreferenceInt { continue }
                            
                            if uid == user.uid { continue }
                            
                            
                            if self.UsersBlockingCurrentUserArray.contains(user.uid) { continue }
                            
                            
                            
                            self.users.append(user)
                            
                            self.users.sort(by: { (p1, p2) -> Bool in
                                return p1.distanceFrom.compare(p2.distanceFrom) == .orderedAscending
                                
                            })
                            
                            
                            
                            self.collectionView?.reloadData()
                            
                        }
                    }
                    
                    
            }
            
            
            
            
            
            
            
            
            
            
            
            ///All Accounts, Personal, "Third Closest Location"
            
            
            
            grapevineUsers.whereField("Persons Account", isEqualTo: true).whereField("Third Closest Location", isEqualTo: searchLocation).whereField(connectionStatusPreference, isEqualTo: true).whereField(genderTypePreference, isEqualTo: true).whereField("Age", isGreaterThanOrEqualTo: lower).whereField("Age", isLessThanOrEqualTo: higher)
                .getDocuments() { (querySnapshot, err) in
                    
                    if let err = err {
                        print("Error getting documents: \(err)")
                    } else {
                        for document in querySnapshot!.documents {
                            
                            let dictionary = document.data()
                            
                            
                            
                            //////////////Start of distanceFrom code///////////////////////////////////
                            
                            guard let latitude = dictionary["Actual Latitude"] as? String,
                                let longitude = dictionary["Actual Longitude"] as? String,
                                let latDouble = Double(latitude),
                                let longDouble = Double(longitude) else {
                                    return }
                            
                            let usersActualLocation = CLLocation(latitude:latDouble, longitude: longDouble)
                            
                            let Current_Users_Searching_From_Location2 = CLLocation(latitude:DoubleLatitude, longitude: DoubleLongitude)
                            
                            let theDistanceInMeters = Current_Users_Searching_From_Location2.distance(from: usersActualLocation)
                            
                            let distanceInKms = Int(theDistanceInMeters/1000)
                            
                            /////////////////end of distanceFrom code///////////
                            
                            
                            let user = User2(uid: "", distanceFrom: "\(distanceInKms)", dictionary: dictionary)
                            
                            guard let distancePreference = self.defaults.string(forKey: "distancePreference") else { return }
                            guard let distancePreferenceInt = Int(distancePreference) else { return }
                            if distanceInKms > distancePreferenceInt { continue }
                            
                            if uid == user.uid { continue }
                            
                            
                            if self.UsersBlockingCurrentUserArray.contains(user.uid) { continue }
                            
                            self.users.append(user)
                            
                            
                            
                            self.users.sort(by: { (p1, p2) -> Bool in
                                return p1.distanceFrom.compare(p2.distanceFrom) == .orderedAscending
                                
                                
                            })
                            
                            
                            self.collectionView?.reloadData()
                            
                        }
                    }
                    
                    
                    
                    
                    
            }
            //END OF ///All Accounts, Personal, "Third Closest Location"
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            ///All Accounts, Business, "Location"
            
            
            
            grapevineUsers.whereField("Business Account", isEqualTo: true).whereField("Location", isEqualTo: searchLocation).whereField(connectionStatusPreference, isEqualTo: true).whereField(serviceTypePreference, isEqualTo: true)
                .getDocuments() { (querySnapshot, err) in
                    
                    if let err = err {
                        print("Error getting documents: \(err)")
                    } else {
                        for document in querySnapshot!.documents {
                            
                            
                            print("fetching aimed at business users")
                            
                            let dictionary = document.data()
                            
                            
                            
                            //////////////Start of distanceFrom code///////////////////////////////////
                            
                            //get user's actual long and latitude to later compare against current users searching from long and lat
                            guard let latitude = dictionary["Actual Latitude"] as? String else {
                                return }
                            guard let longitude = dictionary["Actual Longitude"] as? String else {
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
                            
                            let user = User2(uid: "", distanceFrom: "\(distanceInKms)", dictionary: dictionary)
                            
                            guard let distancePreference = self.defaults.string(forKey: "distancePreference") else { return }
                            
                            guard let distancePreferenceInt = Int(distancePreference) else { return }
                            
                            if distanceInKms > distancePreferenceInt { continue }
                            
                            if uid == user.uid { continue }
                            
                            if self.UsersBlockingCurrentUserArray.contains(user.uid) { continue }
                            
                            
                            
                            
                            self.users.append(user)
                            
                            
                            self.users.sort(by: { (p1, p2) -> Bool in
                                return p1.distanceFrom.compare(p2.distanceFrom) == .orderedAscending
                                
                            })
                            
                            self.collectionView?.reloadData()
                            
                        }
                    }
            }
            
            
            
            
            
            
            
            
            
            ///All Accounts, Business, "Second Closest Location"
            
            
            
            grapevineUsers.whereField("Business Account", isEqualTo: true).whereField("Second Closest Location", isEqualTo: searchLocation).whereField(connectionStatusPreference, isEqualTo: true).whereField(serviceTypePreference, isEqualTo: true)
                .getDocuments() { (querySnapshot, err) in
                    
                    if let err = err {
                        print("Error getting documents: \(err)")
                    } else {
                        for document in querySnapshot!.documents {
                            
                            
                            print("fetching aimed at business users")
                            
                            let dictionary = document.data()
                            
                            
                            
                            //////////////Start of distanceFrom code///////////////////////////////////
                            
                            //get user's actual long and latitude to later compare against current users searching from long and lat
                            guard let latitude = dictionary["Actual Latitude"] as? String else {
                                return }
                            guard let longitude = dictionary["Actual Longitude"] as? String else {
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
                            
                            let user = User2(uid: "", distanceFrom: "\(distanceInKms)", dictionary: dictionary)
                            
                            guard let distancePreference = self.defaults.string(forKey: "distancePreference") else { return }
                            
                            guard let distancePreferenceInt = Int(distancePreference) else { return }
                            
                            if distanceInKms > distancePreferenceInt { continue }
                            
                            if uid == user.uid { continue }
                            
                            if self.UsersBlockingCurrentUserArray.contains(user.uid) { continue }
                            
                            
                            
                            
                            
                            
                            self.users.append(user)
                            
                            
                            
                            self.users.sort(by: { (p1, p2) -> Bool in
                                return p1.distanceFrom.compare(p2.distanceFrom) == .orderedAscending
                                
                            })
                            
                            self.collectionView?.reloadData()
                            
                            
                            
                        }
                    }
            }
            
            // END OF //// All Accounts, Business, "Second Closest Location"
            
            
            
            
            
            
            
            
            
            
            
            
            
            ///All Accounts, Business, "Third Closest Location"
            
            
            grapevineUsers.whereField("Business Account", isEqualTo: true).whereField("Third Closest Location", isEqualTo: searchLocation).whereField(connectionStatusPreference, isEqualTo: true).whereField(serviceTypePreference, isEqualTo: true)
                .getDocuments() { (querySnapshot, err) in
                    
                    if let err = err {
                        print("Error getting documents: \(err)")
                    } else {
                        for document in querySnapshot!.documents {
                            
                            
                            print("fetching aimed at business users")
                            
                            let dictionary = document.data()
                            
                            
                            
                            //////////////Start of distanceFrom code///////////////////////////////////
                            
                            //get user's actual long and latitude to later compare against current users searching from long and lat
                            guard let latitude = dictionary["Actual Latitude"] as? String else {
                                return }
                            guard let longitude = dictionary["Actual Longitude"] as? String else {
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
                            
                            let user = User2(uid: "", distanceFrom: "\(distanceInKms)", dictionary: dictionary)
                            
                            guard let distancePreference = self.defaults.string(forKey: "distancePreference") else { return }
                            
                            guard let distancePreferenceInt = Int(distancePreference) else { return }
                            
                            if distanceInKms > distancePreferenceInt { continue }
                            
                            if uid == user.uid { continue }
                            
                            
                            
                            
                            if self.UsersBlockingCurrentUserArray.contains(user.uid) { continue }
                            
                            
                            
                            
                            self.users.append(user)
                            
                            
                            self.users.sort(by: { (p1, p2) -> Bool in
                                return p1.distanceFrom.compare(p2.distanceFrom) == .orderedAscending
                                
                            })
                            
                            self.collectionView?.reloadData()
                            
                            
                            
                        }
                        
                    }
            }
            
            //END OF  ///All Accounts, Business, "Third Closest Location"
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            //Business, "Location"
            
            
        } else if accountTypePreference == "Business Account"{
            print("go Business")
            
            
            grapevineUsers.whereField("Business Account", isEqualTo: true).whereField("Location", isEqualTo: searchLocation).whereField(connectionStatusPreference, isEqualTo: true).whereField(serviceTypePreference, isEqualTo: true)
                .getDocuments() { (querySnapshot, err) in
                    
                    if let err = err {
                        print("Error getting documents: \(err)")
                    } else {
                        for document in querySnapshot!.documents {
                            
                            
                            print("fetching aimed at business users")
                            
                            let dictionary = document.data()
                            
                            
                            
                            
                            //////////////Start of distanceFrom code///////////////////////////////////
                            
                            //get user's actual long and latitude to later compare against current users searching from long and lat
                            guard let latitude = dictionary["Actual Latitude"] as? String else {
                                return }
                            guard let longitude = dictionary["Actual Longitude"] as? String else {
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
                            
                            
                            
                            
                            let user = User2(uid: "", distanceFrom: "\(distanceInKms)", dictionary: dictionary)
                            
                            
                            guard let distancePreference = self.defaults.string(forKey: "distancePreference") else { return }
                            
                            guard let distancePreferenceInt = Int(distancePreference) else { return }
                            
                            if distanceInKms > distancePreferenceInt { continue }
                            
                            
                            
                            if uid == user.uid { continue }
                            
                            
                            if self.UsersBlockingCurrentUserArray.contains(user.uid) { continue }
                            
                            
                            
                            
                            
                            self.users.append(user)
                            
                            
                            
                            self.users.sort(by: { (p1, p2) -> Bool in
                                return p1.distanceFrom.compare(p2.distanceFrom) == .orderedAscending
                                
                            })
                            
                            self.collectionView?.reloadData()
                            
                        }
                    }
                    
                    
                    
                    
                    
            }
            
            //END OF //Business, "Location"
            
            
            
            
            
            
            
            
            //START OF //Business, "Second Closest Location"
            
            
            grapevineUsers.whereField("Business Account", isEqualTo: true).whereField("Second Closest Location", isEqualTo: searchLocation).whereField(connectionStatusPreference, isEqualTo: true).whereField(serviceTypePreference, isEqualTo: true)
                .getDocuments() { (querySnapshot, err) in
                    
                    if let err = err {
                        print("Error getting documents: \(err)")
                    } else {
                        for document in querySnapshot!.documents {
                            
                            
                            print("fetching aimed at business users")
                            
                            let dictionary = document.data()
                            
                            
                            
                            
                            //////////////Start of distanceFrom code///////////////////////////////////
                            
                            //get user's actual long and latitude to later compare against current users searching from long and lat
                            guard let latitude = dictionary["Actual Latitude"] as? String else {
                                return }
                            guard let longitude = dictionary["Actual Longitude"] as? String else {
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
                            
                            
                            
                            
                            
                            
                            let user = User2(uid: "", distanceFrom: "\(distanceInKms)", dictionary: dictionary)
                            
                            
                            guard let distancePreference = self.defaults.string(forKey: "distancePreference") else { return }
                            
                            guard let distancePreferenceInt = Int(distancePreference) else { return }
                            
                            if distanceInKms > distancePreferenceInt { continue }
                            
                            
                            
                            if uid == user.uid { continue }
                            
                            
                            if self.UsersBlockingCurrentUserArray.contains(user.uid) { continue }
                            
                            
                            
                            
                            self.users.append(user)
                            
                            
                            
                            self.users.sort(by: { (p1, p2) -> Bool in
                                return p1.distanceFrom.compare(p2.distanceFrom) == .orderedAscending
                                
                            })
                            
                            self.collectionView?.reloadData()
                            
                        }
                    }
                    
                    
            }
            
            
            //END OF //Business, "Second Closest Location"
            
            
            
            
            
            
            //START OF //Business, "Third Closest Location"
            
            
            grapevineUsers.whereField("Business Account", isEqualTo: true).whereField("Third Closest Location", isEqualTo: searchLocation).whereField(connectionStatusPreference, isEqualTo: true).whereField(serviceTypePreference, isEqualTo: true)
                .getDocuments() { (querySnapshot, err) in
                    
                    if let err = err {
                        print("Error getting documents: \(err)")
                    } else {
                        for document in querySnapshot!.documents {
                            
                            
                            print("fetching aimed at business users")
                            
                            let dictionary = document.data()
                            
                            
                            
                            
                            //////////////Start of distanceFrom code///////////////////////////////////
                            
                            //get user's actual long and latitude to later compare against current users searching from long and lat
                            guard let latitude = dictionary["Actual Latitude"] as? String else {
                                return }
                            guard let longitude = dictionary["Actual Longitude"] as? String else {
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
                            
                            
                            
                            
                            
                            
                            let user = User2(uid: "", distanceFrom: "\(distanceInKms)", dictionary: dictionary)
                            
                            
                            guard let distancePreference = self.defaults.string(forKey: "distancePreference") else { return }
                            
                            guard let distancePreferenceInt = Int(distancePreference) else { return }
                            
                            if distanceInKms > distancePreferenceInt { continue }
                            
                            
                            
                            if uid == user.uid { continue }
                            
                            
                            
                            if self.UsersBlockingCurrentUserArray.contains(user.uid) { continue }
                            
                            
                            
                            self.users.append(user)
                            
                            
                            self.users.sort(by: { (p1, p2) -> Bool in
                                return p1.distanceFrom.compare(p2.distanceFrom) == .orderedAscending
                                
                            })
                            
                            self.collectionView?.reloadData()
                            
                        }
                    }
                    
                    
            }
            
            
            //END OF //Business, "Third Closest Location"
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            //START OF //Persons, "Location"
            
            
        }  else if accountTypePreference == "Persons Account"{
            
            
            grapevineUsers.whereField("Persons Account", isEqualTo: true).whereField("Location", isEqualTo: searchLocation).whereField(connectionStatusPreference, isEqualTo: true).whereField(genderTypePreference, isEqualTo: true).whereField("Age", isGreaterThanOrEqualTo: lower).whereField("Age", isLessThanOrEqualTo: higher)
                .getDocuments() { (querySnapshot, err) in
                    
                    if let err = err {
                        print("Error getting documents: \(err)")
                    } else {
                        for document in querySnapshot!.documents {
                            
                            let dictionary = document.data()
                            
                            
                            
                            
                            
                            
                            //////////////Start of distanceFrom code///////////////////////////////////
                            
                            //get user's actual long and latitude to later compare against current users searching from long and lat
                            guard let latitude = dictionary["Actual Latitude"] as? String else {
                                return }
                            guard let longitude = dictionary["Actual Longitude"] as? String else {
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
                            
                            
                            
                            
                            let user = User2(uid: "", distanceFrom: "\(distanceInKms)", dictionary: dictionary)
                            
                            
                            
                            guard let distancePreference = self.defaults.string(forKey: "distancePreference") else { return }
                            
                            guard let distancePreferenceInt = Int(distancePreference) else { return }
                            
                            if distanceInKms > distancePreferenceInt { continue }
                            
                            
                            if uid == user.uid { continue }
                            
                            
                            if self.UsersBlockingCurrentUserArray.contains(user.uid) { continue }
                            
                            
                            
                            
                            self.users.append(user)
                            
                            
                            self.users.sort(by: { (p1, p2) -> Bool in
                                return p1.distanceFrom.compare(p2.distanceFrom) == .orderedAscending
                                
                            })
                            
                            self.collectionView?.reloadData()
                            
                        }
                    }
            }
            
            //END OF //Persons, "Location"
            
            
            
            
            
            
            
            
            
            
            
            
            //START OF //Persons, "Second Closest Location"
            
            
            grapevineUsers.whereField("Persons Account", isEqualTo: true).whereField("Second Closest Location", isEqualTo: searchLocation).whereField(connectionStatusPreference, isEqualTo: true).whereField(genderTypePreference, isEqualTo: true).whereField("Age", isGreaterThanOrEqualTo: lower).whereField("Age", isLessThanOrEqualTo: higher)
                .getDocuments() { (querySnapshot, err) in
                    
                    if let err = err {
                        print("Error getting documents: \(err)")
                    } else {
                        for document in querySnapshot!.documents {
                            
                            let dictionary = document.data()
                            
                            
                            
                            
                            //////////////Start of distanceFrom code///////////////////////////////////
                            
                            //get user's actual long and latitude to later compare against current users searching from long and lat
                            guard let latitude = dictionary["Actual Latitude"] as? String else {
                                return }
                            guard let longitude = dictionary["Actual Longitude"] as? String else {
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
                            
                            
                            
                            
                            let user = User2(uid: "", distanceFrom: "\(distanceInKms)", dictionary: dictionary)
                            
                            
                            
                            guard let distancePreference = self.defaults.string(forKey: "distancePreference") else { return }
                            
                            guard let distancePreferenceInt = Int(distancePreference) else { return }
                            
                            if distanceInKms > distancePreferenceInt { continue }
                            
                            
                            if uid == user.uid { continue }
                            
                            
                            if self.UsersBlockingCurrentUserArray.contains(user.uid) { continue }
                            
                            
                            
                            
                            self.users.append(user)
                            
                            
                            
                            self.users.sort(by: { (p1, p2) -> Bool in
                                return p1.distanceFrom.compare(p2.distanceFrom) == .orderedAscending
                                
                            })
                            
                            self.collectionView?.reloadData()
                            
                        }
                    }
            }
            
            //END OF //Persons, "Second Closest Location"
            
            
            
            
            
            
            
            //START OF //Persons, "Third Closest Location"
            
            grapevineUsers.whereField("Persons Account", isEqualTo: true).whereField("Third Closest Location", isEqualTo: searchLocation).whereField(connectionStatusPreference, isEqualTo: true).whereField(genderTypePreference, isEqualTo: true).whereField("Age", isGreaterThanOrEqualTo: lower).whereField("Age", isLessThanOrEqualTo: higher)
                .getDocuments() { (querySnapshot, err) in
                    
                    if let err = err {
                        print("Error getting documents: \(err)")
                    } else {
                        for document in querySnapshot!.documents {
                            
                            let dictionary = document.data()
                            
                            
                            
                            
                            
                            
                            
                            //////////////Start of distanceFrom code///////////////////////////////////
                            
                            //get user's actual long and latitude to later compare against current users searching from long and lat
                            guard let latitude = dictionary["Actual Latitude"] as? String else {
                                return }
                            guard let longitude = dictionary["Actual Longitude"] as? String else {
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
                            
                            
                            
                            
                            let user = User2(uid: "", distanceFrom: "\(distanceInKms)", dictionary: dictionary)
                            
                            
                            
                            guard let distancePreference = self.defaults.string(forKey: "distancePreference") else { return }
                            
                            guard let distancePreferenceInt = Int(distancePreference) else { return }
                            
                            if distanceInKms > distancePreferenceInt { continue }
                            
                            
                            if uid == user.uid { continue }
                            
                            
                            
                            if self.UsersBlockingCurrentUserArray.contains(user.uid) { continue }
                            
                            
                            
                            
                            self.users.append(user)
                            
                            
                            
                            self.users.sort(by: { (p1, p2) -> Bool in
                                return p1.distanceFrom.compare(p2.distanceFrom) == .orderedAscending
                                
                            })
                            
                            self.collectionView?.reloadData()
                            
                        }
                    }
            }
            
            
            
            
            //END OF //Persons, "Third Closest Location"
            
            
            
            
            
        }
        
        
        
    }// end of fetch users function
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    ///start of code for HomePageCell/////
    
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if largeCell == false {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath)as! HomePageCell
        
        cell.user = users[indexPath.item]
            
            return cell
            
        } else {
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdLarge, for: indexPath)as! HomePageCellLarge
            
            cell.user = users[indexPath.item]
        
        
        return cell
    }
    
    }
        
    

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return users.count
        
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        
        if largeCell == false {
        
        let width = (view.frame.width)
        return CGSize(width: width, height: 70)
        
        } else {
        
            
            let width = (view.frame.width)
            return CGSize(width: width, height: 362)
            
            
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    
    /////////end of code for HomePageCell/////////////////////
    
    
    
    
    
    
    
    
   
    
    
    ///start of code for HomePageHeader/////
    
    var header: HomePageHeader?
    
    var currentUser : User2?
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        
        if self.headerOpen == true {
        
     let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: headerId, for: indexPath) as! HomePageHeader
        
        header.currentUser = self.currentUser
        header.usersLocation = self.usersLocation
        header.delegate = self
        
        reloadInputViews()
        
        return header
        
        
        } else {
            
            let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: headerIdClosed, for: indexPath) as! HomePageHeaderClosed
            
            header.currentUser = self.currentUser
            header.usersLocation = self.usersLocation
            header.delegate = self
            
            reloadInputViews()
            
            return header
        
        
        }
        
        }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        
        if headerOpen == true {
        return CGSize(width: view.frame.width, height: 190)
        } else {
            return CGSize(width: view.frame.width, height: 50)
        }
    }
    
    
    
    /////////end of code for HomePageHeader/////////////////////
    
    
    
    
    
    
    
    
    
    


    
    
    
    
}










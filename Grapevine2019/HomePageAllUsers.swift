//
//  HomePageAllUsers.swift
//  Grapevine2019
//
//  Created by Ben Palmer on 3/2/18.
//  Copyright © 2018 Ben Palmer. All rights reserved.
//

import Foundation

import UIKit
import Firebase
import FirebaseAuth
import CoreLocation




class HomePageAllUsers: UICollectionViewController, UICollectionViewDelegateFlowLayout, HomePageHeaderDelegate, CLLocationManagerDelegate, UISearchBarDelegate {
    
    
    
    let defaults = UserDefaults.standard
    
    var isGridView = true
    
    let cellId = "cellId"
    
    let headerId = "headerId"
    
    var userId: String?
    
    var currentUserLocation: CLLocation?
    
    
    func changeCellTypeToSmall(){
    
    }
    
    
    func changeCellTypeToLarge(){
    
    }
    
    func closeOpenHeader(){
        
        
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
 
        users.removeAll()
        collectionView?.reloadData()

        fireStoreFetchUsers()
        firestoreFetchCurrentUser()
        
        
        searchBar.isHidden = false
    }
    
    
    override func viewWillDisappear(_ animated: Bool) {
        searchBar.isHidden = true
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
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        
        
        
        firestoreFetchCurrentUser()
        
        navigationController?.navigationBar.addSubview(searchBar)
        
        let navBar = navigationController?.navigationBar
        
        searchBar.anchor(top: navBar?.topAnchor, left: navBar?.leftAnchor, bottom: navBar?.bottomAnchor, right: navBar?.rightAnchor, paddingTop: 0, paddingLeft: 75, paddingBottom: 0, paddingRight: 50, width: 0, height: 0)
        
        //the function below will remove defaults so that values are nil and will also print out the values
        //removeAndPrintOutDefaults()
        
        
        
        
        manager.delegate = self
        manager.distanceFilter = 1000
        manager.desiredAccuracy = kCLLocationAccuracyKilometer
        manager.requestAlwaysAuthorization()
        manager.requestWhenInUseAuthorization()
        manager.startUpdatingLocation()
        
        
        
        
        
        collectionView?.register(HomePageCell.self, forCellWithReuseIdentifier: cellId)
        
        
        collectionView?.register(HomePageHeader.self, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: headerId)
        
        
        collectionView?.backgroundColor = .white
     
        
    }//viewDidLoad
    
    
    
    
    
    
    
    
    
    
    
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
                    
                    print("Document data: \(document.data())")
                    
                    
                    guard let dictionary = document.data() as? [String: Any] else { return }
                    
                    
                    
                    
                    self.currentUser = User2(uid: "any", distanceFrom: "any", dictionary: dictionary)
                    
                }
                
                
                self.header?.reloadInputViews()
                self.collectionView?.reloadData()
                
            }
            
            if let error = error {
                print("failed to fetch user", error)
            }
        }
    }
    
    
    
    
    
    
    
    var usersLocation = String()
    
    
    
    
    
    
    
    
    
    
    
  
      
    
    
    
    
    
    
    
    
    
    func fireStoreFetchUsers(){
        
        guard let uid = Auth.auth().currentUser?.uid else { return }
        
        guard (Auth.auth().currentUser?.uid) != nil else { return }
        
        let db = Firestore.firestore()
        let users = db.collection("Users")
        
        users.getDocuments() { (querySnapshot, err) in
            
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                for document in querySnapshot!.documents {
                    
                    
                    let dictionary = document.data()
                    
                    
        
                    let user = User2(uid: "", distanceFrom: "", dictionary: dictionary)
                
                    
                    if uid == user.uid { continue }
                    
                    
                    self.users.append(user)
                    
                    self.collectionView?.reloadData()
                }
            }
        }
    }

    
    
    var users = [User2]()
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    ///start of code for HomePageCell/////
    
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath)as! HomePageCell
        
        cell.user = users[indexPath.item]
        
        return cell
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return users.count
        
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (view.frame.width)
        return CGSize(width: width, height: 70)
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
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: headerId, for: indexPath) as! HomePageHeader
        
        header.currentUser = self.currentUser
        header.usersLocation = self.usersLocation
        header.delegate = self
        
        reloadInputViews()
        
        return header
        
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: view.frame.width, height: 190)
    }
    
    
    
    /////////end of code for HomePageHeader/////////////////////
    
    
    
}













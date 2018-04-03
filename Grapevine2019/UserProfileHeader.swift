//
//  UserProfileHeader.swift
//  Grapevine 2017
//
//  Created by Ben Palmer on 16/10/17.
//  Copyright © 2017 Ben Palmer. All rights reserved.
//



///user.blocking.childAdded

//append to blockedby[array]

//


//
//
//to give the user profile header distacnce from search location label proper meaning we need to set
//
//self.defaults.string(forKey: "SearchingFromLatitude")
//And
//
//self.defaults.string(forKey: "SearchingFromLongitude") else {
//    return }
//
//when we click on the map to set search location and also when ever we click on a capital city to search it we need to set the search location coordinates.
//








import UIKit
import Firebase
import CoreLocation


protocol UserProfileHeaderDelegate {
//    func didChangeToListView()
//    func didChangeToGridView()
  func openChatLogController()
     func callNumber(phoneNumber:String)
    func closeOpenHeader()
    func sendFriendRequest()
    func presentFRC()
}





class UserProfileHeader: UICollectionViewCell {
    
    var delegate: UserProfileHeaderDelegate?
    
    
    
    
    let defaults = UserDefaults.standard
    
let db = Firestore.firestore()
    
        
    
    
    
    var user: User2? {
        didSet {
            
            
            guard let uid = Auth.auth().currentUser?.uid else { return  }
            
            guard let usersUID = user?.uid else { return }
            
            let db = Firestore.firestore()
            let docRef = db.collection("Users").document(usersUID).collection("Users Blocked By Me").document(uid)
            
            
            docRef.getDocument { (document, error) in
                if let document = document {
                    
                    if document.exists{
                   
                        print("blocked document exists")
                        return
                    } else {
                        
                        guard let uniqueUserId = self.user?.username else {
                            return }
                        
                        guard let profileImageUrl = self.user?.profileImageURL else {
                            return }
                        
                        
                        guard let AccountImage = self.user?.accountTypeImageUrl else {
                            return }
                        
                        guard let subtitle = self.user?.subtitle else { return }
                        
                        guard let displayName = self.user?.DisplayName else { return }
                        
                        guard let accountType = self.user?.accountType else { return }
                        
                        guard let age = self.user?.age else { return }
                        
                        guard let location = self.user?.Location else { return }
                        
                        self.ClosestCityLabel.text = "Closest Hub: \(location)"
                        
                        
                        //fetch current users searching location from User Defaults and set as a CLLocation
                        
                        guard let searchingFromLatitude = self.defaults.string(forKey: "SearchingFromLatitude")
                            else { return }
                        guard let searchingFromLongitude = self.defaults.string(forKey: "SearchingFromLongitude") else {
                            return }
                        guard let searchingFromlatDouble = Double(searchingFromLatitude) else { return }
                        guard let searchingFromlongDouble = Double(searchingFromLongitude) else { return }
                        let currentUserSearchingFromLocation = CLLocation(latitude:searchingFromlatDouble, longitude: searchingFromlongDouble)
                        
                        
                        
                        
                        //fetch current users actual location from User Defaults and set as a CLLocation
                        
                        
                        
                        
                        guard let actualLatitude = self.defaults.string(forKey: "ActualLatitude")
                            else { return }
                        guard let actualLongitude = self.defaults.string(forKey: "ActualLongitude") else {
                            return }
                        
                        guard let actualLatDouble = Double(actualLatitude) else { return }
                        
                        guard let ActualLongDouble = Double(actualLongitude) else { return }
                        let currentUsersActualLocation = CLLocation(latitude:actualLatDouble, longitude: ActualLongDouble)
                        
                        
                        
                        
                        // get actual location of the user's profile the current user is looking at
                        guard let profileUsersActualLatitude = Double((self.user?.actualLatitude)!) else {
                            print("ERROR 4563")
                            return }
                        
                        guard let profileUsersActualLongitude = Double((self.user?.actualLongitude)!) else {
                            print("ERROR 4883")
                            return }
                        
                        let acutalLatDouble = Double(profileUsersActualLatitude)
                        let actualLongDouble = Double(profileUsersActualLongitude)
                        
                        let profileUsersActualLocation = CLLocation(latitude:acutalLatDouble, longitude: actualLongDouble)
                        
                        
                        
                        
                        
                        
                        //compare distance between the location of the user's who's profile it is with current users actual location
                        
                        let theDistanceInMeters = currentUsersActualLocation.distance(from: profileUsersActualLocation)
                        
                        let distanceInKms = Int(theDistanceInMeters/1000)
                        
                        self.distanceFromActualLocationLabel.text = "\(distanceInKms) kms away"
                        
                        
                        
                        //compare distance between location of users who's profile it is and current users search location
                        
                        let theDistanceInMetersFromSearchLocation = currentUserSearchingFromLocation.distance(from: profileUsersActualLocation)
                        
                        let distanceInKmsFromSearchLocation = Int(theDistanceInMetersFromSearchLocation/1000)
                        
                        self.distanceFromSearchLocationLabel.text = "\(distanceInKmsFromSearchLocation) kms from Search Location"
                        
                        
                        
                        
                        
                        
                        CLGeocoder().reverseGeocodeLocation(profileUsersActualLocation, completionHandler: { (placemark, err) in
                            
                            if err != nil {
                                print("there was an error in reverse geocode")
                                
                                
                                self.ReverseGeoCodeLocationLabel.text = ""
                                
                            } else {
                                
                                guard let place = placemark?[0], let l = place.locality else { return }
                                
                                let locationLabelText = ("\(l)")
                                
                                
                                self.ReverseGeoCodeLocationLabel.text = locationLabelText
                            }
                        }
                        )
                        
                        
                        
                        // now you have to add the ReverseGeoCodeLocationLabel to the view so you can compare it with the closest city label for testing purposes
                        
                        
                        
                        ///fetch a time interval since 1970 string from firebase put through method and return a time ago string
                        
                        guard let LastTimeActualLocationWasUpdated = Double((self.user?.LastTimeActualLocationWasUpdated)!) else {
                            return }
                        
                        
                        let timeAgo = ElapsedTimeFunction.Instance.elapsedTime(timeStamp: LastTimeActualLocationWasUpdated)
                        
                        guard let StringTimeAgo = String("location updated: \(timeAgo)")
                            else { return }
                        
                        
                        self.lastTimeLocationWasUpdatedLabel.text = StringTimeAgo
                        
                        
                        
                        
                        //// set online, offline Label///////////
                        guard let onlineOfflineStatus = self.user?.onlineOfflineStatus else { return }
                        
                        if onlineOfflineStatus == "Online" {
                            self.onlineOfflineLabel.text = "Online Now!"
                        }
                        
                        
                        if onlineOfflineStatus == "Offline" {
                            self.onlineOfflineLabel.text = "Offline"
                        }
                        //////////////////////////////////////
                        
                        
                        
                        
                        let business = "Business"
                        
                        
                        self.setupEditFollowButton()
                        self.setupFriendButton()
                        
                        self.checkIfCurrentUserIsBlockingUserofThisProfile()
                        
                        self.profileImageView.loadImage(urlString: profileImageUrl)
                        self.accountTypeBubble.loadImage(urlString: AccountImage)
                        
                        
                        guard let number = self.user?.contactNumber else { return }
                        
                        guard let email = self.user?.email else { return }
                        
                        ///start  of set age label//////
                        guard let gender = self.user?.gender else { return }
                        
                        
                        self.genderAndNumberButton.setTitle("Gender: \(gender)", for: .normal)
                        
                        
                        if accountType == business {
                            
                            self.ageAndEmailButton.setTitle("\(email)", for: .normal)
                            
                            
                        } else {
                            self.ageAndEmailButton.setTitle("Age: \(age)", for: .normal)
                            
                            
                        }
                        ///end of set age label//////
                        
                        
                        ///start of  set gender label////
                        if accountType == business {
                            
                            
                            self.genderAndNumberButton.setTitle("\(number)", for: .normal)
                            
                            //
                        } else {
                            guard let gender = self.user?.gender else { return }
                            
                            self.genderAndNumberButton.setTitle("Gender: \(gender)", for: .normal)
                            
                            
                        }
                        ///end of  set gender label////
                        
                        
                        self.displayNameLabel.text = displayName
                        
                        self.subtitleLabel.text = subtitle
                        
                        self.UniqueUserIdLabel.text = "@\(uniqueUserId)"
                        
                        
                        
                    }
                    
                    
                }
                
                        
                    }
                }
            }
        
        
            
            
    func checkIfCurrentUserIsBlockingUserofThisProfile(){
        
      
        
        guard let user = self.user?.uid else {return}
        
        let db = Firestore.firestore()
        
        guard let uid = Auth.auth().currentUser?.uid else { return }
        
        let docRef = db.collection("Users").document(uid).collection("Users Blocked By Me").document(user)
        
        docRef.getDocument { (document, error) in
            if let document = document {
                
                
                
                
                if document.exists{
                    
                    
                    self.BlockButton.setTitle( "Un Block User", for: .normal)
                    
                    self.blockingUserImageView.isHidden = false
                    
                } else {

                   
                 self.BlockButton.setTitle( "Block User", for: .normal)
        
                     self.blockingUserImageView.isHidden = true
                }
            }
        }
    }
    
    
    
    fileprivate func setupEditFollowButton() {
        guard let currentLoggedInUserId = Auth.auth().currentUser?.uid else { return }
        
        guard let userId = user?.uid else { return }
        
        
            
            // check if following
        
            
            db.collection("Users").document(currentLoggedInUserId).collection("Contacts").document(userId).getDocument(completion: { (document, error) in
                
                if (document?.exists)!{
                    
                    
                    
                    self.SaveUnSaveContactButton.setTitle("Un Save Contact", for: .normal)
                    
                } else {
                    self.setupFollowStyle()
                }
                })
    }
    
    
    
    //check for pending request
    
    
    
    fileprivate func setupFriendButton(){
        
        //check for pending request , set title pending request
        guard let uid = Auth.auth().currentUser?.uid else { return }
        
                guard let user = user?.uid else { return }
        
                print("users is", user)
        
                print("this is uid", uid)
        
                db.collection("Users").document(user).collection("Pending Requests").document(uid).getDocument(completion: { (document, error) in
        
                    if (document?.exists)!{
        
                        print("a pending friend document does exist")
        
                        self.FriendRequestButton.setTitle("Request Pending", for: .normal)
                        
                    } else {
                        //check for for friends document , set title un friend
                        guard let uid = Auth.auth().currentUser?.uid else { return }
                                        guard let user = self.user?.uid else { return }
                        
                                        self.db.collection("Users").document(user).collection("Friends").document(uid).getDocument(completion: { (document, error) in
                        
                                            if (document?.exists)!{
                        
                                                print("a friend document does exist")
                                                
                                                self.FriendRequestButton.setTitle("Un-Friend", for: .normal)
                                                
                                            } else {
                                              
                                                self.db.collection("Users").document(uid).collection("Pending Requests").document(user).getDocument(completion: { (document, error) in
                                                    
                                                    if (document?.exists)!{
                                                        
                                                        print("a pending request document does exist")
                                                        
                                                        self.FriendRequestButton.setTitle("Accept or Decline Request?", for: .normal)
                                                        
                                                    } else {
                                                        
                                                            //if no documents are found none set title to send request
                                                            self.FriendRequestButton.setTitle("Send Friend Request", for: .normal)
                                                            

                                                        
                                                    }
                                                })
                                                
                                            }
                        })
                    }
        })
    }
    
    
        
//    //if no documents are found none set title to send request
//    self.FriendRequestButton.setTitle("Send Friend Request", for: .normal)
//    
    
    
    
    func sendUnsendFriendRequest(){
        
        //if title "pending request" , delete pending request from database , set button to "send request"
        
        guard let uid = Auth.auth().currentUser?.uid else { return }
        guard let user = self.user?.uid else { return }
        
        
        
        if FriendRequestButton.titleLabel?.text == "Request Pending" {
            
             print("Button was = to Request Pending")
            
            db.collection("Users").document(user).collection("Pending Requests").document(uid).delete() { err in
                                            if let err = err {
                                                print("Error removing document: \(err)")
                                            } else {
                                                print("Pending Request Document successfully removed from user's documents")
                                                self.setupFriendButton()
                                            }
                                        }

            
            
            
            //if title "un friend" , delete friend document from database, set button to "Send Friend Request"
        } else if FriendRequestButton.titleLabel?.text == "Un-Friend" {
            
     
                                    db.collection("Users").document(uid).collection("Friends").document(user).delete() { err in
                                        if let err = err {
                                            print("Error removing document: \(err)")
                                        } else {
                                            print("Friend Document successfully removed from current user documents!")
                                        }
                                    }
            
                                    db.collection("Users").document(user).collection("Friends").document(uid).delete() { err in
                                        if let err = err {
                                            print("Error removing document: \(err)")
                                        } else {
                                            print("Friend Document successfully removed from user (not the current user)!")
                                        }
                                    }
              self.setupFriendButton()
            
            
            //if title "send request" add friend request to database" set button to "request pending"

        } else if FriendRequestButton.titleLabel?.text == "Send Friend Request"{
            
            
            db.collection("Users").document(user).collection("Pending Requests").document(uid).setData([uid:uid], options: SetOptions.merge())
            
            
             self.setupFriendButton()
            
        } else if FriendRequestButton.titleLabel?.text == "Accept or Decline Request?"{
    
          delegate?.presentFRC()
            
    
    
    self.setupFriendButton()
    
    }
    
    }












    
    
    
       func blockUnBlockUser() {
        
        let db = Firestore.firestore()
        
        guard let uid = Auth.auth().currentUser?.uid else {return}
        
        guard let user = self.user?.uid else {return}
        
        if BlockButton.titleLabel?.text == "Un Block User" {
            
             self.blockingUserImageView.isHidden = false
            
            db.collection("Users").document(uid).collection("Users Blocked By Me").document(user).delete() { err in
                if let err = err {
                    print("Error removing document: \(err)")
                } else {
                    print("Document successfully removed!")
                }
            }
            db.collection("Users").document(user).collection("Users Blocking Me").document(uid).delete() { err in
                if let err = err {
                    print("Error removing document: \(err)")
                } else {
                    print("Document successfully removed!")
                    
                }
                
            }
            
            
            
            self.setupBlockStyle()
            
            
        } else {
            //block
            
            
            
              let userValues = [ user : user]
            
            let usersBlockedByMe = db.collection("Users").document(uid).collection("Users Blocked By Me").document(user)
            
            usersBlockedByMe.setData(userValues, options: SetOptions.merge())
            
            let userBlockingMe =  db.collection("Users").document(user).collection("Users Blocking Me").document(uid)
            
            userBlockingMe.setData([uid: uid], options: SetOptions.merge())
            
            
            self.blockingUserImageView.isHidden = false
            
                self.BlockButton.setTitle("Un Block User", for: .normal)
        }
    }

    
    
    
    
    fileprivate func setupBlockStyle() {
        
        self.blockingUserImageView.isHidden = true

        self.BlockButton.setTitle("Block User", for: .normal)
      
    }
    
    
    
    
    
    func FirestoreSaveUnSaveContact() {
        guard let currentLoggedInUserId = Auth.auth().currentUser?.uid else { return }
        guard let userId = user?.uid else { return }
    
        if SaveUnSaveContactButton.titleLabel?.text == "Un Save Contact" {
            
         
            
            db.collection("Users").document(currentLoggedInUserId).collection("Contacts").document(userId).delete() { err in
                if let err = err {
                    print("Error removing document: \(err)")
                } else {
                    print("Document successfully removed!")
                }
            }

                
                print("Successfully unfollowed user:", self.user?.DisplayName ?? "")
                
                self.setupFollowStyle()
           
            
        } else {
            //follow
            db.collection("Users").document(currentLoggedInUserId).collection("Contacts").document(userId).setData([userId:userId], options: SetOptions.merge()){ err in
                if let err = err {
                    print("Error saving document: \(err)")
                } else {
                    print("Document successfully saved")
            
            
                self.SaveUnSaveContactButton.setTitle("Un Save Contact", for: .normal)
                self.SaveUnSaveContactButton.backgroundColor = .white
                self.SaveUnSaveContactButton.setTitleColor(.black, for: .normal)
                    
                }
                
            }
            
        }
    }


    
    
    fileprivate func setupFollowStyle() {
        self.SaveUnSaveContactButton.setTitle("Save Contact", for: .normal)
        self.SaveUnSaveContactButton.backgroundColor = UIColor.rgb(red: 17, green: 154, blue: 237)
        self.SaveUnSaveContactButton.setTitleColor(.white, for: .normal)
        self.SaveUnSaveContactButton.layer.borderColor = UIColor(white: 0, alpha: 0.2).cgColor
    }
    
    let profileImageView: CustomImageView = {
        let iv = CustomImageView()
        iv.backgroundColor = UIColor.black
        iv.contentMode = .scaleAspectFill
        
        
        return iv
    }()
    
    
    let blockingUserImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = UIColor.white
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.masksToBounds = true
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(named: "icons8-unavailable-48")
        imageView.isHidden = true
        return imageView
        
    }()
 
    
//    let blockingUserImageView: CustomImageView = {
//        let iv = CustomImageView()
//        iv.backgroundColor = UIColor.yellow
//        return iv
//    }()
    
    
    
    
    
    let accountTypeBubble: CustomImageView = {
        let iv = CustomImageView()
        iv.backgroundColor = UIColor.yellow
        return iv
    }()
    
    
    
    lazy var gridButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(#imageLiteral(resourceName: "grid"), for: .normal)
        button.addTarget(self, action: #selector(handleChangeToGridView), for: .touchUpInside)
        return button
    }()
    
    func handleChangeToGridView() {
        print("Changing to grid view")
        gridButton.tintColor = .mainBlue()
        listButton.tintColor = UIColor(white: 0, alpha: 0.2)
        //delegate?.didChangeToGridView()
    }
    
    
    
    
    lazy var listButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(#imageLiteral(resourceName: "list"), for: .normal)
        button.tintColor = UIColor(white: 0, alpha: 0.2)
        button.addTarget(self, action: #selector(handleChangeToListView), for: .touchUpInside)
        return button
    }()
    
    func handleChangeToListView() {
        print("Changing to list view")
        listButton.tintColor = .mainBlue()
        gridButton.tintColor = UIColor(white: 0, alpha: 0.2)
        //delegate?.didChangeToListView()
    }
    
    lazy var bookmarkButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(#imageLiteral(resourceName: "ribbon"), for: .normal)
        button.tintColor = UIColor(white: 0, alpha: 0.2)
        button.addTarget(self, action: #selector(closeOpenHeader), for: .touchUpInside)
        
        return button
    }()
    
    func closeOpenHeader(){
        delegate?.closeOpenHeader()
    }
    
    
    let displayNameLabel: UILabel = {
        let label = UILabel()
        label.text = "Display Name"
        label.font = UIFont.boldSystemFont(ofSize: 17)
        return label
    }()
    
    
    let UniqueUserIdLabel: UILabel = {
        let label = UILabel()
        label.text = "Unique User Id"
        label.font = UIFont.boldSystemFont(ofSize: 14)
        return label
    }()
    
    
    let subtitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Subtitle"
        //label.font = UIFont.boldSystemFont(ofSize: 14)
        label.font = UIFont.systemFont(ofSize: 11)
        label.textColor = UIColor.lightGray
        
        return label
    }()
    
    
    lazy var accountTypeLabel: UILabel = {
        let label = UILabel()
        label.text = "Business Account"
        label.font = UIFont.boldSystemFont(ofSize: 14)
        return label
    }()
    
    
    
    let ReverseGeoCodeLocationLabel: UILabel = {
        let label = UILabel()
        label.text = ""
        label.font = UIFont.boldSystemFont(ofSize: 6)
        label.backgroundColor = UIColor.white
        return label
    }()
    
    
    
    let ClosestCityLabel: UILabel = {
        let label = UILabel()
        label.text = "Closest Hub:"
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.backgroundColor = UIColor.white
        return label
    }()
    
    
    // once ready have location label text say  "showing users offline location"
    let lastTimeLocationWasUpdatedLabel: UILabel = {
        let label = UILabel()
        label.text = "location updated: 0 days Ago"
        label.font = UIFont.boldSystemFont(ofSize: 10)
        label.backgroundColor = UIColor.white
        return label
    }()
    
    
    let onlineOfflineLabel: UILabel = {
        let label = UILabel()
        label.text = "Offline"
        label.font = UIFont.boldSystemFont(ofSize: 10)
        label.backgroundColor = UIColor.white
        return label
    }()
    
    
    
    let distanceFromActualLocationLabel: UILabel = {
        let label = UILabel()
        label.text = "0 kms from Actual Location"
        label.font = UIFont.boldSystemFont(ofSize: 10)
        label.backgroundColor = UIColor.white
        return label
    }()
    
    
    let distanceFromSearchLocationLabel: UILabel = {
        let label = UILabel()
        label.text = "0 Kms from Search Location"
        label.font = UIFont.boldSystemFont(ofSize: 10)
        label.backgroundColor = UIColor.white
        return label
    }()
    
 
    
    
    lazy var genderAndNumberButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Gender - Phone", for: .normal)
         button.tintColor = UIColor.black

        button.addTarget(self, action: #selector(callNumber), for: .touchUpInside)
        return button
    }()
    
    
    func callNumber(){
        
        guard let usersNumber = user?.contactNumber else { return }
        
        delegate?.callNumber(phoneNumber:usersNumber)
//        print("callNumber button pressed")
    }
    
    
    
    lazy var ageAndEmailButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Age - Email", for: .normal)
        button.tintColor = UIColor.black
        
        button.addTarget(self, action: #selector(callNumber), for: .touchUpInside)
        return button
    }()
    
    
    lazy var writeMessageButton: UIButton = {
        let imageView = UIButton()
        //imageView.image = UIImage(named: "ADD BUTTON CENTRED")
//        imageView.setImage(#imageLiteral(resourceName: "icons8-Hand With Pen Filled-35"), for: .normal)
        imageView.setImage(#imageLiteral(resourceName: "icons8-Message Filled-35"), for: .normal)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.masksToBounds = true
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(openChatLogControllerToWriteMessage)))
        
        return imageView
        
    }()
    
  
    

    func openChatLogControllerToWriteMessage() {
       
        listButton.tintColor = .mainBlue()
        gridButton.tintColor = UIColor(white: 0, alpha: 0.2)
        delegate?.openChatLogController()
    }
    
   
    
    lazy var CallUserButton: UIButton = {
        let imageView = UIButton()
        
        imageView.setImage(#imageLiteral(resourceName: "icons8-Call Filled-35"), for: .normal)
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.masksToBounds = true
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(callNumber)))
        
        return imageView
        
    }()

    
    
    let postsLabel: UILabel = {
        let label = UILabel()
        
        let attributedText = NSMutableAttributedString(string: "11\n", attributes: [NSFontAttributeName: UIFont.boldSystemFont(ofSize: 14)])
        
        attributedText.append(NSAttributedString(string: "posts", attributes: [NSForegroundColorAttributeName: UIColor.lightGray, NSFontAttributeName: UIFont.systemFont(ofSize: 14)]))
        
        label.attributedText = attributedText
        
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()
    
    let followersLabel: UILabel = {
        let label = UILabel()
        
        let attributedText = NSMutableAttributedString(string: "0\n", attributes: [NSFontAttributeName: UIFont.boldSystemFont(ofSize: 14)])
        
        attributedText.append(NSAttributedString(string: "followers", attributes: [NSForegroundColorAttributeName: UIColor.lightGray, NSFontAttributeName: UIFont.systemFont(ofSize: 14)]))
        
        label.attributedText = attributedText
        
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()
    
   
    
    lazy var SaveUnSaveContactButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Save Contact", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 12)
        button.layer.borderColor = UIColor.lightGray.cgColor
        button.layer.borderWidth = 1
        button.layer.cornerRadius = 3
        button.addTarget(self, action: #selector(FirestoreSaveUnSaveContact), for: .touchUpInside)
        return button
    }()
    
    
    lazy var FriendRequestButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 12)
        button.layer.borderColor = UIColor.lightGray.cgColor
        button.layer.borderWidth = 1
        button.layer.cornerRadius = 3
        button.addTarget(self, action: #selector(sendUnsendFriendRequest), for: .touchUpInside)
        return button
    }()
    
    
    
    

    
    
    
    //send request 
    // firestore pending request
    // pending request appear in notification
    
    
    lazy var BlockButton: UIButton = {
        let button = UIButton(type: .system)
        //button.setTitle("Block User", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        button.layer.borderColor = UIColor.lightGray.cgColor

        button.addTarget(self, action: #selector(blockUnBlockUser), for: .touchUpInside)
        return button
    }()
    
    
    lazy var reportButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Report User", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        button.layer.borderColor = UIColor.lightGray.cgColor
        button.addTarget(self, action: #selector(reportUser), for: .touchUpInside)
        return button
    }()
    
    
    func reportUser(){
        
        print(" user reported")
    }
    
    
    
    
   
    
//        uid.connor
//        
//        //this list is just to put a blocked label on their cell when they load on connor's screen
//        usersBlockedByMe
//        lucy
//        jessica
//        
//        
//        //when connor blocks a user such as lucy it will add a field to lucy's userBlockingMe collection'
//        uid.lucy
//    
//        usersBlockingMe
//        connor
//        
//        
//        lucy fetch users,
//        
//        fetch usersBlockingMe
//        
//        if uid == uid
//        
//        dont return user!
    
        
        
        
        
    

    
    
    
    // this pattern will load a screen of users that the current user is blocking
    
    //UsersBlockedByUserCurrentUser
    // uid of current user
    
    //username
    // uid of user they are blocking
    
    
    //blocked
    // uid of current user
    
    //list of users blocking the current user, hence the current user won't be able to see people on this list
    
    //blockedby
    //uid
    //uid
    
    
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    
        
        addSubview(BlockButton)
        addSubview(reportButton)
        addSubview(profileImageView)
         addSubview(blockingUserImageView)
        addSubview(accountTypeBubble)
        addSubview(UniqueUserIdLabel)
        addSubview(displayNameLabel)
        addSubview(subtitleLabel)
        addSubview(ReverseGeoCodeLocationLabel)
        addSubview(ClosestCityLabel)
        addSubview(ageAndEmailButton)
        addSubview(genderAndNumberButton)
        addSubview(lastTimeLocationWasUpdatedLabel)
        addSubview(distanceFromActualLocationLabel)
        addSubview(distanceFromSearchLocationLabel)
        addSubview(onlineOfflineLabel)
        
        
        BlockButton.anchor(top: topAnchor, left: leftAnchor, bottom: nil, right: nil, paddingTop: -2, paddingLeft: 5, paddingBottom: 0, paddingRight: 0, width: 0, height: 30)
        
       
        reportButton.anchor(top: topAnchor, left: nil, bottom: nil, right: rightAnchor, paddingTop: -2, paddingLeft: 0, paddingBottom: 0, paddingRight: 5, width: 0, height: 30)
        
        
        
        profileImageView.anchor(top: BlockButton.bottomAnchor, left: nil, bottom: nil, right: nil, paddingTop: 12, paddingLeft: 12, paddingBottom: 0, paddingRight: 0, width: 80, height: 80)
        profileImageView.layer.cornerRadius = 80 / 2
        profileImageView.clipsToBounds = true
        
        
         profileImageView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        
        
        
        blockingUserImageView.anchor(top: profileImageView.topAnchor, left: profileImageView.leftAnchor, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 25, height: 25)
        
        blockingUserImageView.layer.cornerRadius = 25 / 2
        blockingUserImageView.clipsToBounds = true
        

        
        
        
        accountTypeBubble.anchor(top: nil, left: nil, bottom: profileImageView.bottomAnchor, right: profileImageView.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 25, height: 25)
        
        accountTypeBubble.layer.cornerRadius = 25 / 2
        accountTypeBubble.clipsToBounds = true
        
        
        
        UniqueUserIdLabel.anchor(top: accountTypeBubble.bottomAnchor, left: nil, bottom: nil, right: nil, paddingTop: 10, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        
         UniqueUserIdLabel.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        
        
        displayNameLabel.anchor(top: UniqueUserIdLabel.bottomAnchor, left: nil, bottom: nil, right: nil, paddingTop: 20, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
       
         displayNameLabel.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        
        subtitleLabel.anchor(top: displayNameLabel.bottomAnchor, left: nil, bottom: nil, right: nil, paddingTop: 2, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        
        subtitleLabel.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        
        
        onlineOfflineLabel.anchor(top: subtitleLabel.bottomAnchor, left: nil, bottom: nil, right: nil, paddingTop: 2, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        
        onlineOfflineLabel.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        
        
        
        ReverseGeoCodeLocationLabel.anchor(top: onlineOfflineLabel.bottomAnchor, left: nil, bottom: nil, right: nil, paddingTop: 20, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        
        ReverseGeoCodeLocationLabel.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true

        
        ClosestCityLabel.anchor(top: ReverseGeoCodeLocationLabel.bottomAnchor, left: nil, bottom: nil, right: nil, paddingTop: 5, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        
        ClosestCityLabel.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        
        lastTimeLocationWasUpdatedLabel.anchor(top: ClosestCityLabel.bottomAnchor, left: nil, bottom: nil, right: nil, paddingTop: 8, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        
        lastTimeLocationWasUpdatedLabel.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        
        
        distanceFromActualLocationLabel.anchor(top: lastTimeLocationWasUpdatedLabel.bottomAnchor, left: nil, bottom: nil, right: nil, paddingTop: 4, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        
        distanceFromActualLocationLabel.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        
        distanceFromSearchLocationLabel.anchor(top: distanceFromActualLocationLabel.bottomAnchor, left: nil, bottom: nil, right: nil, paddingTop: 4, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        
        distanceFromSearchLocationLabel.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        
        
        
        genderAndNumberButton.anchor(top: distanceFromSearchLocationLabel.bottomAnchor, left: nil, bottom: nil, right: nil, paddingTop: 20, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 20)
        
        
        genderAndNumberButton.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        
        
        
        ageAndEmailButton.anchor(top: genderAndNumberButton.bottomAnchor, left: nil, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 20)
        
        
        ageAndEmailButton.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        
        
        
     setupUserStatsView()
//        
        
                setupBottomToolbar()

                addSubview(SaveUnSaveContactButton)
                SaveUnSaveContactButton.anchor(top: CallUserButton.bottomAnchor, left: nil, bottom: nil, right: nil, paddingTop: 10, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 180, height: 34)
        
        
        SaveUnSaveContactButton.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        
        
        addSubview(FriendRequestButton)
        
        FriendRequestButton.anchor(top: SaveUnSaveContactButton.bottomAnchor, left: nil, bottom: nil, right: nil, paddingTop: 10, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 180, height: 34)
        
        
        FriendRequestButton.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        
        
        
   
        
        
    }
    
    
    //followingLabel
    
    fileprivate func setupUserStatsView() {
        let stackView = UIStackView(arrangedSubviews: [CallUserButton,writeMessageButton])
        
//         let stackView = UIStackView(arrangedSubviews: [CallUserButton,ViewUserOnMapButton,writeMessageButton])
        
        stackView.distribution = .fillEqually
        
        addSubview(stackView)
        stackView.anchor(top:ageAndEmailButton.bottomAnchor, left: nil, bottom: nil, right: nil, paddingTop: 45, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 180, height: 50)
        
        
        stackView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        
    }
    
    fileprivate func setupBottomToolbar() {
        
        let topDividerView = UIView()
        topDividerView.backgroundColor = UIColor.lightGray
        
        let bottomDividerView = UIView()
        bottomDividerView.backgroundColor = UIColor.lightGray
        
        let stackView = UIStackView(arrangedSubviews: [gridButton, listButton, bookmarkButton])
        
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        
        addSubview(stackView)
        addSubview(topDividerView)
        addSubview(bottomDividerView)
        
        stackView.anchor(top: nil, left: leftAnchor, bottom: self.bottomAnchor, right: rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 50)
        
        topDividerView.anchor(top: stackView.topAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0.5)
        
        bottomDividerView.anchor(top: stackView.bottomAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0.5)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}









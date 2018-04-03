//
//  MyProfileHeader.swift
//  Grapevine 2017
//
//  Created by Ben Palmer on 20/10/17.
//  Copyright © 2017 Ben Palmer. All rights reserved.
//

import Foundation
import UIKit
import Firebase
import CoreLocation



protocol MyProfileHeaderDelegate {
    func didChangeToListView()
    func didChangeToGridView()
    func openChatLogController()
    func didTapEditProfile()
     func uploadPhoto()
    func presentTagWordsController()
     func presentEditServicesController()
      func changeNumber()
    func changeDisplayName()
func changeSubtitle()
   func closeOpenHeader()
    
}







class MyProfileHeader: UICollectionViewCell {
    
    var delegate: MyProfileHeaderDelegate?
    
    
    
    
    
    
    var user: User2? {
        didSet {
            
          
            
          
                
                
                guard let profileImageUrl = user?.profileImageURL
                    else {
                        print("error with profile image")
                        
                        return }
               
            
            
            profileImageView.loadImage(urlString: profileImageUrl)
            
           
            
            guard let accountTypeImageUrl = user?.accountTypeImageUrl else {
                
                print("error with account type image")
                return }
            accountTypeBubble.loadImage(urlString: accountTypeImageUrl)
            
            
            
            guard let displayName = user?.DisplayName else
            
            {
                
                
                print("error with display name")
                return }
            
            
            
            displayNameButton.setTitle("\(displayName)", for: .normal)
            
            guard let subtitle = user?.subtitle else
            {
                print("error subtitle")
                return }
           
            
            
            subtitleButton.setTitle("\(subtitle)", for: .normal)
            
            guard let uniqueUsernameID = user?.username else {
                print("error with username")
                return }
            
            uniqueUsernameIdLabel.text = "@\(uniqueUsernameID)"

            guard let location = user?.Location else {
                print("error with location")
                return }
                    locationLabel.text = "Closest Hub: \(location)"
            
            
            guard let email = user?.email else {
                
                print("error with email")
                return }
            
            emailAdressLabel.text = email
            
            
            guard let contactNumber = user?.contactNumber else { return } 
            
            
            contactNumberButton.setTitle("\(contactNumber)", for: .normal)

            
            guard let onlineOfflineStatus = user?.onlineOfflineStatus else { return }
            
            
            if onlineOfflineStatus == "Online" {
                onlineOfflineLabel.text = "Online Now!"
            }
            if onlineOfflineStatus == "Offline" {
                onlineOfflineLabel.text = "Offline"
            }
            
            
            
           
            
            guard let accountType = user?.accountType else { return }
            
            if accountType == "Persons" {
                
                editServicesButton.isHidden = true
            myTagWordsButton.isHidden = true
                
            }
            
            
            
            
//            guard let gender = user?.gender else { return }
//            
//                        genderLabel.text = "Gender: \(gender)"
//            
//            
//            guard let age = user?.age else { return }
//            
//                         ageLabel.text = "Age: \(age)"
//            
            
            
            
            
            //start  of set age label//////
            guard let gender = user?.gender else { return }
            
            genderLabel.text = "Gender: \(gender)"
            
            let business = "Business"
            //let persons = "Persons"
            
           
            
            if accountType == business {
                
                self.ageLabel.text = "Age: NA"
            } else {
                
                
                guard let age = user?.age else { return }
                
              
                ageLabel.text = "Age: \(age)"
                
            }
            
            //end of set age label//////
            
            
        
            
            
            //start of  set gender label////
            
            
            if accountType == business {
                
                self.genderLabel.text = "Gender: NA"
            } else {
                
                
                guard let gender = user?.gender else { return }
                
                genderLabel.text = "Gender: \(gender)"
                
            }
            
            //end of  set gender label////
            
            
            
            
            
            displayNameButton.setTitle("\(displayName)", for: .normal)
            
            
            subtitleButton.setTitle("\(subtitle)", for: .normal)
            
            guard let AccountImage = user?.accountTypeImageUrl else { return }
            AccountTypeImageView.loadImage(urlString: AccountImage)
            
            accountTypeBubble.loadImage(urlString: AccountImage)
            
            
            
            
            
        }
    }
    
    
    let ServiceTypeLabel: UILabel = {
        let label = UILabel()
        label.text = "Service Type:"
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.backgroundColor = UIColor.white
        return label
    }()
    
    
    
    
    lazy var myTagWordsButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Edit Tag Words?", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 10)
        
        button.layer.borderColor = UIColor.lightGray.cgColor
        button.addTarget(self, action: #selector(presentTagWordsController), for: .touchUpInside)
        return button
    }()
    
    
    func presentTagWordsController(){
        print("presenting tag words controller")
        delegate?.presentTagWordsController()
    }
    
    
    
    
    
    
    lazy var editServicesButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Edit Services ?", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 10)
        
        button.layer.borderColor = UIColor.lightGray.cgColor
        button.addTarget(self, action: #selector(presentEditServicesController), for: .touchUpInside)
        return button
    }()
    
    
    func presentEditServicesController(){
        print("presenting Services controller")
        delegate?.presentEditServicesController()
    }
    
    
    
    
    
    
    
    
    
    lazy var uploadPhotoButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Upload Photo", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        
        button.layer.borderColor = UIColor.lightGray.cgColor
        button.addTarget(self, action: #selector(uploadPhoto), for: .touchUpInside)
        return button
    }()
    
    
    func uploadPhoto(){
        print("uploading photo")
        delegate?.uploadPhoto()
        
        
    }
    
    
    
    
    
    
    
    
    
    func EditProfile(){
        delegate?.didTapEditProfile()
    }
    

    
    
    let profileImageView: CustomImageView = {
        let iv = CustomImageView()
        iv.backgroundColor = UIColor.black
        iv.contentMode = .scaleAspectFill
        return iv
    }()
    
    
    
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
        delegate?.didChangeToGridView()
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
        delegate?.didChangeToListView()
    }
    
   
    lazy var EditProfileButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Settings", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        button.layer.borderColor = UIColor.lightGray.cgColor
        
        button.addTarget(self, action: #selector(EditProfile), for: .touchUpInside)
        return button
    }()
    
    
    let uniqueUsernameIdLabel: UILabel = {
        let label = UILabel()
        label.text = "@uniqueUsernameID"
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.backgroundColor = UIColor.white
        return label
    }()


   
    
    lazy var displayNameButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Username & Subtitle ", for: .normal)
        button.tintColor = UIColor.black
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        button.addTarget(self, action: #selector(changeDisplayName), for: .touchUpInside)
        return button
    }()
    
    
    func changeDisplayName(){
        delegate?.changeDisplayName()
    }
    
    
    
    lazy var subtitleButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Username & Subtitle ", for: .normal)
        button.tintColor = UIColor.lightGray
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 12)
        button.addTarget(self, action: #selector(changeSubtitle), for: .touchUpInside)
        return button
    }()
    
    
    func changeSubtitle(){
        delegate?.changeSubtitle()
    }
    
    
    
    

    

    let onlineOfflineLabel: UILabel = {
        let label = UILabel()
        label.text = ""
        label.font = UIFont.boldSystemFont(ofSize: 10)
        label.backgroundColor = UIColor.white
        return label
    }()


    
    
    
    
    let locationLabel: UILabel = {
        let label = UILabel()
        label.text = "Dalkeith"
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.backgroundColor = UIColor.white
        return label
    }()
    
    
    let lastTimeLocationWasUpdatedLabel: UILabel = {
        let label = UILabel()
        label.text = "location updated: 5 days Ago"
        label.font = UIFont.boldSystemFont(ofSize: 10)
        label.backgroundColor = UIColor.white
        return label
    }()
    
    
 
    
    let editImageInformationLabel: UILabel = {
        let label = UILabel()
        label.text = "click images to delete or select as profile picture"
        label.font = UIFont.boldSystemFont(ofSize: 12)
        label.backgroundColor = UIColor.white
        return label
    }()
    
    
    lazy var editProfileFollowButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Edit Profile", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        button.layer.borderColor = UIColor.lightGray.cgColor
        button.layer.borderWidth = 1
        button.layer.cornerRadius = 3
        button.addTarget(self, action: #selector(EditProfile), for: .touchUpInside)
        return button
    }()
    
    
    
    

let genderLabel: UILabel = {
        let label = UILabel()
        label.text = "Gender NA"
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.backgroundColor = UIColor.white
        return label
    }()
    
    
    let ageLabel: UILabel = {
        let tf = UILabel()
        tf.text = "Age NA"
         tf.font = UIFont.boldSystemFont(ofSize: 14)
        tf.backgroundColor = UIColor.white
        
        return tf
    }()
    

    
    lazy var contactNumberButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Ph: Click to Edit!", for: .normal)
        button.tintColor = UIColor.black
        
        button.addTarget(self, action: #selector(changeNumber), for: .touchUpInside)
        return button
    }()
    
    
    func changeNumber(){
        delegate?.changeNumber()
    }
    
    
    
    
    
    let emailAdressLabel: UILabel = {
        let label = UILabel()
        label.text = "Email"
        label.font = UIFont.boldSystemFont(ofSize: 12)
        label.backgroundColor = UIColor.white
        return label
    }()
    
    
    

    
    func blockUser(){
        print("blocking User")
        
        guard let uid = Auth.auth().currentUser?.uid else {return}
        
        guard let user = self.user?.uid else {return}
        
        let values = [ uid : uid]
        
        let ref = Database.database().reference()
        
        ref.child("blocked").child(user).child("blockedBy").updateChildValues(values) { (err, ref) in
            
            if let err = err {
                print("Failed to block user:", err)
                return
            }
            
            print("Successfully blocked user.")
        }
    }
    
    
    
    
    
    
    let AccountTypeImageView: CustomImageView = {
        let iv = CustomImageView()
        return iv
    }()
    
    
    lazy var CallUserButton: UIButton = {
        let imageView = UIButton()
        
        imageView.setImage(#imageLiteral(resourceName: "icons8-Call Filled-35"), for: .normal)
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.masksToBounds = true
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(openChatLogControllerToWriteMessage)))
        
        return imageView
        
    }()
    
    

    
    
    
    
    func openChatLogControllerToWriteMessage(){
        print("opening chat log controller to write message")
        
    }
    
    lazy var ViewUserOnMapButton: UIButton = {
        let imageView = UIButton()
        //imageView.image = UIImage(named: "ADD BUTTON CENTRED")
        imageView.setImage(#imageLiteral(resourceName: "icons8-Map Marker Filled-35"), for: .normal)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.masksToBounds = true
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(openChatLogControllerToWriteMessage)))
        
        return imageView
        
    }()
    
    
    lazy var writeMessageButton: UIButton = {
        let imageView = UIButton()
        //imageView.image = UIImage(named: "ADD BUTTON CENTRED")
        imageView.setImage(#imageLiteral(resourceName: "icons8-Hand With Pen Filled-35"), for: .normal)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.masksToBounds = true
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(openChatLogControllerToWriteMessage)))
        
        return imageView
        
    }()
    
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
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        
        addSubview(EditProfileButton)
        addSubview(uploadPhotoButton)
        addSubview(profileImageView)
        addSubview(accountTypeBubble)
        addSubview(uniqueUsernameIdLabel)
        addSubview(displayNameButton)
        addSubview(subtitleButton)
        addSubview(locationLabel)
        addSubview(ageLabel)
        addSubview(genderLabel)
        addSubview(contactNumberButton)
        addSubview(emailAdressLabel)
        addSubview(lastTimeLocationWasUpdatedLabel)
        addSubview(onlineOfflineLabel)
        addSubview(myTagWordsButton)
        addSubview(editServicesButton)
        
        
        EditProfileButton.anchor(top: topAnchor, left: leftAnchor, bottom: nil, right: nil, paddingTop: -2, paddingLeft: 5, paddingBottom: 0, paddingRight: 0, width: 0, height: 30)
        
        
        uploadPhotoButton.anchor(top: topAnchor, left: nil, bottom: nil, right: rightAnchor, paddingTop: -2, paddingLeft: 0, paddingBottom: 0, paddingRight: 5, width: 0, height: 30)
        
        
        
        profileImageView.anchor(top: EditProfileButton.bottomAnchor, left: nil, bottom: nil, right: nil, paddingTop: 12, paddingLeft: 12, paddingBottom: 0, paddingRight: 0, width: 80, height: 80)
        profileImageView.layer.cornerRadius = 80 / 2
        profileImageView.clipsToBounds = true
        
        
        
        profileImageView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        
        
        
        accountTypeBubble.anchor(top: nil, left: nil, bottom: profileImageView.bottomAnchor, right: profileImageView.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 25, height: 25)
        
        accountTypeBubble.layer.cornerRadius = 25 / 2
        accountTypeBubble.clipsToBounds = true
        
        
        
        uniqueUsernameIdLabel.anchor(top: accountTypeBubble.bottomAnchor, left: nil, bottom: nil, right: nil, paddingTop: 10, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        
        uniqueUsernameIdLabel.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        
        
        displayNameButton.anchor(top: uniqueUsernameIdLabel.bottomAnchor, left: nil, bottom: nil, right: nil, paddingTop: 20, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 20)
        
        displayNameButton.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        
        subtitleButton.anchor(top: displayNameButton.bottomAnchor, left: nil, bottom: nil, right: nil, paddingTop: 2, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 15)
        
        subtitleButton.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        
        
        onlineOfflineLabel.anchor(top: subtitleButton.bottomAnchor, left: nil, bottom: nil, right: nil, paddingTop: 2, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        
        onlineOfflineLabel.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        
        
        
        
        locationLabel.anchor(top: onlineOfflineLabel.bottomAnchor, left: nil, bottom: nil, right: nil, paddingTop: 14, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        
        locationLabel.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        
        lastTimeLocationWasUpdatedLabel.anchor(top: locationLabel.bottomAnchor, left: nil, bottom: nil, right: nil, paddingTop: 4, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        
        lastTimeLocationWasUpdatedLabel.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        
        
        
        genderLabel.anchor(top: lastTimeLocationWasUpdatedLabel.bottomAnchor, left: nil, bottom: nil, right: nil, paddingTop: 14, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        
        
        genderLabel.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        
        
        
        ageLabel.anchor(top: genderLabel.bottomAnchor, left: nil, bottom: nil, right: nil, paddingTop: 4, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        
        
        ageLabel.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        
        

        
        contactNumberButton.anchor(top: ageLabel.bottomAnchor, left: nil, bottom: nil, right: nil, paddingTop: 20, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        
        
        contactNumberButton.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        
        
        emailAdressLabel.anchor(top: contactNumberButton.bottomAnchor, left: nil, bottom: nil, right: nil, paddingTop: 4, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        
        
        emailAdressLabel.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        
       
      
        myTagWordsButton.anchor(top: emailAdressLabel.bottomAnchor, left: nil, bottom: nil, right: nil, paddingTop: 20, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        
        
        myTagWordsButton.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        
        
        
        editServicesButton.anchor(top: myTagWordsButton.bottomAnchor, left: nil, bottom: nil, right: nil, paddingTop: -10, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        
        
        editServicesButton.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        
        
        
        
        
        //
        //
        //setupUserStatsView()
        //
        
        setupBottomToolbar()
        
//        addSubview(SaveUnSaveContactButton)
//        SaveUnSaveContactButton.anchor(top: CallUserButton.bottomAnchor, left: nil, bottom: nil, right: nil, paddingTop: 10, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 180, height: 34)
//        
//        
//        SaveUnSaveContactButton.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        
        
        
        
        
        
        
        
        
        
    }
    
    
    //followingLabel
    
    fileprivate func setupUserStatsView() {
        let stackView = UIStackView(arrangedSubviews: [CallUserButton,ViewUserOnMapButton,writeMessageButton])
        
        stackView.distribution = .fillEqually
        
        addSubview(stackView)
        stackView.anchor(top:ageLabel.bottomAnchor, left: nil, bottom: nil, right: rightAnchor, paddingTop: 20, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 200, height: 50)
        
        
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















//
//  FriendsRequestsCell.swift
//  Grapevine2019
//
//  Created by Ben Palmer on 30/3/18.
//  Copyright © 2018 Ben Palmer. All rights reserved.
//

import UIKit
import Firebase
import Foundation
import CoreLocation
import FirebaseAuth


protocol friendsRequestControllerDelegate {
    
    func fetch()
    
}





class FriendsRequestsCell: UICollectionViewCell, CLLocationManagerDelegate  {
    
    var delegate: friendsRequestControllerDelegate?
    
    
    var frc = FriendsRequestsController(collectionViewLayout: UICollectionViewFlowLayout())
    
    
    
    var user: User2? {
        didSet {
            
            
            
            guard let distanceFrom = user?.distanceFrom else { return }
            
            guard let accountTypeImageURL = user?.accountTypeImageUrl else { return }
            
            
            guard let displayName = user?.DisplayName else { return }
            
            
            guard let profileImageUrl = user?.profileImageURL
                else { return }
            
            
            guard let subtitle = user?.subtitle else { return }
            
            
            guard let accountType = user?.accountType else { return }
            
            
            guard let gender = user?.gender else { return }
            
            guard let age = user?.age else { return }
            
            
            guard let onlineOfflineStatus = user?.onlineOfflineStatus else { return }
            
            distanceFromLabel.text = "\(distanceFrom) kms"
            profileImageView.loadImage(urlString: profileImageUrl)
            AccountTypeImage.loadImage(urlString: accountTypeImageURL)
            displayNameLabel.text = displayName
            
            
            onlineOfflineLabel.text = "\(gender) - \(age) - \(onlineOfflineStatus) "
            
            
            subtitleLabel.text = "\(subtitle)"
            
            
            
            let b = "Business"
            
            
            if accountType == b {
                
                onlineOfflineLabel.text = "\(onlineOfflineStatus)"
                
            } else {
                
                
                onlineOfflineLabel.text = "\(gender) - \(age) - \(onlineOfflineStatus) "
                
                
            }
            
            
            
            
            
            
        }
        
    }
    
    
    
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        
    }
    
    
    
    
    let AccountTypeImage: CustomImageView = {
        let aiv = CustomImageView()
        aiv.translatesAutoresizingMaskIntoConstraints = false
        aiv.layer.masksToBounds = true
        aiv.contentMode = .scaleAspectFill
        return aiv
        
    }()
    
    
    let profileImageView: CustomImageView = {
        let imageView = CustomImageView()
        imageView.image = UIImage(named: "Grape")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.clipsToBounds = true
        imageView.layer.masksToBounds = true
        imageView.contentMode = .scaleAspectFill
        
        return imageView
        
    }()
    
    
    
    let currentCityLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = UIColor.black
        label.font = UIFont.systemFont(ofSize: 10)
        label.backgroundColor = UIColor.white
        return label
        
    }()
    
    
    
    
    let genderAndAgeLabel: UILabel = {
        let l = UILabel()
        //l.text = "F"
        l.translatesAutoresizingMaskIntoConstraints = false
        l.textColor = UIColor.lightGray
        l.font = UIFont.systemFont(ofSize: 10)
        
        return l
        
    }()
    
    
    let distanceFromLabel: UILabel = {
        let label = UILabel()
        //label.text = "HH:MM:SS"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = UIColor.black
        label.font = UIFont.systemFont(ofSize: 10)
        label.backgroundColor = UIColor.white
        return label
        
    }()
    
    
    
    let locationLastUpdatedLabel: UILabel = {
        let label = UILabel()
        label.text = "Updated 5 mins ago"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = UIColor.black
        label.font = UIFont.systemFont(ofSize: 10)
        label.backgroundColor = UIColor.white
        return label
        
    }()
    
    
    
    
    lazy var acceptButton: UIButton = {
        let b = UIButton(type: .system)
        b.backgroundColor = UIColor.black
        b.setTitle("Accept", for: .normal)
        b.setTitleColor(UIColor.white, for: .normal)
        b.addTarget(self, action: #selector(acceptFriendRequest), for: .touchUpInside)
        b.layer.cornerRadius = 3
        b.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        
        return b
    }()
    
    func acceptFriendRequest(){
       
    
        guard let userAtRow = user?.uid else { return }
        
        
        guard let uid = Auth.auth().currentUser?.uid else { return }
        
        
        //delete pending request
        
        
        let db = Firestore.firestore()
        
        db.collection("Users").document(uid).collection("Pending Requests").document(userAtRow).delete() { err in
                if let err = err {
                    print("Error removing document: \(err)")
                } else {
                    print("Document successfully removed!")
                    
                    //self.delegate?.fetch()
                }
           
            
        }
    

   
        //add user to friends of both users
        
        db.collection("Users").document(uid).collection("Friends").document(userAtRow).setData([userAtRow:userAtRow], options: SetOptions.merge())
        
     db.collection("Users").document(userAtRow).collection("Friends").document(uid).setData([uid:uid], options: SetOptions.merge()) { err in
            if let err = err {
                print("Error \(err)")
            } else {
               
                
            }
   self.delegate?.fetch()
        
        }
    }
    
    
    
    
    
    
    lazy var declineButton: UIButton = {
        let b = UIButton(type: .system)
        b.backgroundColor = UIColor.black
        b.setTitle("Decline", for: .normal)
        b.setTitleColor(UIColor.white, for: .normal)
        b.addTarget(self, action: #selector(declineFriendRequest), for: .touchUpInside)
        b.layer.cornerRadius = 3
        b.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        
        return b
    }()
    
    

    
    
    
    
    func declineFriendRequest(){
        
        guard let userAtRow = user?.uid else { return }
        
        
        guard let uid = Auth.auth().currentUser?.uid else { return }
        
        
        let db = Firestore.firestore()
        
        db.collection("Users").document(uid).collection("Pending Requests").document(userAtRow).delete() { err in
            if let err = err {
                print("Error removing document: \(err)")
            } else {
                print("Document successfully removed!")
                
                self.delegate?.fetch()
            }
         
        }
      
        
      }
    
    
//when clicking accept and decline make sure it reloads the page
//    
//    also make sure the friends page reloads when you unfriend someone
//    
//    and there is probably more problems
    
    
    
    let SeparatorView: UIView = {
        let SV = UIView()
        SV.backgroundColor = UIColor.rgb(red: 230, green: 230, blue: 230)
        //SV.backgroundColor = UIColor.black
        return SV
    }()
    
    
    let displayNameLabel: UILabel = {
        let label = UILabel()
        //label.text = "HH:MM:SS"
        
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = UIColor.black
        label.font = UIFont.systemFont(ofSize: 21)
        label.backgroundColor = UIColor.white
        
        return label
        
    }()
    
    let subtitleLabel: UILabel = {
        let label = UILabel()
        //label.text = "HH:MM:SS"
        
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = UIColor.black
        label.font = UIFont.systemFont(ofSize: 12)
        label.backgroundColor = UIColor.white
        
        
        return label
        
    }()
    
    
    
    let onlineOfflineLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = UIColor.black
        label.font = UIFont.systemFont(ofSize: 9)
        label.backgroundColor = UIColor.white
        
        
        return label
        
    }()
    
    
    
    
    
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        
        
        addSubview(profileImageView)
        addSubview(SeparatorView)
        
        addSubview(AccountTypeImage)
        addSubview(displayNameLabel)
        addSubview(subtitleLabel)
        addSubview(distanceFromLabel)
        addSubview(genderAndAgeLabel)
        addSubview(onlineOfflineLabel)
        addSubview(acceptButton)
        addSubview(declineButton)
        
       
        
        
        profileImageView.anchor(top: topAnchor, left: leftAnchor, bottom: nil, right: nil, paddingTop: 5, paddingLeft: 4, paddingBottom: 0, paddingRight: 0, width: 60, height: 60)
       
        profileImageView.layer.cornerRadius = 30
        profileImageView.clipsToBounds = true
        
   
        
        
        distanceFromLabel.anchor(top: SeparatorView.bottomAnchor, left: nil, bottom: nil, right: rightAnchor, paddingTop: 6, paddingLeft: 0, paddingBottom: 0, paddingRight: 8, width: 0, height: 16)
        
        
        subtitleLabel.anchor(top: displayNameLabel.bottomAnchor, left: profileImageView.rightAnchor, bottom: nil, right: nil, paddingTop: 2, paddingLeft: 8.5, paddingBottom: 2
            , paddingRight: 4, width: 199, height: 0)
        
        
        onlineOfflineLabel.anchor(top: subtitleLabel.bottomAnchor, left: profileImageView.rightAnchor, bottom: nil, right: nil, paddingTop: 4, paddingLeft: 8.5, paddingBottom: 2
            , paddingRight: 4, width: 0, height: 0)
        
        
        
        
        
        displayNameLabel.anchor(top: self.topAnchor, left: profileImageView.rightAnchor, bottom: nil, right: nil, paddingTop: 6, paddingLeft: 8, paddingBottom: 0, paddingRight: 4, width: 200, height: 0)
        
        SeparatorView.anchor(top: topAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0.5)
        
        
        
        
        
        AccountTypeImage.anchor(top: nil, left: nil, bottom: profileImageView.bottomAnchor, right: profileImageView.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 20, height: 20)
        
        
        
        AccountTypeImage.layer.cornerRadius = 10
        AccountTypeImage.clipsToBounds = true
        
        genderAndAgeLabel.anchor(top: subtitleLabel.bottomAnchor, left: profileImageView.rightAnchor, bottom: nil, right: nil, paddingTop: 4, paddingLeft: 8.5, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        
        acceptButton.anchor(top: onlineOfflineLabel.bottomAnchor, left: leftAnchor, bottom: nil, right: nil, paddingTop: 15, paddingLeft: 10, paddingBottom: 0, paddingRight: 0, width: 140, height: 20)
        
        
        declineButton.anchor(top: onlineOfflineLabel.bottomAnchor, left: nil, bottom: nil, right: rightAnchor, paddingTop: 15, paddingLeft: 0, paddingBottom: 0, paddingRight: 10, width: 140, height: 20)
        
        
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}

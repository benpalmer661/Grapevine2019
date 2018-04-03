//
//  UserCell.swift
//  Grapevine 2017
//
//  Created by Ben Palmer on 17/7/17.
//  Copyright © 2017 Ben Palmer. All rights reserved.
//

import Foundation
import UIKit
import Firebase

class UserCell2: UITableViewCell {
    
    
    
        var message: Message? {
            didSet {
                setupNameAndProfileImage()
                
                detailTextLabel?.text = message?.text
                
                if let seconds = message?.timestamp?.doubleValue {
                    let timestampDate = Date(timeIntervalSince1970: seconds)
                    
                    let dateFormatter = DateFormatter()
                    dateFormatter.dateFormat = "hh:mm:ss a"
                    //timeLabel.text = dateFormatter.string(from: timestampDate)
                    
                    
                }
                
                
            }
        }
    
    
    
    
    fileprivate func setupNameAndProfileImage() {
        
        if let id = message?.chatPartnerId() {
            
            
            let db = Firestore.firestore()
            
            let ref = db.collection("Users").document(id)
            
                ref.getDocument { (document, error) in
                    if let document = document {
                        
                        
                        if document.exists{
                            print("Document data: \(document.data())")
                            
                           
                        
                            guard let dictionary = document.data() as? [String: Any] else { return }
                            
                            
                                
                                                        self.textLabel?.text = dictionary["Display Name"] as? String
                                
                                                        if let profileImageUrl = dictionary["profileImageUrl"] as? String {
                                                            self.profileImageView.loadImageUsingCacheWithUrlString(urlString: profileImageUrl)
                                                            
                            }
                                                            if let accountTypeImage = dictionary["AccountTypeImageURL"] as? String {
                                                                
                                                              
                                                                self.AccountTypeImage.loadImageUsingCacheWithUrlString(urlString: accountTypeImage)
                            }
                                }
                                
                    }
            }
        }
    }
    


    
    

    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        
        textLabel?.frame = CGRect(x: 60, y: textLabel!.frame.origin.y - 1, width: textLabel!.frame.width, height: textLabel!.frame.height)
        
        detailTextLabel?.frame = CGRect(x: 61, y: detailTextLabel!.frame.origin.y + 1, width: detailTextLabel!.frame.width, height: detailTextLabel!.frame.height)
        
        
    }
    
    
    
    
    
    let displayNameLabel: UILabel = {
        let label = UILabel()
        //label.text = "HH:MM:SS"
        
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = UIColor.black
        label.font = UIFont.systemFont(ofSize: 21)
        label.backgroundColor = UIColor.white
        
        return label
        
    }()
    
    
    
    let AccountTypeImage: UIImageView = {
        let AccountimageView = UIImageView()
        AccountimageView.image = UIImage(named: "Grape")
        AccountimageView.translatesAutoresizingMaskIntoConstraints = false
        // the code below makes image a circle
        //the value of 24 comes from half the width/hieght anchor constant of 48
        //AccountimageView.layer.cornerRadius = 20
        AccountimageView.layer.masksToBounds = true
        AccountimageView.contentMode = .scaleAspectFill
        
        return AccountimageView
        
    }()
    
    
    
    let moreOptionsImage: UIImageView = {
        let moreOptionsImageView = UIImageView()
        moreOptionsImageView.image = UIImage(named: "ADD BUTTON CENTRED")
        moreOptionsImageView.translatesAutoresizingMaskIntoConstraints = false
        // the code below makes image a circle
        //the value of 20 comes from half the width/hieght anchor constant of 40
        moreOptionsImageView.layer.cornerRadius = 20
        moreOptionsImageView.layer.masksToBounds = true
        moreOptionsImageView.contentMode = .scaleAspectFill
        
        return moreOptionsImageView
        
    }()
    
    
    let profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "Grape")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        // the code below makes image a circle
        //the value of 20 comes from half the width/hieght anchor constant of 40
        //imageView.layer.cornerRadius = 20
        imageView.layer.masksToBounds = true
        imageView.contentMode = .scaleAspectFill
        
        return imageView
        
    }()
    
    
    
    
    
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: .subtitle, reuseIdentifier: reuseIdentifier)
        
        addSubview(profileImageView)
       
        
        // ho to add profile image here?
        /// we can add , ios 9 constraint anchors
        //and x,y,width,height, anchors
        
        profileImageView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 8).isActive = true
        profileImageView.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        profileImageView.widthAnchor.constraint(equalToConstant: 44).isActive = true
        profileImageView.heightAnchor.constraint(equalToConstant: 44).isActive = true
     
        
        
        profileImageView.layer.cornerRadius = 22
    
        profileImageView.clipsToBounds = true
        
        
    
        addSubview(AccountTypeImage)
        
        
        
        AccountTypeImage.anchor(top: nil, left: nil, bottom: profileImageView.bottomAnchor, right: profileImageView.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 20, height: 20)
        
        
        
        AccountTypeImage.layer.cornerRadius = 10
        AccountTypeImage.clipsToBounds = true
        
     
        
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
}

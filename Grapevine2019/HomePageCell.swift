//
//  HomePageCell.swift
//  Grapevine 2017
//
//  Created by Ben Palmer on 30/9/17.
//  Copyright © 2017 Ben Palmer. All rights reserved.
//
import UIKit
import Firebase
import Foundation
import CoreLocation

class HomePageCell: UICollectionViewCell, CLLocationManagerDelegate  {
    
    

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
        

        
        
        addSubview(SeparatorView)
        addSubview(profileImageView)
            addSubview(AccountTypeImage)
        addSubview(displayNameLabel)
        addSubview(subtitleLabel)
        
        addSubview(distanceFromLabel)
        
        addSubview(genderAndAgeLabel)
        //addSubview(locationLastUpdatedLabel)
       
        
        addSubview(onlineOfflineLabel)
        
        genderAndAgeLabel.anchor(top: subtitleLabel.bottomAnchor, left: profileImageView.rightAnchor, bottom: nil, right: nil, paddingTop: 4, paddingLeft: 8.5, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        
        
        
        
        distanceFromLabel.anchor(top: SeparatorView.bottomAnchor, left: nil, bottom: nil, right: rightAnchor, paddingTop: 6, paddingLeft: 0, paddingBottom: 0, paddingRight: 8, width: 0, height: 16)
        
        
        //locationLastUpdatedLabel.anchor(top: nil , left: nil, bottom: genderAndAgeLabel.bottomAnchor, right: rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 8, width: 0, height: 0)

        subtitleLabel.anchor(top: displayNameLabel.bottomAnchor, left: profileImageView.rightAnchor, bottom: nil, right: nil, paddingTop: 2, paddingLeft: 8.5, paddingBottom: 2
            , paddingRight: 4, width: 199, height: 0)
        
        
        onlineOfflineLabel.anchor(top: subtitleLabel.bottomAnchor, left: profileImageView.rightAnchor, bottom: nil, right: nil, paddingTop: 4, paddingLeft: 8.5, paddingBottom: 2
            , paddingRight: 4, width: 0, height: 0)
        
        
        
        
        
        displayNameLabel.anchor(top: self.topAnchor, left: profileImageView.rightAnchor, bottom: nil, right: nil, paddingTop: 6, paddingLeft: 8, paddingBottom: 0, paddingRight: 4, width: 200, height: 0)
        
        SeparatorView.anchor(top: topAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0.5)
        
        
        
        
        // how to add profile image here?
        /// we can add , ios 9 constraint anchors
        //and x,y,width,height, anchors
        
       
        
        
        profileImageView.anchor(top: nil, left: leftAnchor, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 4, paddingBottom: 0, paddingRight: 0, width: 60, height: 60)
        
        profileImageView.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        
        profileImageView.layer.cornerRadius = 30
        profileImageView.clipsToBounds = true
        
        
    
        AccountTypeImage.anchor(top: nil, left: nil, bottom: profileImageView.bottomAnchor, right: profileImageView.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 20, height: 20)
        
        
       
        AccountTypeImage.layer.cornerRadius = 10
        AccountTypeImage.clipsToBounds = true
        
        
        
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    
}

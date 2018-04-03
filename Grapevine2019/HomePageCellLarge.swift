//
//  HomePageCellLarge.swift
//  Grapevine2019
//
//  Created by Ben Palmer on 27/3/18.
//  Copyright © 2018 Ben Palmer. All rights reserved.
//


import UIKit
import Firebase
import Foundation
import CoreLocation

class HomePageCellLarge: UICollectionViewCell, CLLocationManagerDelegate  {
    
    
    
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
        label.text = "ggogogogogo"
        
        return label
        
    }()
    
    
    
    
    
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        
        
        
        addSubview(SeparatorView)
        addSubview(profileImageView)
        addSubview(AccountTypeImage)
        
        addSubview(onlineOfflineLabel)
        
        addSubview(displayNameLabel)
        addSubview(subtitleLabel)
        
        addSubview(distanceFromLabel)
        
        addSubview(genderAndAgeLabel)
       
       
        
        
        profileImageView.anchor(top: topAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 300)
        
        profileImageView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        
//        profileImageView.layer.cornerRadius = 30
//        profileImageView.clipsToBounds = true
        
        
        
        
        AccountTypeImage.anchor(top: profileImageView.bottomAnchor, left: leftAnchor, bottom: nil, right: nil, paddingTop: 4, paddingLeft: 4, paddingBottom: 0, paddingRight: 0, width: 54, height: 54)
        
        
        
        AccountTypeImage.layer.cornerRadius = 27
        AccountTypeImage.clipsToBounds = true
        
        
        
        displayNameLabel.anchor(top: profileImageView.bottomAnchor, left: AccountTypeImage.rightAnchor, bottom: nil, right: nil, paddingTop: 6, paddingLeft: 12, paddingBottom: 0, paddingRight: 4, width: 200, height: 0)
        
        
        subtitleLabel.anchor(top: displayNameLabel.bottomAnchor, left: AccountTypeImage.rightAnchor, bottom: nil, right: nil, paddingTop: -2, paddingLeft: 13, paddingBottom: 2
            , paddingRight: 4, width: 199, height: 0)
        
        
        onlineOfflineLabel.anchor(top: subtitleLabel.bottomAnchor, left:AccountTypeImage.rightAnchor, bottom: nil, right: nil, paddingTop: -3, paddingLeft: 13, paddingBottom: 0
            , paddingRight: 0, width: 0, height: 20)
        
        
        
        
        
        
        genderAndAgeLabel.anchor(top: subtitleLabel.bottomAnchor, left: profileImageView.rightAnchor, bottom: nil, right: nil, paddingTop: 4, paddingLeft: 8.5, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        
        
      
        distanceFromLabel.anchor(top: profileImageView.bottomAnchor, left: nil, bottom: nil, right: rightAnchor, paddingTop: 2, paddingLeft: 0, paddingBottom: 0, paddingRight: 6, width: 0, height: 0)
        
        
       
       
        
       
        SeparatorView.anchor(top: topAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0.5)
        
        
        

        
        
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}

//
//  UserCellLargePicture.swift
//  Grapevine 2017
//
//  Created by Ben Palmer on 17/7/17.
//  Copyright © 2017 Ben Palmer. All rights reserved.
//

import Foundation
import UIKit


class UserCellLargePicture: UITableViewCell {
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    
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
        moreOptionsImageView.layer.cornerRadius = 27
        moreOptionsImageView.layer.masksToBounds = true
        moreOptionsImageView.contentMode = .scaleAspectFill
        
        return moreOptionsImageView
        
    }()
    
    
    let DisplayNameLabel: UILabel = {
        let label = UILabel()
        //label.text = "TEST TEST TEST"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let StatusLabel: UILabel = {
        let label = UILabel()
        //label.text = "TEST TEST TEST"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    
    var ProfileButton: UIButton = {
        let button = UIButton()
        //label.text = "TEST TEST TEST"
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: .subtitle, reuseIdentifier: reuseIdentifier)
        
        addSubview(profileImageView)
        
        // ho to add profile image here?
        /// we can add , ios 9 constraint anchors
        //and x,y,width,height, anchors
        
        profileImageView.topAnchor.constraint(equalTo: self.topAnchor, constant:0).isActive = true
        profileImageView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 0).isActive = true
        //profileImageView.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        profileImageView.widthAnchor.constraint(equalToConstant: 320).isActive = true
        profileImageView.heightAnchor.constraint(equalToConstant: 180).isActive = true
        
        
        addSubview(AccountTypeImage)
        
        
        //AccountTypeImage.topAnchor.constraint(equalTo: profileImageView.bottomAnchor).isActive = true
        AccountTypeImage.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 0).isActive = true
        //AccountTypeImage.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        AccountTypeImage.widthAnchor.constraint(equalToConstant: 54).isActive = true
        AccountTypeImage.heightAnchor.constraint(equalToConstant: 54).isActive = true
        AccountTypeImage.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant:0).isActive = true
        
        addSubview(moreOptionsImage)
        
        //moreOptionsImage.topAnchor.constraint(equalTo: profileImageView.bottomAnchor).isActive = true
        moreOptionsImage.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -4).isActive = true
        //moreOptionsImage.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        moreOptionsImage.widthAnchor.constraint(equalToConstant: 54).isActive = true
        moreOptionsImage.heightAnchor.constraint(equalToConstant: 54).isActive = true
        moreOptionsImage.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant:0).isActive = true
        
        
        addSubview(ProfileButton)
        
        //moreOptionsImage.topAnchor.constraint(equalTo: profileImageView.bottomAnchor).isActive = true
        ProfileButton.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -58).isActive = true
        //moreOptionsImage.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        ProfileButton.widthAnchor.constraint(equalToConstant: 54).isActive = true
        ProfileButton.heightAnchor.constraint(equalToConstant: 54).isActive = true
        ProfileButton.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant:0).isActive = true
        
        
        
        
        addSubview(DisplayNameLabel)
        
        
        // func setupViews() {
        //backgroundColor = .yellow
        
        
        
        DisplayNameLabel.frame = CGRect(x: 92, y: DisplayNameLabel.frame.origin.y - 1, width: DisplayNameLabel.frame.width, height: DisplayNameLabel.frame.height)
        
        //        textLabel!.bottomAnchor.constraint(equalTo: (detailTextLabel?.topAnchor)!,constant: 0).isActive = true
        DisplayNameLabel.topAnchor.constraint(equalTo: profileImageView.bottomAnchor,constant:6).isActive = true
        DisplayNameLabel.leftAnchor.constraint(equalTo: self.leftAnchor,constant: 56).isActive = true
        DisplayNameLabel.translatesAutoresizingMaskIntoConstraints = false
        DisplayNameLabel.font.withSize(36)
        
        
        
        addSubview(StatusLabel)
        
        StatusLabel.frame = CGRect(x: 92, y: StatusLabel.frame.origin.y - 1, width: StatusLabel.frame.width, height: StatusLabel.frame.height)
        
        //        textLabel!.bottomAnchor.constraint(equalTo: (detailTextLabel?.topAnchor)!,constant: 0).isActive = true
        
        StatusLabel.topAnchor.constraint(equalTo: DisplayNameLabel.bottomAnchor,constant:2).isActive = true
        StatusLabel.leftAnchor.constraint(equalTo: self.leftAnchor,constant: 57).isActive = true
        StatusLabel.translatesAutoresizingMaskIntoConstraints = false
        StatusLabel.font = UIFont(name: "HelveticaNeue-UltraLight",
                                  size: 15.0)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
}//class

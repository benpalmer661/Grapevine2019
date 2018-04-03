//
//  UserMessagesCell.swift
//  Grapevine 2017
//
//  Created by Ben Palmer on 22/7/17.
//  Copyright © 2017 Ben Palmer. All rights reserved.
//

import UIKit
import Firebase
import Foundation


class UserMessagesCell: UITableViewCell {
   
   
    
    
    
    
        override func layoutSubviews() {
            super.layoutSubviews()
            
            
            textLabel?.frame = CGRect(x: 92, y: textLabel!.frame.origin.y - 1, width: textLabel!.frame.width, height: textLabel!.frame.height)
            
            
            
    
            textLabel?.backgroundColor = UIColor.black
            textLabel?.textColor = UIColor.white
            
            detailTextLabel?.frame = CGRect(x: 92, y: detailTextLabel!.frame.origin.y + 1, width: detailTextLabel!.frame.width, height: detailTextLabel!.frame.height)
            
            
            
        }
    
    
    
        
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
        
        
    
    let timeLabel: UILabel = {
        let label = UILabel()
        label.text = "HH:MM:SS"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = UIColor.darkGray
        label.font = UIFont.systemFont(ofSize: 10)
        
        
        return label
        
    }()
    
    
    
    
    
        override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
            super.init(style: .subtitle, reuseIdentifier: reuseIdentifier)
            
        
            
            addSubview(timeLabel)
            
            timeLabel.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
            timeLabel.topAnchor.constraint(equalTo: self.topAnchor,constant: 2).isActive = true
//            timeLabel.centerYAnchor.constraint(equalTo:(textLabel?.centerYAnchor)!).isActive = true
            timeLabel.widthAnchor.constraint(equalToConstant: 100).isActive = true
            timeLabel.heightAnchor.constraint(equalTo: (textLabel?.heightAnchor)!).isActive = true
            
           
            addSubview(profileImageView)
            
            // how to add profile image here?
            /// we can add , ios 9 constraint anchors
            //and x,y,width,height, anchors
            
            profileImageView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 44).isActive = true
            profileImageView.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
            profileImageView.widthAnchor.constraint(equalToConstant: 44).isActive = true
            profileImageView.heightAnchor.constraint(equalToConstant: 44).isActive = true
            
            
            addSubview(AccountTypeImage)
            
            
            AccountTypeImage.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 0).isActive = true
            AccountTypeImage.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
            AccountTypeImage.widthAnchor.constraint(equalToConstant: 44).isActive = true
            AccountTypeImage.heightAnchor.constraint(equalToConstant: 44).isActive = true
            

        
        }
        
        
        required init?(coder aDecoder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        
        
        
}

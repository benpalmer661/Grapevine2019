//
//  User.swift
//  TwitterLBTA
//
//  Created by Brian Voong on 1/9/17.
//  Copyright © 2017 Lets Build That App. All rights reserved.
//

import UIKit

//
//struct User {
//    let username: String
//    let profileImageUrl: String
//    
//    init(dictionary: [String: Any]) {
//        self.username = dictionary["username"] as? String ?? ""
//        self.profileImageUrl = dictionary["profileImageUrl"]  as? String ?? ""
//    }
//}
//



class User: NSObject {
    var DisplayName: String?
    var SubtitleStatus: String?
    var profileImageURL: String?
    var accountTypeImage: String?
    var userId: String?
    var toId: String?
    var fromId: String?
    var id: String?
    var email: String?
    var uid: String?
    var accountTypeImageUrl: String
    var subtitle: String
    
   
    
    
     init(uid: String, dictionary: [String: Any]) {
 
        self.uid = uid
        self.userId = dictionary["UID"] as? String
                self.id = dictionary["id"] as? String
                self.DisplayName = dictionary["Display Name"] as? String
                self.email = dictionary["Email"] as? String
                self.profileImageURL = dictionary["profileImageUrl"] as? String
        self.accountTypeImageUrl = dictionary["AccountTypeImageURL"] as? String ?? ""
        self.subtitle = dictionary["SubtitleStatus"] as? String ?? ""
     
       
}

}



 







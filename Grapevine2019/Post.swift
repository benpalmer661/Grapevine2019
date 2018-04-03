//
//  Post.swift
//  Grapevine 2017
//
//  Created by Ben Palmer on 16/10/17.
//  Copyright © 2017 Ben Palmer. All rights reserved.
//

import Foundation

struct Post {
    
    var id: String?
    
    let user: User2
    let imageUrl: String
    let caption: String
    let creationDate: Date
    
    var hasLiked = false
    
    init(user: User2, dictionary: [String: Any]) {
        self.user = user
        self.imageUrl = dictionary["imageUrl"] as? String ?? ""
        self.caption = dictionary["caption"] as? String ?? ""
        
        let secondsFrom1970 = dictionary["creationDate"] as? Double ?? 0
        self.creationDate = Date(timeIntervalSince1970: secondsFrom1970)
    }
}

//
//  Message.swift
//  Grapevine 2017
//
//  Created by Ben Palmer on 15/7/17.
//  Copyright © 2017 Ben Palmer. All rights reserved.
//

import Foundation
import Firebase

import UIKit

class Message: NSObject {
    
    var fromId: String?
    var text: String?
    var timestamp: NSNumber?
    var toId: String?
    var imageUrl: String?
    var imageWidth: NSNumber?
    var imageHeight: NSNumber?
    var childByAutoId: String?
    
    
    
    var videoUrl: String?
    
    init(dictionary: [String: Any]) {
        super.init()
        self.fromId = dictionary["fromId"] as? String
        self.text = dictionary["text"] as? String
        self.toId = dictionary["toId"] as? String
        self.timestamp = dictionary["timestamp"] as? NSNumber
        self.childByAutoId = dictionary["childByAutoId"] as? String 
        
        self.imageUrl = dictionary["imageUrl"] as? String
        self.imageWidth = dictionary["imageWidth"] as? NSNumber
        self.imageHeight = dictionary["imageHeight"]as? NSNumber
        
        self.videoUrl = dictionary["videoUrl"] as? String
        
        
    }
    func chatPartnerId() -> String? {
        //from here
        return fromId == Auth.auth().currentUser?.uid ? toId : fromId
//        //            the above code " from here" does the same as the below code though only using one line.
//        //            if fromId == FIRAuth.auth()?.currentUser?.uid {
//        //                return toId
//        //            }else{
//        //           return fromId
//        //        }
    }


}





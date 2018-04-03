//
//  userScreenVcExtension.swift
//  Grapevine 2017
//
//  Created by Ben Palmer on 18/6/17.
//  Copyright © 2017 Ben Palmer. All rights reserved.
//

import Foundation
import UIKit


 let imageCache = NSCache<AnyObject, AnyObject>()


extension UIImageView{
    
   
    
    func loadImageUsingCacheWithUrlString(urlString: String) {
        
        
        // if images are flashing when scrolling down un comment the line below
        
        //self.image = nil
        
        //check cache for image first
        if let cachedImage = imageCache.object(forKey: urlString as AnyObject) as?
            UIImage {
            self.image = cachedImage
            return
        }
        
        // otherwise fire off a new download
        let url = URL(string: urlString)
        
        if url != nil{
        
        URLSession.shared.dataTask(with: url!, completionHandler: { (data, response, error) in
            
            //this mean download hit an error so lets return out.
            if error != nil {
                print(error!)
                return
            }
            
            DispatchQueue.main.async(execute: {
                
                if let downloadedImage = UIImage(data: data!){

                imageCache.setObject(downloadedImage,forKey:urlString as AnyObject )
                
                self.image = UIImage(data: data!)
            }
                
            })
        }).resume()
        
    }
    }
    
}//class/extension in this case

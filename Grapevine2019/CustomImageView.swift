//
//  CustomImageView.swift
//  Grapevine 2017
//
//  Created by Ben Palmer on 29/9/17.
//  Copyright © 2017 Ben Palmer. All rights reserved.
//

import UIKit

var imageCache2 = [String: UIImage]()

class CustomImageView: UIImageView {
    
    var lastURLUsedToLoadImage: String?
    
    func loadImage(urlString: String) {
        lastURLUsedToLoadImage = urlString
        
        
        
        
        self.image = nil
        
        if let cachedImage = imageCache2[urlString] {
            self.image = cachedImage
            return
        }
        
        guard let url = URL(string: urlString) else { return }
        
        URLSession.shared.dataTask(with: url) { (data, response, err) in
            if let err = err {
                print("Failed to fetch post image:", err)
                return
            }
            
            if url.absoluteString != self.lastURLUsedToLoadImage {
                return
            }
            
            guard let imageData = data else { return }
            
            let photoImage = UIImage(data: imageData)
            
            imageCache2[url.absoluteString] = photoImage
            
            DispatchQueue.main.async {
                self.image = photoImage
            }
            
            }.resume()
    }
}

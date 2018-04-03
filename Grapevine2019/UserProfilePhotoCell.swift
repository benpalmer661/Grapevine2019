//
//  UserProfilePhotoCell.swift 
//  Grapevine 2017
//
//  Created by Ben Palmer on 20/10/17.
//  Copyright © 2017 Ben Palmer. All rights reserved.


import UIKit



protocol UserProfilePhotoCellDelegate: class{
    func delete(cell:UserProfilePhotoCell)
}





class UserProfilePhotoCell: UICollectionViewCell {
    
    
    weak var delegate: UserProfilePhotoCellDelegate?

    
    
    
    var post: Post? {
        didSet {
            
            guard let imageUrl = post?.imageUrl else { return }
            
            
            photoImageView.loadImage(urlString: imageUrl)
            
            print(post?.imageUrl ?? "")
            
            
        }
    }
    
    
    
    
    
    
    
    let photoImageView: CustomImageView = {
        let iv = CustomImageView()
        iv.backgroundColor = .white
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        return iv
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(photoImageView)
        photoImageView.anchor(top: topAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

//
//  bController.swift
//  Grapevine 2017
//
//  Created by Ben Palmer on 17/12/17.
//  Copyright © 2017 Ben Palmer. All rights reserved.
//

import UIKit
import Firebase

import Foundation
import UIKit
import CoreLocation
import MapKit

import Foundation
import UIKit
import CoreLocation
import MapKit
import Firebase



class tagWordsController: UIViewController, UITextFieldDelegate {

    
    
   
   
        
        
        
        
        let defaults = UserDefaults.standard
        
       
        
    
        
    
        
    
        
    
        
        override func viewDidLoad() {
            super.viewDidLoad()
            
    
            setUpViews()
            
            view.backgroundColor = UIColor.white
        
            navigationItem.title = "TAG WORDS"
            
            
        fetchUserTagWords()
            
        }

    
    
    func fetchUserTagWords(){
        
        
        
        guard let uid = Auth.auth().currentUser?.uid else { return }
        
        
        
        Database.database().reference().child("Users").child(uid).observe(.value, with: { (snapshot) in
            
            
            guard let dictionary = snapshot.value as? [String : AnyObject] else { return }
            
            
            guard let tagWords = dictionary["Tag Words"] else { return }
            
            
            self.yourTagWordsLabel.text = tagWords as! String
            
            self.tagWordsTF.text = tagWords as! String
                
            
        }) { (err) in
            print("error fetching tagwords",err)
        }
    }
    
    
    
    
        
        
        
        private func alertTheUser(title: String , message: String) {
            
            let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
            
            let ok = UIAlertAction(title: "OK", style: .default, handler: nil);
            alert.addAction(ok);
            present(alert, animated: true, completion: nil);
        }
        
        
        
    func buttonTarget() {
        
        if let text = tagWordsTF.text
        {
            yourTagWordsLabel.text = text
        }
        
    }
        
    
    
    
   
    
    
    
    
    
    let TagWordsLabel: UILabel = {
        let v = UILabel()
        v.backgroundColor = UIColor.white
        v.text = "YOUR TAG WORDS:"
        v.textColor = UIColor.black
        v.font = UIFont.boldSystemFont(ofSize: 16.0)
        
        v.textAlignment = .center
        v.lineBreakMode = .byWordWrapping
        v.numberOfLines = 0
        
        
        return v
    }()
    
    
    
    let yourTagWordsLabel: UILabel = {
        let v = UILabel()
        v.backgroundColor = UIColor.white
        v.text = ""
        v.textColor = UIColor.black
        v.font = v.font.withSize(14)
        v.textAlignment = .center
        v.lineBreakMode = .byWordWrapping
        v.numberOfLines = 0
        
        
        return v
    }()
    
    
    
    let editTagWordsLabel: UILabel = {
        let v = UILabel()
        v.backgroundColor = UIColor.white
        v.text = "Enter tag words in the textfield below; simply leave a space between each word then click the (Save Changes) Button to save edits. The more tag words your enter the more chance you have of being seen"
        v.textColor = UIColor.black
        v.font = v.font.withSize(8)
        v.textAlignment = .center
        v.lineBreakMode = .byWordWrapping
        v.numberOfLines = 0
        
        
        
        
        return v
    }()
    
    
    
    let tagWordsTF: UITextField = {
        let tf = UITextField()
        tf.backgroundColor = UIColor.white
        tf.textColor = UIColor.black
        tf.borderStyle = .roundedRect
        tf.font = UIFont.italicSystemFont(ofSize: 10)
        tf.textAlignment = .center
        tf.text = "You have not selected any tag words."
        
        

        
        
        return tf
    }()
    
    
   
        
    
    
    lazy var saveButton: UIButton = {
        let b = UIButton(type: .system)
        b.backgroundColor = UIColor.black
        b.setTitle("Save Changes", for: .normal)
        b.setTitleColor(UIColor.white, for: .normal)
        b.addTarget(self, action: #selector(saveDetails), for: .touchUpInside)
        b.layer.cornerRadius = 3
        b.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        
        return b
    }()
    
    func saveDetails(){
        
        
        print("saving details")
        
        guard let uid = Auth.auth().currentUser?.uid else {return}
        
        guard let tagWords = self.tagWordsTF.text else { return }
        
        let values = [ "Tag Words" : tagWords]
        
        
        
        
        let ref = Database.database().reference()
        
        ref.child("Users").child(uid).updateChildValues(values) { (err, ref) in
            
            if let err = err {
                print("Failed to Update Tag Words", err)
                return
            }
            
            print("Successfully updated Tag Words")
        }
        
        
    }
        
   
        
        
    
        
        
    func temp(){
        
    }
    
            
            
    
        
        
        func setUpViews(){
            
         
            view.addSubview(TagWordsLabel)
            view.addSubview(yourTagWordsLabel)
            
           view.addSubview(tagWordsTF)
            
            view.addSubview(saveButton)
            
            view.addSubview(editTagWordsLabel)
            
            
            TagWordsLabel.anchor(top: view.topAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 100, paddingLeft: 30, paddingBottom: 0, paddingRight: 30, width: view.frame.width, height: 30)
            

            
            yourTagWordsLabel.anchor(top: TagWordsLabel.bottomAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 0, paddingLeft: 30, paddingBottom: 0, paddingRight: 30, width: view.frame.width, height: 200)
            
            editTagWordsLabel.anchor(top: yourTagWordsLabel.bottomAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 10, paddingLeft: 30, paddingBottom: 0, paddingRight: 30, width: view.frame.width, height: 30)
            
            
            tagWordsTF.anchor(top: editTagWordsLabel.bottomAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 10, paddingLeft: 20, paddingBottom: 0, paddingRight: 20, width: 200, height: 30)
            
          
            saveButton.anchor(top: tagWordsTF.bottomAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 30, paddingLeft: 85, paddingBottom: 0, paddingRight: 85, width: view.frame.width, height: 30)
            
           
        }
}



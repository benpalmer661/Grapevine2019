//
//  BRP4TagsContact.swift
//  Grapevine2018
//
//  Created by Ben Palmer on 31/12/17.
//  Copyright © 2017 Ben Palmer. All rights reserved.
//

import Foundation
import UIKit
import Firebase
import FirebaseDatabase
import FirebaseAuth
import FirebaseCore
import FirebaseStorage
import FirebaseInstanceID

class BRP4TagsContact: UIViewController, UITextFieldDelegate {
    
   
    
    
    let defaults = UserDefaults.standard
    
    
    var ref = Database.database().reference()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        
        self.hideKeyboardWhenTappedAround()
        
        UIApplication.shared.statusBarView?.backgroundColor = .white
        

    }
    
    let db = Firestore.firestore()
    

    
    func firestoreStoreSetAllServicesToTrue(){
        
        guard let uid = Auth.auth().currentUser?.uid else { return }
        
        db.collection("Users").document(uid).setData([ "All Users & Services" : true ], options: SetOptions.merge())
    
    }
    
    
    
    
    
    let PersonsIconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = UIColor.white
        imageView.translatesAutoresizingMaskIntoConstraints = false
        //imageView.layer.cornerRadius = 24
        imageView.layer.masksToBounds = true
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(named: "B icon 72x72")
        
        
        
        return imageView
        
    }()
    
    
    let PersonsAccountLabel: UILabel = {
        let label = UILabel()
        label.text = "Business Account"
        label.backgroundColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        return label
    }()
    
    
    
    
    let CellExampleImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = UIColor.white
        imageView.translatesAutoresizingMaskIntoConstraints = false
        //imageView.layer.cornerRadius = 24
        imageView.layer.masksToBounds = true
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(named: "Main Page Cell Personal")
        
        
        
        return imageView
        
    }()
    
    
    
    
    
    
    
    lazy var tagWordsTextField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "Tag Words"
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.delegate = self as UITextFieldDelegate
        tf.textAlignment = .center
        tf.font?.withSize(10)
        tf.backgroundColor = UIColor.white
        tf.textColor = UIColor.black
        tf.borderStyle = .roundedRect
        return tf
    }()
    
    
    let tagWordsTextFieldDescriptionLabel: UILabel = {
        let label = UILabel()
        label.text = "please enter tag words that describe the services you provide, the more you list the more chance you will have of being contacted, simply enter the words in any order with a space inbetween."
        label.backgroundColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.font = label.font.withSize(8)
        label.numberOfLines = 0
        return label
    }()
    
    
    lazy var contactNumberTextField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "Contact Number"
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.delegate = self as UITextFieldDelegate
        tf.textAlignment = .center
        tf.font?.withSize(10)
        tf.backgroundColor = UIColor.white
        tf.textColor = UIColor.black
        tf.borderStyle = .roundedRect
        return tf
    }()
    
    
    let contactNumberTextFieldDescriptionLabel: UILabel = {
        let label = UILabel()
        label.text = "Allows others to contact you and can also be used to reset password and provide security alerts."
        label.backgroundColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.font = label.font.withSize(8)
        label.numberOfLines = 0
        return label
    }()
    
    
    
    
    
    
    let containerView: UIView = {
        let v = UIView()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.backgroundColor = .white
        return v
    }()
    
    
    
    
    
    let scrollView: UIScrollView = {
        let v = UIScrollView()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.backgroundColor = .white
        return v
    }()
    
    
    
    
    
    lazy var nextButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = UIColor.black
        button.setTitle("Next", for: .normal)
        button.setTitleColor(UIColor.white, for: .normal)
        button.addTarget(self, action: #selector(nextButtonPressed), for: .touchUpInside)
        button.layer.cornerRadius = 3
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        
        return button
    }()
    
    
    
    
    func nextButtonPressed(){
        
       
         updateTagwords()
        updatecontactNumber()
        
        
        
        
                                let brp5 = BRP5ImageUpload()
        
                                self.present(brp5, animated: true, completion: nil)
        
    }
    
    
    
    
    let ServiceTypeLabel: UILabel = {
        let label = UILabel()
        label.text = "All Users & Services"
        label.backgroundColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        return label
    }()
    
    
    
    
    
    lazy var serviceTypeButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = UIColor.black
        button.setTitle("Select Service Type", for: .normal)
        button.setTitleColor(UIColor.white, for: .normal)
        button.addTarget(self, action: #selector(serviceTypeButtonPressed), for: .touchUpInside)
        button.layer.cornerRadius = 3
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        
        return button
    }()
    
    
    
    
    func serviceTypeButtonPressed(){
        //segue to service type selector
    }
    
    
    
    
    
    func updateTagwords(){
        
        guard let uid = Auth.auth().currentUser?.uid else { return }
        
        guard let tagWords = self.tagWordsTextField.text else { return }
        
        
        
        let db = Firestore.firestore()
        
        
        
        if tagWords != "" {
            
         
                db.collection("Users").document(uid).setData([ "Tag Words" : tagWords ], options: SetOptions.merge())
            
            
            
        }else{
            
            // do nothing
        }
        
    }
    
    
    
    
    
    func updatecontactNumber(){
        
        
        guard let uid = Auth.auth().currentUser?.uid else { return }
        
        guard let contactNumber = self.contactNumberTextField.text else { return }
        
        
        let db = Firestore.firestore()
        
        
        
        if contactNumberTextField.text != ""{
            
            
            db.collection("Users").document(uid).setData([ "Contact Number" : contactNumber ], options: SetOptions.merge())
            
            
            
        }else{
            
            // do nothing
        }
        
    }
    
   
    
    
    
    lazy var backButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = UIColor.black
        button.setTitle("Back", for: .normal)
        button.setTitleColor(UIColor.white, for: .normal)
        button.addTarget(self, action: #selector(backButtonPressed), for: .touchUpInside)
        button.layer.cornerRadius = 3
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        
        return button
    }()
    
    
    
    
    func backButtonPressed(){
        
        let brp4 = BRPServiceSelector()
        let navController = UINavigationController(rootViewController: brp4)
        self.present(navController, animated: true, completion: nil)
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    func setupViews(){
        
        
        
        // add the scroll view to self.view
        self.view.addSubview(scrollView)
        scrollView.addSubview(containerView)
        containerView.addSubview(PersonsIconImageView)
        containerView.addSubview(PersonsAccountLabel)
        containerView.addSubview(CellExampleImageView)
        containerView.addSubview(tagWordsTextField)
        containerView.addSubview(tagWordsTextFieldDescriptionLabel)
        containerView.addSubview(contactNumberTextField)
        containerView.addSubview(contactNumberTextFieldDescriptionLabel)
        containerView.addSubview(nextButton)
         containerView.addSubview(backButton)
       
        
        
        // constrain the scroll view to 8-pts on each side
        scrollView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 0).isActive = true
        scrollView.topAnchor.constraint(equalTo: view.topAnchor, constant: 0).isActive = true
        scrollView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 0).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0).isActive = true
        
        
        containerView.anchor(top: scrollView.topAnchor, left: nil, bottom: scrollView.bottomAnchor, right: nil, paddingTop: 0, paddingLeft: 0, paddingBottom: -90, paddingRight: 0, width: view.frame.width, height: 600)
        
        containerView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor).isActive = true
        
        
        PersonsIconImageView.anchor(top: containerView.topAnchor, left: nil, bottom: nil, right: nil, paddingTop: 70, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 48, height: 48)
        
        PersonsIconImageView.centerXAnchor.constraint(equalTo: containerView.centerXAnchor).isActive = true
        
        
        PersonsAccountLabel.anchor(top: PersonsIconImageView.bottomAnchor, left: nil, bottom: nil, right: nil, paddingTop: 20, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 150, height: 30)
        
        PersonsAccountLabel.centerXAnchor.constraint(equalTo: containerView.centerXAnchor).isActive = true
        
        
        CellExampleImageView.anchor(top: PersonsAccountLabel.bottomAnchor, left: nil, bottom: nil, right: nil, paddingTop: 20, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: view.frame.width, height: 50)
        
        CellExampleImageView.centerXAnchor.constraint(equalTo: containerView.centerXAnchor).isActive = true
        
        
        
        
        tagWordsTextField.anchor(top: CellExampleImageView.bottomAnchor, left: nil, bottom: nil, right: nil, paddingTop: 30, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 200, height: 25)
        
        tagWordsTextField.centerXAnchor.constraint(equalTo: containerView.centerXAnchor).isActive = true
        
        
        
        tagWordsTextFieldDescriptionLabel.anchor(top: tagWordsTextField.bottomAnchor, left: nil, bottom: nil, right: nil, paddingTop: 5, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 200, height: 30)
        
        tagWordsTextFieldDescriptionLabel.centerXAnchor.constraint(equalTo: containerView.centerXAnchor).isActive = true
        
        
        contactNumberTextField.anchor(top: tagWordsTextFieldDescriptionLabel.bottomAnchor, left: nil, bottom: nil, right: nil, paddingTop: 10, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 200, height: 25)
        
        contactNumberTextField.centerXAnchor.constraint(equalTo: containerView.centerXAnchor).isActive = true
        
        contactNumberTextFieldDescriptionLabel.anchor(top: contactNumberTextField.bottomAnchor, left: nil, bottom: nil, right: nil, paddingTop: 5, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 200, height: 30)
        
        contactNumberTextFieldDescriptionLabel.centerXAnchor.constraint(equalTo: containerView.centerXAnchor).isActive = true
        
        
        
        nextButton.anchor(top: contactNumberTextFieldDescriptionLabel.bottomAnchor, left: nil, bottom: nil, right: nil, paddingTop: 40, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 130, height: 25)
        
        nextButton.centerXAnchor.constraint(equalTo: containerView.centerXAnchor).isActive = true
        
        backButton.anchor(top: nextButton.bottomAnchor, left: nil, bottom: nil, right: nil, paddingTop: 10, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 130, height: 25)
        
        backButton.centerXAnchor.constraint(equalTo: containerView.centerXAnchor).isActive = true
        
        
        
        
        
        
    }
    
    
    
}

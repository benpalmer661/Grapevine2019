//
//  BRP3DisplaySubtitle.swift
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

class BRP3DisplaySubtitle: UIViewController, UITextFieldDelegate {
    
    
    
    var ref = Database.database().reference()
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        
        self.hideKeyboardWhenTappedAround()
        
        UIApplication.shared.statusBarView?.backgroundColor = .white
        

        
        
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
    
    
    
    
    
    
    
    lazy var displayNameTextField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "Display Name"
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.delegate = self as UITextFieldDelegate
        tf.textAlignment = .center
        tf.font?.withSize(10)
        tf.backgroundColor = UIColor.white
        tf.textColor = UIColor.black
        tf.borderStyle = .roundedRect
        return tf
    }()
    
    
    let displayNameTextFieldDescriptionLabel: UILabel = {
        let label = UILabel()
        label.text = "(Optional) Unless set your Display Name with default to your Username. Your Display Name can be changed at anytime."
        label.backgroundColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.font = label.font.withSize(8)
        label.numberOfLines = 0
        return label
    }()
    
    
    lazy var subtitleTextField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "Subtitle"
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.delegate = self as UITextFieldDelegate
        tf.textAlignment = .center
        tf.font?.withSize(10)
        tf.backgroundColor = UIColor.white
        tf.textColor = UIColor.black
        tf.borderStyle = .roundedRect
        return tf
    }()
    
    
    let subtitleTextFieldDescriptionLabel: UILabel = {
        let label = UILabel()
        label.text = "(Optional) Unless set your Subtitle Bar with default to your Username. Your Subtitle Bar can be changed at anytime."
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
        
        
        
        
     updateDisplayName()
        
updateStatusSubtitle()
        
        let brp4 = BRPServiceSelector()
        let navController = UINavigationController(rootViewController: brp4)
        self.present(navController, animated: true, completion: nil)
        
    }
    
    
    func updateStatusSubtitle(){
        
        let db = Firestore.firestore()
        
        
        guard let uid = Auth.auth().currentUser?.uid else { return }
        
        guard let statusSubtitle = self.subtitleTextField.text else { return }
        
        if subtitleTextField.text != ""{
            
            db.collection("Users").document(uid).setData(["Subtitle":statusSubtitle], options: SetOptions.merge())
            
            
            
        }else{
            
            // fetch username from data base and use
        }
        
    }
    
    
    
    
    
    func updateDisplayName(){
        guard let uid = Auth.auth().currentUser?.uid else { return }
        
        
        guard let displayName = self.displayNameTextField.text else { return }
        
        let db = Firestore.firestore()
        
        if displayNameTextField.text != ""{
            db.collection("Users").document(uid).setData(["Display Name": displayName ], options: SetOptions.merge())
            
            
        }else{
            
            // do nothing
        }
        
    }
    
    
    
    
    
    func setupViews(){
        
        
        
        // add the scroll view to self.view
        self.view.addSubview(scrollView)
        scrollView.addSubview(containerView)
        containerView.addSubview(PersonsIconImageView)
        containerView.addSubview(PersonsAccountLabel)
        containerView.addSubview(CellExampleImageView)
        containerView.addSubview(displayNameTextField)
        containerView.addSubview(displayNameTextFieldDescriptionLabel)
        containerView.addSubview(subtitleTextField)
        containerView.addSubview(subtitleTextFieldDescriptionLabel)
        containerView.addSubview(nextButton)
    
        
        
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
        
        
        
        
        displayNameTextField.anchor(top: CellExampleImageView.bottomAnchor, left: nil, bottom: nil, right: nil, paddingTop: 40, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 200, height: 25)
        
        displayNameTextField.centerXAnchor.constraint(equalTo: containerView.centerXAnchor).isActive = true
        
        
        
        displayNameTextFieldDescriptionLabel.anchor(top: displayNameTextField.bottomAnchor, left: nil, bottom: nil, right: nil, paddingTop: 5, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 200, height: 30)
        
        displayNameTextFieldDescriptionLabel.centerXAnchor.constraint(equalTo: containerView.centerXAnchor).isActive = true
        
        
        subtitleTextField.anchor(top: displayNameTextFieldDescriptionLabel.bottomAnchor, left: nil, bottom: nil, right: nil, paddingTop: 10, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 200, height: 25)
        
        subtitleTextField.centerXAnchor.constraint(equalTo: containerView.centerXAnchor).isActive = true
        
        subtitleTextFieldDescriptionLabel.anchor(top: subtitleTextField.bottomAnchor, left: nil, bottom: nil, right: nil, paddingTop: 5, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 200, height: 30)
        
        subtitleTextFieldDescriptionLabel.centerXAnchor.constraint(equalTo: containerView.centerXAnchor).isActive = true
        
        
        
        nextButton.anchor(top: subtitleTextFieldDescriptionLabel.bottomAnchor, left: nil, bottom: nil, right: nil, paddingTop: 50, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 130, height: 25)
        
        nextButton.centerXAnchor.constraint(equalTo: containerView.centerXAnchor).isActive = true
        
        
        
        
        
        
        
    }
    
    
    
}

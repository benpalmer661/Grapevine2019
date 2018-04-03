//
//  BRP2Username.swift
//  Grapevine2018
//
//  Created by Ben Palmer on 30/12/17.
//  Copyright © 2017 Ben Palmer. All rights reserved.
//


import UIKit
import Firebase
import FirebaseDatabase
import FirebaseAuth
import FirebaseCore
import FirebaseStorage
import FirebaseInstanceID

class BRP2Username: UIViewController, UITextFieldDelegate {

    
    
    
  
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        
        self.hideKeyboardWhenTappedAround()
        
        UIApplication.shared.statusBarView?.backgroundColor = .white
        

        
     
        
    }
    
    
    
    func alertTheUser(title: String , message: String) {
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let ok = UIAlertAction(title: "OK", style: .default, handler: nil);
        alert.addAction(ok);
        present(alert, animated: true, completion: nil);
    }
    
    
    
    
    
    
    let BusinessIconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = UIColor.white
        imageView.translatesAutoresizingMaskIntoConstraints = false
        //imageView.layer.cornerRadius = 24
        imageView.layer.masksToBounds = true
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(named: "B icon 72x72")
        
        return imageView
        
    }()
    
    
    let BusinessAccountLabel: UILabel = {
        let label = UILabel()
        label.text = "Business Account"
        label.backgroundColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        return label
    }()
    
    lazy var usernameTextField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "Username"
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.delegate = self as UITextFieldDelegate
        tf.textAlignment = .center
        tf.font?.withSize(10)
        tf.backgroundColor = UIColor.white
        tf.textColor = UIColor.black
        tf.borderStyle = .roundedRect
        return tf
    }()
    
    
    let usernameTextFieldDescriptionLabel: UILabel = {
        let label = UILabel()
        label.text = "This Is Your Unique User ID, Choose wisely as once set your Username cannot be changed"
        label.backgroundColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.font = label.font.withSize(8)
        label.numberOfLines = 0
        return label
    }()
    
    
  
    
    let scrollView: UIScrollView = {
        let v = UIScrollView()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.backgroundColor = .white
        return v
    }()
    
    
    let containerView: UIView = {
        let v = UIView()
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
        
         let db = Firestore.firestore()
        
        
        
        
       nextButton.isEnabled = false
        
        if usernameTextField.text != ""{
            
            guard let username = usernameTextField.text else { return }
            
            guard let uid = Auth.auth().currentUser?.uid else { return }
            
            let docRef = db.collection("Taken User Names").document(username)
            
            docRef.getDocument { (document, error) in
                if let document = document {
                    
                    
                    if document.exists{
                        print("Document data: \(document.data())")
                        
                        self.alertTheUser(title: "Username Taken", message: "please choose again")
                        
                          self.nextButton.isEnabled = true
                        
                    } else {
                        
                       
                     
                        
                        // "Account Type": "Business"
                        //"Business Account": true,
                       //"All Account Types": true
                        //"All Users & Services": true,
                        //"Online & Offline": true
                         //"All Genders": true
                       
                        db.collection("Users").document(uid).setData([ "Username" : username, "Subtitle" : username, "Display Name": username, "Business Account": true, "UID": uid, "All Users & Services": true, "Online & Offline": true, "All Genders": true,"All Account Types": true,"Account Type": "Business","Online Offline Status": "Offline" ], options: SetOptions.merge())
                        

            let brp3 = BRP3DisplaySubtitle()
            
            self.present(brp3, animated: true, completion: nil)
            
            self.nextButton.isEnabled = true
            
                    }
                }
            }
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
    
    
    
    
    func backButtonPressed() {
        
        let prp3 = AccountSelectionPage()
        //let navController = UINavigationController(rootViewController: prp3)
        self.present(prp3, animated: true, completion: nil)

        
    }
    
    
 
    
    

    
    
    
    
    
    
    
    
    
    
    func setupViews(){
        
        
        
        // add the scroll view to self.view
        self.view.addSubview(scrollView)
        scrollView.addSubview(containerView)
        containerView.addSubview(BusinessIconImageView)
        containerView.addSubview(BusinessAccountLabel)
        containerView.addSubview(usernameTextField)
        containerView.addSubview(usernameTextFieldDescriptionLabel)
        containerView.addSubview(nextButton)
        containerView.addSubview(backButton)
        
        
        
        // constrain the scroll view to 8-pts on each side
        scrollView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 0).isActive = true
        scrollView.topAnchor.constraint(equalTo: view.topAnchor, constant: 0).isActive = true
        scrollView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 0).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0).isActive = true
        
        
        
        
        
        containerView.anchor(top: scrollView.topAnchor, left: nil, bottom: scrollView.bottomAnchor, right: nil, paddingTop: 0, paddingLeft: 0, paddingBottom: -90, paddingRight: 0, width: view.frame.width, height: 600)
        
        containerView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor).isActive = true
        
        
        BusinessIconImageView.anchor(top: containerView.topAnchor, left: nil, bottom: nil, right: nil, paddingTop: 70, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 60, height: 60)
        
        BusinessIconImageView.centerXAnchor.constraint(equalTo: containerView.centerXAnchor).isActive = true
        
        
        
        
        BusinessAccountLabel.anchor(top: BusinessIconImageView.bottomAnchor, left: nil, bottom: nil, right: nil, paddingTop: 20, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 200, height: 30)
        
        BusinessAccountLabel.centerXAnchor.constraint(equalTo: containerView.centerXAnchor).isActive = true
        
        
        
        
        
        usernameTextField.anchor(top: BusinessAccountLabel.bottomAnchor, left: nil, bottom: nil, right: nil, paddingTop: 80, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 220, height: 30)
        
        usernameTextField.centerXAnchor.constraint(equalTo: containerView.centerXAnchor).isActive = true
        
        
        
        
        
        
        usernameTextFieldDescriptionLabel.anchor(top: usernameTextField.bottomAnchor, left: nil, bottom: nil, right: nil, paddingTop: 5, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 200, height: 40)
        
        usernameTextFieldDescriptionLabel.centerXAnchor.constraint(equalTo: containerView.centerXAnchor).isActive = true
        
        
        
        
        
        
        nextButton.anchor(top: usernameTextFieldDescriptionLabel.bottomAnchor, left: nil, bottom: nil, right: nil, paddingTop: 80, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 130, height: 25)
        
        nextButton.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor).isActive = true
        
        
        backButton.anchor(top: nextButton.bottomAnchor, left: nil, bottom: nil, right: nil, paddingTop: 10, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 130, height: 25)
        
        backButton.centerXAnchor.constraint(equalTo: containerView.centerXAnchor).isActive = true
        
        
        
        
    }
    
    
    
    
}

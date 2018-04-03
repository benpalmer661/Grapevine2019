//
//  EmailRegistrationPage.swift
//  Grapevine2018
//
//  Created by Ben Palmer on 2/1/18.
//  Copyright © 2018 Ben Palmer. All rights reserved.
//


import UIKit
import FirebaseAuth
import FirebaseStorage
import FirebaseDatabase
import Foundation
import Firebase
import FirebaseAnalytics
import FirebaseCore
import FirebaseInstanceID



class EmailRegistrationPage: UIViewController {
    
    var ref: DatabaseReference!
    
    var homepage: HomePage?
    
    
    
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
    
    
    
    
    let grapevineLogoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = UIColor.white
        imageView.translatesAutoresizingMaskIntoConstraints = false
        //imageView.layer.cornerRadius = 24
        imageView.layer.masksToBounds = true
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(named: "Grapevine Logo-1")
        
        
        
        return imageView
        
    }()
    
    
    
    
    
    
    lazy var emailTextField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "Email"
        tf.translatesAutoresizingMaskIntoConstraints = false
        //tf.delegate = self as! UITextFieldDelegate
        tf.textAlignment = .center
        tf.font?.withSize(10)
        tf.backgroundColor = UIColor.white
        tf.textColor = UIColor.black
        tf.borderStyle = .roundedRect
        return tf
    }()
    
    
    
    
    lazy var passwordTextField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "Password"
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.delegate = self as? UITextFieldDelegate
        tf.textAlignment = .center
        tf.font?.withSize(10)
        tf.backgroundColor = UIColor.white
        tf.textColor = UIColor.black
        tf.borderStyle = .roundedRect
        return tf
    }()
    
    
    
    let PleaseRegisterWithEmailLabel: UILabel = {
        let label = UILabel()
        label.text = "Please Register With Email"
        label.backgroundColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.font = label.font.withSize(14)
        return label
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
    
    
    
//    // Add a new document in collection "cities"
//    db.collection("cities").document("LA").setData([
//    "name": "Los Angeles",
//    "state": "CA",
//    "country": "USA"
//    ]) { err in
//    if let err = err {
//    print("Error writing document: \(err)")
//    } else {
//    print("Document successfully written!")
//    }
//    }
    
    
    
    func nextButtonPressed(){
        
        
        
        self.nextButton.isEnabled = false
        
        
        if emailTextField.text != "" && passwordTextField.text != "" {
            
            self.nextButton.isEnabled = true
            
            
            AuthProvider.Instance.registerButton(withEmail: emailTextField.text!, password: passwordTextField.text!, loginHandler: { (message) in
                
                if message != nil {
                    self.alertTheUser(title:"Problem With Authentication", message: message!);
                    
                    self.nextButton.isEnabled = true
                    
                    
                } else {
                    
                    
                    self.homepage?.firestoreFetchCurrentUser()
                    
                    guard let userID = Auth.auth().currentUser?.uid else { return }
                    
                    guard let userEmail = self.emailTextField.text else { return }
                    guard let userPassword = self.passwordTextField.text else { return }
                    
                    
                    
                    
                    
                    
                    let db = Firestore.firestore()
                    
                    
                    db.collection("Users").document(userID).setData(["Email" : userEmail, "Password" : userPassword]) { (error: Error?) in
                    
                    

                    
                        if let error = error {
                            
                            print("there was a error")
                            
                            print("\(error.localizedDescription)")
                            
                        } else { print("document was succesfully created and written")
                            
                        }
                    }
                    
                    
                    
                 
                    let ASP = AccountSelectionPage()
        
                    
                    self.present(ASP, animated: true, completion: nil)
                    
                    self.nextButton.isEnabled = true
                    
                    
                }
                
            });
            
        } else {
            
            self.nextButton.isEnabled = true
            
            alertTheUser(title: "Email and Password Are Required", message: "please enter a valid email and password")
            
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
        
        let signInVc = SignInVC()
        
        
        
        self.present(signInVc, animated: true, completion: nil)
        
    }
    
    
    
    
    
    

    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        
        ref = Database.database().reference()
        
        self.hideKeyboardWhenTappedAround()
        
        
    }
    
    
    
    
    func setupViews(){
        
        
        
        // add the scroll view to self.view
        self.view.addSubview(scrollView)
        scrollView.addSubview(containerView)
        containerView.addSubview(grapevineLogoImageView)
        
        containerView.addSubview(emailTextField)
        containerView.addSubview(passwordTextField)
               containerView.addSubview(PleaseRegisterWithEmailLabel)
        containerView.addSubview(nextButton)
        containerView.addSubview(backButton)
        
        
        // constrain the scroll view to 8-pts on each side
        scrollView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 0).isActive = true
        scrollView.topAnchor.constraint(equalTo: view.topAnchor, constant: 0).isActive = true
        scrollView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 0).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0).isActive = true
        
        
        containerView.anchor(top: scrollView.topAnchor, left: nil, bottom: scrollView.bottomAnchor, right: nil, paddingTop: 0, paddingLeft: 0, paddingBottom: -90, paddingRight: 0, width: view.frame.width, height: 600)
        
        containerView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor).isActive = true
        
        
        
        grapevineLogoImageView.anchor(top: containerView.topAnchor, left: nil, bottom: nil, right: nil, paddingTop: 80, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 300, height: 70)
        
        grapevineLogoImageView.centerXAnchor.constraint(equalTo: containerView.centerXAnchor).isActive = true
        
        
        
        
        
        
        
        emailTextField.anchor(top: grapevineLogoImageView.bottomAnchor, left: nil, bottom: nil, right: nil, paddingTop: 50, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 220, height: 25)
        
        emailTextField.centerXAnchor.constraint(equalTo: containerView.centerXAnchor).isActive = true
        
        
        
        passwordTextField.anchor(top: emailTextField.bottomAnchor, left: nil, bottom: nil, right: nil, paddingTop: 20, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 220, height: 25)
        
        passwordTextField.centerXAnchor.constraint(equalTo: containerView.centerXAnchor).isActive = true
        
        
        PleaseRegisterWithEmailLabel.anchor(top: passwordTextField.bottomAnchor, left: nil, bottom: nil, right: nil, paddingTop: 50, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 220, height: 25)
        
        PleaseRegisterWithEmailLabel.centerXAnchor.constraint(equalTo: containerView.centerXAnchor).isActive = true
        
        
        
        
        
        nextButton.anchor(top: passwordTextField.bottomAnchor, left: nil, bottom: nil, right: nil, paddingTop: 130, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 130, height: 25)
        
        nextButton.centerXAnchor.constraint(equalTo: containerView.centerXAnchor).isActive = true
        
        
        
        backButton.anchor(top: nextButton.bottomAnchor, left: nil, bottom: nil, right: nil, paddingTop: 10, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 130, height: 25)

        backButton.centerXAnchor.constraint(equalTo: containerView.centerXAnchor).isActive = true
        
        
        
        
        
        
        
    }
    
    
    
    
    
    
    
    
    
    
    
    ////portrait mode only code
    
    open override var supportedInterfaceOrientations: UIInterfaceOrientationMask{
        get {
            return .portrait
        }
    }
    
    
    
    open override var shouldAutorotate: Bool {
        get {
            return false
        }
    }
    
    
    
    open override var preferredInterfaceOrientationForPresentation: UIInterfaceOrientation{
        get {
            return .portrait
        }
    }
    
    // end of portrait mode only code
    
    
    
    
    
    @IBAction func NextButton(_ sender: Any) {
        
        
        self.nextButton.isEnabled = false
        
        
        if emailTextField.text != "" && passwordTextField.text != "" {
            
            self.nextButton.isEnabled = true
            
            
            AuthProvider.Instance.registerButton(withEmail: emailTextField.text!, password: passwordTextField.text!, loginHandler: { (message) in
                
                if message != nil {
                    self.alertTheUser(title:"Problem With Authentication", message: message!);
                    
                    self.nextButton.isEnabled = true
                    
                    
                } else {
                    
                    
                    self.homepage?.firestoreFetchCurrentUser()
                    
                    guard let userID = Auth.auth().currentUser?.uid else { return }
                    
                    guard let userEmail = self.emailTextField.text else { return }
                    guard let userPassword = self.passwordTextField.text else { return }
                    
                    
                    
                    
                    
                    
                    let db = Firestore.firestore()
                    
                 
                    db.collection("Users").document(userID).updateData(["Email" : userEmail, "Password" : userPassword]) { (error: Error?) in
                        
                        if let error = error {
                            
                            print("\(error.localizedDescription)")
                            
                        } else { print("document was succesfully created and written")
                            
                        }
                    }
                    
                    
                    
                 
                    
                    self.nextButton.isEnabled = true
                    
                    let ASP = AccountSelectionPage()
                    
                    let navController = UINavigationController(rootViewController: ASP)
                    self.present(navController, animated: true, completion: nil)
                    
                }
                
            });
            
        } else {
            
            self.nextButton.isEnabled = true
            
            alertTheUser(title: "Email and Password Are Required", message: "please enter a valid email and password")
            
        }
        
    }
    
    
    
    
    
    
    
    private func alertTheUser(title: String , message: String) {
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let ok = UIAlertAction(title: "OK", style: .default, handler: nil);
        alert.addAction(ok);
        present(alert, animated: true, completion: nil);
    }
    
    
    
}//class











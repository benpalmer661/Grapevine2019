//
//  SignInVC.swift
//  Grapevine2018
//
//  Created by Ben Palmer on 29/12/17.
//  Copyright © 2017 Ben Palmer. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAnalytics
import FirebaseCore
import FirebaseInstanceID
import Foundation
import FirebaseAuth

class SignInVC: UIViewController {
    
    var HomePage: HomePage?

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        HomePage?.SetDefaultsForUserSearchRefinementsIfNil()
        
        
        let tapGesture = UITapGestureRecognizer(target: self, action:      #selector(SignInVC.hideKeyboard))
        tapGesture.cancelsTouchesInView = true
        view.addGestureRecognizer(tapGesture)
         setupViews()
        }


    
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
    
    
 
    
    lazy var dontHaveAnAccountButton: UIButton = {
        let button = UIButton(type: .system)
      
        button.setTitle("Don't have an account?", for: .normal)
        button.setTitleColor(UIColor.black, for: .normal)
        button.addTarget(self, action: #selector(dontHaveAnAccountButtonPressed), for: .touchUpInside)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        
        return button
    }()
    
    
    func dontHaveAnAccountButtonPressed() {
    
        let ERP = EmailRegistrationPage()

        //let navController = UINavigationController(rootViewController: ERP)
        self.present(ERP, animated: true, completion: nil)
        
        
    
    }
    
    
    
    lazy var loginButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = UIColor.black
        button.setTitle("Log In", for: .normal)
        button.setTitleColor(UIColor.white, for: .normal)
        button.addTarget(self, action: #selector(LoginButtonPressed), for: .touchUpInside)
        button.layer.cornerRadius = 3
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        
        return button
    }()
    
    
    
    
    func LoginButtonPressed(){
        if emailTextField.text != "" && passwordTextField.text != "" {
            
            
            AuthProvider.Instance.loginButton(withEmail: emailTextField.text!, Password: passwordTextField.text!, LoginHandler: {(message) in
                
                if message != nil {
                    self.alertTheUser(title:"Problem With Authentication", message: message!);
                    
                } else {
                    guard (UIApplication.shared.keyWindow?.rootViewController as? CustomTabBarController) != nil else { return }
                    
                    self.HomePage?.firestoreFetchCurrentUser()
                    
                    let rootController = CustomTabBarController()
                    
                    self.present(rootController, animated: true, completion: nil)
                    
                }
                
            });
            
        } else { alertTheUser(title: "Email and Password Are Required", message: "please enter a valid email and password or if you do not yet have an account please register :)")
            
        }
    }
    

    

    func setupViews(){
        
        
        
        // add the scroll view to self.view
        self.view.addSubview(scrollView)
        scrollView.addSubview(containerView)
        containerView.addSubview(grapevineLogoImageView)
    
        containerView.addSubview(emailTextField)
        containerView.addSubview(passwordTextField)
             containerView.addSubview(loginButton)
        containerView.addSubview(dontHaveAnAccountButton)
        
        
        // constrain the scroll view to 8-pts on each side
        scrollView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 0).isActive = true
        scrollView.topAnchor.constraint(equalTo: view.topAnchor, constant: 0).isActive = true
        scrollView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 0).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0).isActive = true
        
        
        containerView.anchor(top: scrollView.topAnchor, left: nil, bottom: scrollView.bottomAnchor, right: nil, paddingTop: 0, paddingLeft: 0, paddingBottom: -90, paddingRight: 0, width: view.frame.width, height: 600)
        
        containerView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor).isActive = true
        
        
        
        grapevineLogoImageView.anchor(top: containerView.topAnchor, left: nil, bottom: nil, right: nil, paddingTop: 80, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 300, height: 70)
        
        grapevineLogoImageView.centerXAnchor.constraint(equalTo: containerView.centerXAnchor).isActive = true
        
        
        
        
   
        
        
        emailTextField.anchor(top: grapevineLogoImageView.bottomAnchor, left: nil, bottom: nil, right: nil, paddingTop: 60, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 220, height: 25)
        
        emailTextField.centerXAnchor.constraint(equalTo: containerView.centerXAnchor).isActive = true
        
        
        
        passwordTextField.anchor(top: emailTextField.bottomAnchor, left: nil, bottom: nil, right: nil, paddingTop: 20, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 220, height: 25)
        
        passwordTextField.centerXAnchor.constraint(equalTo: containerView.centerXAnchor).isActive = true
        
        
     
   
        
        
        loginButton.anchor(top: passwordTextField.bottomAnchor, left: nil, bottom: nil, right: nil, paddingTop: 80, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 130, height: 25)
        
        loginButton.centerXAnchor.constraint(equalTo: containerView.centerXAnchor).isActive = true
        
        
        
        dontHaveAnAccountButton.anchor(top: loginButton.bottomAnchor, left: nil, bottom: nil, right: nil, paddingTop: 50, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 200, height: 30)
        
        dontHaveAnAccountButton.centerXAnchor.constraint(equalTo: containerView.centerXAnchor).isActive = true
        
        
        
        
        
        
        
    }
    

    
    
    
    
    
    func hideKeyboard() {
        view.endEditing(true)
    }
    
    
    
    
    
    
    
    
    @IBAction func loginButton(_ sender: Any) {
        
        if emailTextField.text != "" && passwordTextField.text != "" {
            
            
            AuthProvider.Instance.loginButton(withEmail: emailTextField.text!, Password: passwordTextField.text!, LoginHandler: {(message) in
                
                if message != nil {
                    self.alertTheUser(title:"Problem With Authentication", message: message!);
                    
                } else {
                    guard (UIApplication.shared.keyWindow?.rootViewController as? CustomTabBarController) != nil else { return }
                    
                    self.HomePage?.firestoreFetchCurrentUser()
                    
                    let rootController = CustomTabBarController()
                    
                    self.present(rootController, animated: true, completion: nil)
                    
                }
                
            });
            
        } else { alertTheUser(title: "Email and Password Are Required", message: "please enter a valid email and password or if you do not yet have an account please register :)")
            
        }
}

    
    
    
    
    private func alertTheUser(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert);
        
        let ok = UIAlertAction(title: "ok", style: .default,handler: nil);
        alert.addAction(ok);
        present(alert, animated: true, completion: nil);
        
        
        
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
    
    
    
    
    
    
    
}//class









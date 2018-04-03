//
//  AuthProvider.swift
//  Grapevine2018
//
//  Created by Ben Palmer on 29/12/17.
//  Copyright © 2017 Ben Palmer. All rights reserved.
//

import Foundation
import UIKit
import FirebaseAuth
import FirebaseCore
import FirebaseStorage
import FirebaseDatabase
import FirebaseInstanceID

typealias LoginHandler = (_ msg: String?) -> Void;

struct LoginErrorCode {
    
    static let INVALID_EMAIL = "Invalid Email Address, Please  Provide A Real Email Address";
    
    static let WRONG_PASSWORD = "Incorrect Password, Please Enter The Correct Password";
    
    static let PROBLEM_CONNECTING = "Problem Connecting To The Database, Please Try Again Later";
    
    static let USER_NOT_FOUND = "User Not Found, Please Register"
    
    static let EMAIL_ALREADY_IN_USE = "Email Already In Use, Please Login or Use Another Email"
    
    static let WEAK_PASSWORD = "Password Should Be At Least 6 Characters Long"
    
}


var ref: DatabaseReference?
class AuthProvider: UIViewController {
    
    
    
    private static let _instance = AuthProvider();
    
    // static var below; we have created  an instance/object with in the class itself.
    // now we are returning a getthered to return the object.
    static var Instance: AuthProvider {
        return _instance;
    }
    
    
    let databaseReference = Database.database().reference()
    let storageRef = Storage.storage().reference()
    
    let user = Auth.auth().currentUser?.uid
    
    override func viewDidLoad(){
        
        ref = Database.database().reference()
        
    }
    
    func loginButton(withEmail: String,Password: String, LoginHandler: LoginHandler?) {
        
        Auth.auth().signIn(withEmail: withEmail, password: Password, completion: { (user, error) in
            
            if error != nil {
                
                self.handleErrors(err: error! as NSError,
                                  LoginHandler: LoginHandler);
            }else{
                
                LoginHandler?(nil);
            }
            
            
        });
        
    }// login func
    
    // let userinfo =
    
    
    func registerButton(withEmail: String, password: String, loginHandler: LoginHandler?){
        
        Auth.auth().createUser(withEmail: withEmail, password: password, completion: { (user, err) in
            
            
            if err != nil {
                
                
                self.handleErrors(err: err! as NSError, LoginHandler: loginHandler);
                
            } else {
                
                
                
                if user?.uid != nil {
                    
                    
                    
                    // after we create the user succefully we sign in the user
                    self.loginButton(withEmail: withEmail, Password: password, LoginHandler: loginHandler);
                    
                }
                
            }
            
        });
        
    }// sign up func
    
    
    //
    
    
    
    
    
    
    
    
    
    func logOut() -> Bool {
        if Auth.auth().currentUser != nil  {
            do {
                try Auth.auth().signOut();
                return true;
            } catch {
                return false;
                
            }
        }
        
        return true;
    }
    
    
    private func handleErrors(err: NSError, LoginHandler:
        LoginHandler?){
        
        
        if let errCode = AuthErrorCode(rawValue: err.code) {
            
            switch errCode {
                
                
            case .emailAlreadyInUse:
                LoginHandler?(LoginErrorCode.EMAIL_ALREADY_IN_USE);
                break;
                
            case .wrongPassword:
                LoginHandler?(LoginErrorCode.WRONG_PASSWORD);
                break;
                
                
            case .invalidEmail:
                LoginHandler?(LoginErrorCode.INVALID_EMAIL);
                break;
                
            case .userNotFound:
                LoginHandler?(LoginErrorCode.USER_NOT_FOUND);
                break;
                
                
                
            default:
                LoginHandler?(LoginErrorCode.PROBLEM_CONNECTING);
                break;
                
            }
        }
        
    }
    
    
    
    
}//class


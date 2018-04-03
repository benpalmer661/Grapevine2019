//
//  BRP5ImageUpload.swift
//  Grapevine2018
//
//  Created by Ben Palmer on 31/12/17.
//  Copyright © 2017 Ben Palmer. All rights reserved.
//



import Foundation
import UIKit
import UIKit
import Firebase
import FirebaseDatabase
import FirebaseAuth
import FirebaseCore
import FirebaseStorage
import FirebaseInstanceID

class BRP5ImageUpload: UIViewController,UINavigationControllerDelegate, UIImagePickerControllerDelegate {
        
    
        
        var activityIndicator:UIActivityIndicatorView = UIActivityIndicatorView()
        
        
        
        func activityIndicatorStart(){
            activityIndicator.center = self.view.center
            activityIndicator.hidesWhenStopped = true
            activityIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.gray
            view.addSubview(activityIndicator)
            
            activityIndicator.startAnimating()
            
        }
        
        func activityIndicatorFinish(){
            activityIndicator.stopAnimating()
            
        }
        
        
        private let to_Home_Page_FB = "toHomePageFB";
        
        
        var ref: DatabaseReference!
        let storageRef = Storage.storage().reference()
        let metaData = StorageMetadata()
        let userId = Auth.auth().currentUser?.uid
        
        
        
    
        
        
        
        override func viewDidLoad() {
            super.viewDidLoad()
            
            setupViews()
            
            self.hideKeyboardWhenTappedAround()
            
            UIApplication.shared.statusBarView?.backgroundColor = .white
            

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
        
        
        
        /// i put any IBaction, methods and segues below the view did load/below here
        
        
        
        
        
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
            
            var selectedImageFromPicker: UIImage?
            
            if let editedImage = info["UIImagePickerControllerEditedImage"] as? UIImage {
                selectedImageFromPicker = editedImage
            } else if let originalImage = info["UIImagePickerControllerOriginalImage"] as? UIImage {
                
                selectedImageFromPicker = originalImage
            }
            
            if let selectedImage = selectedImageFromPicker {
                profileImageView.image = selectedImage
            }
            
            dismiss(animated: true, completion: nil)
            
            
        }
        
        
        
        func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
            print("canceled picker")
            dismiss(animated: true, completion: nil)
        }
        
        
        
    
   
    
        func SubmitButton() {
            
            submitButtonADD()
            
            activityIndicatorStart()
            
            guard let uid = Auth.auth().currentUser?.uid else { return }
            let imageName = NSUUID().uuidString
            let storageRef = Storage.storage().reference().child("profile images").child("\(imageName)png")
            
            if let uploadData = UIImagePNGRepresentation(self.profileImageView.image!) {
                
                storageRef.putData(uploadData, metadata: nil, completion: { (metadata, error) in
                    
                    if let error = error {
                        print(error)
                        return
                    }
                    
                    if let profileImageUrl = metadata?.downloadURL()?.absoluteString {
                        
//
                     
                        let db = Firestore.firestore()
                        
                        db.collection("Users").document(uid).setData(["profileImageUrl": profileImageUrl], options: SetOptions.merge())
                        
                        
                        
                        guard (UIApplication.shared.keyWindow?.rootViewController as? CustomTabBarController) != nil else { return }
                        
                        let rootController = CustomTabBarController()
                        
                        
                        
                        self.present(rootController, animated: true, completion: nil)
                        
                        
                       
                        self.activityIndicatorFinish()
                    }
                })
            }
        }
    
    
    
   
        
        func submitButtonADD(){
            
            let imageName = NSUUID().uuidString
            let storageRef = Storage.storage().reference().child("Account Type Images").child("\(imageName)png")
            guard let uid = Auth.auth().currentUser?.uid else { return }
            
          
            
            if let uploadData = UIImagePNGRepresentation(UIImage(named:"B icon 72x72 white outline")!) {
                
                storageRef.putData(uploadData, metadata: nil, completion: { (metadata, error) in
                    
                    if let error = error {
                        print(error)
                        return
                    }
                    
                    if let AccountTypeImageURL = metadata?.downloadURL()?.absoluteString {
                        
                      
                        
                        let db = Firestore.firestore()
                        
                        db.collection("Users").document(uid).setData(["AccountTypeImageURL": AccountTypeImageURL], options: SetOptions.merge())
                        
                      
                        
                        
                    }
                })
            }
            
            
            
        }
        
        
        
        
        fileprivate func registerUserIntoDatabaseWithUID(_ uid: String, values: [String: AnyObject]) {
            
            let userId = Auth.auth().currentUser?.uid
            let ref = Database.database().reference()
            let usersReference = ref.child("Users").child(userId!)
            
            usersReference.updateChildValues(values, withCompletionBlock: { (err, ref) in
                
                if let err = err {
                    print(err)
                    return
                }
                
                //self.dismiss(animated: true, completion: nil)
            })
            
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
    
    
    
    let profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = UIColor.white
        imageView.translatesAutoresizingMaskIntoConstraints = false
        //imageView.layer.cornerRadius = 24
        imageView.layer.masksToBounds = true
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(named: "profiledefault")
            
        
        
        return imageView
        
    }()
    
    
    
    
    let uploadProfileImageDescriptionLabel: UILabel = {
        let label = UILabel()
        label.text = "(Optional)"
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
    
    
    
    
    
    
    
    lazy var uploadProfileImageButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = UIColor.black
        button.setTitle("Upload Profile Image", for: .normal)
        button.setTitleColor(UIColor.white, for: .normal)
        button.addTarget(self, action: #selector(UploadProfileImageButton), for: .touchUpInside)
        button.layer.cornerRadius = 3
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        
        return button
    }()
    
    
    func UploadProfileImageButton() {
        
        let picker = UIImagePickerController()
        
        picker.delegate = self
        picker.allowsEditing = true
        picker.sourceType = UIImagePickerControllerSourceType.photoLibrary
        self.present(picker, animated: true, completion: nil)
    }
    
    
    
    
    
    
    
    
    lazy var submitButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = UIColor.black
        button.setTitle("Submit", for: .normal)
        button.setTitleColor(UIColor.white, for: .normal)
        button.addTarget(self, action: #selector(submitButtonPressed), for: .touchUpInside)
        button.layer.cornerRadius = 3
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        
        return button
    }()
    
    
    
    
    func submitButtonPressed(){
    
        
        submitButtonADD()
       SubmitButton()
        
        
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
        
        let prp5 = BRP4TagsContact()
        //let navController = UINavigationController(rootViewController: prp5)
        self.present(prp5, animated: true, completion: nil)
        
        
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    func setupViews(){
        
        
        
        // add the scroll view to self.view
        self.view.addSubview(scrollView)
        scrollView.addSubview(containerView)
        
        
        containerView.addSubview(PersonsIconImageView)
        containerView.addSubview(PersonsAccountLabel)
        containerView.addSubview(profileImageView)
        containerView.addSubview(uploadProfileImageButton)
        containerView.addSubview(uploadProfileImageDescriptionLabel)
        containerView.addSubview(submitButton)
        containerView.addSubview(backButton)
        
        
        // constrain the scroll view to 8-pts on each side
        scrollView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 0).isActive = true
        scrollView.topAnchor.constraint(equalTo: view.topAnchor, constant: 0).isActive = true
        scrollView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 0).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0).isActive = true
        
        
        containerView.anchor(top: scrollView.topAnchor, left: nil, bottom: scrollView.bottomAnchor, right: nil, paddingTop: 0, paddingLeft: 0, paddingBottom: -90, paddingRight: 0, width: view.frame.width, height: 600)
        
        containerView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor).isActive = true
        
        
        PersonsIconImageView.anchor(top: containerView.topAnchor, left: nil, bottom: nil, right: nil, paddingTop: 60, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 48, height: 48)
        
        PersonsIconImageView.centerXAnchor.constraint(equalTo: containerView.centerXAnchor).isActive = true
        
        
        
        PersonsAccountLabel.anchor(top: PersonsIconImageView.bottomAnchor, left: nil, bottom: nil, right: nil, paddingTop: 20, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 150, height: 25)
        
        PersonsAccountLabel.centerXAnchor.constraint(equalTo: containerView.centerXAnchor).isActive = true
        
        
        
        
        
        profileImageView.anchor(top: PersonsAccountLabel.bottomAnchor, left: nil, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 225, height: 225)
        
        profileImageView.centerXAnchor.constraint(equalTo: containerView.centerXAnchor).isActive = true
        
        
        
        
        
        uploadProfileImageButton.anchor(top: profileImageView.bottomAnchor, left: nil, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 200, height: 30)
        
        uploadProfileImageButton.centerXAnchor.constraint(equalTo: containerView.centerXAnchor).isActive = true
        
        
        
        uploadProfileImageDescriptionLabel.anchor(top: uploadProfileImageButton.bottomAnchor, left: nil, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 200, height: 30)
        
        uploadProfileImageDescriptionLabel.centerXAnchor.constraint(equalTo: containerView.centerXAnchor).isActive = true
        
        
        
        
        submitButton.anchor(top: uploadProfileImageDescriptionLabel.bottomAnchor, left: nil, bottom: nil, right: nil, paddingTop: 20, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 130, height: 25)
        
        submitButton.centerXAnchor.constraint(equalTo: containerView.centerXAnchor).isActive = true
        
        
        
        
        backButton.anchor(top: submitButton.bottomAnchor, left: nil, bottom: nil, right: nil, paddingTop: 10, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 130, height: 25)
        
        backButton.centerXAnchor.constraint(equalTo: containerView.centerXAnchor).isActive = true
        
        
        
        
        
        
        
    }
    
}

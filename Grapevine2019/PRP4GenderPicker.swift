//
//  PRP4GenderPicker.swift
//  Grapevine2018
//
//  Created by Ben Palmer on 1/1/18.
//  Copyright © 2018 Ben Palmer. All rights reserved.
//



import Foundation
import UIKit
import Firebase
import FirebaseDatabase
import FirebaseAuth
import FirebaseCore
import FirebaseStorage
import FirebaseInstanceID

class PRP4GenderPicker: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {
        
        
    
        //var genderPicker: UIPickerView!
    
    
    
    
    let pickerView: UIPickerView = {
        let v = UIPickerView()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.backgroundColor = .white
        v.delegate = self as? UIPickerViewDelegate
        
        return v
    }()
    

 
    
    
    
    
    
        
        var genderPickerViewArray = [ "","Male","Female"]
        
        var selectedGender: String? = nil
    
        
        var ref: DatabaseReference!
        
        
        override func viewDidLoad() {
            super.viewDidLoad()
            
            setupViews()
            
            self.hideKeyboardWhenTappedAround()
            
            UIApplication.shared.statusBarView?.backgroundColor = .white
            

            
            
            
            pickerView.delegate = self
            pickerView.dataSource = self
            
            
            ref = Database.database().reference()
            
            
        }//view did load
        
        
        
        
        
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
        
    
        
        
        func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
            if pickerView == pickerView{ return genderPickerViewArray[row]
            } else {
                return ""
                
            }
        }
        
        
        
        
        
        func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
            if pickerView == pickerView{
                return genderPickerViewArray.count
            } else {
                return 1
            }
            
        }
        
        
        func numberOfComponents(in pickerView: UIPickerView) -> Int {
            return 1
        }
        
        
        
        
        
        func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
            guard row < genderPickerViewArray.count else {
                return
            }
            
            let db = Firestore.firestore()
            
            
            
            guard let uid = Auth.auth().currentUser?.uid else { return }
            
            selectedGender = genderPickerViewArray[row].lowercased()
            
            if selectedGender == "male" {
                
                print(" selected gender is", selectedGender, "is Male")
                db.collection("Users").document(uid).setData([ "Female" : false, "Male": true, "Gender": "Male"], options: SetOptions.merge())
                
                
            }else if selectedGender == "female"{
            
                
                print(" selected gender is", selectedGender, "is Female")
                
        
           db.collection("Users").document(uid).setData([ "Female" : true, "Male": false, "Gender": "Female"], options: SetOptions.merge())
            }
            
        }
    
    
    
    
    
        
        
        private func alertTheUser(title: String , message: String) {
            
            let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
            
            let ok = UIAlertAction(title: "OK", style: .default, handler: nil);
            alert.addAction(ok);
            present(alert, animated: true, completion: nil);
        }
        
        
    
    
    
    
    
    
    let PersonsIconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = UIColor.white
        imageView.translatesAutoresizingMaskIntoConstraints = false
        //imageView.layer.cornerRadius = 24
        imageView.layer.masksToBounds = true
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(named: "P icon-72x72")
        
        return imageView
        
    }()
    
    
    let PersonsAccountLabel: UILabel = {
        let label = UILabel()
        label.text = "Person's Account"
        label.backgroundColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
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
        
        
        if selectedGender != "" && selectedGender != nil {
            
            if Auth.auth().currentUser != nil  {
                
                
                let prp5 = PRP5AgePicker()
                
                //let navController = UINavigationController(rootViewController: prp5)
                self.present(prp5, animated: true, completion: nil)
                
                
                
            }// END OF - if FIRAuth.auth()?.currentUser != nil
            
        } else { alertTheUser(title: "Gender not selected", message: "please select a gender")
            
            
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
        
        let prp3 = PRP3DisplaySubtitle()
        //let navController = UINavigationController(rootViewController: prp3)
        self.present(prp3, animated: true, completion: nil)
        
    }
    
    
    
    
    
    
    
    
    
    
    
    func setupViews(){
        
        
        
        // add the scroll view to self.view
        self.view.addSubview(scrollView)
        scrollView.addSubview(containerView)
        containerView.addSubview(PersonsIconImageView)
        containerView.addSubview(PersonsAccountLabel)
        containerView.addSubview(pickerView)
        
        containerView.addSubview(nextButton)
        containerView.addSubview(backButton)
        
        
        scrollView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 0).isActive = true
        scrollView.topAnchor.constraint(equalTo: view.topAnchor, constant: 0).isActive = true
        scrollView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 0).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0).isActive = true
        
        
        containerView.anchor(top: scrollView.topAnchor, left: nil, bottom: scrollView.bottomAnchor, right: nil, paddingTop: 0, paddingLeft: 0, paddingBottom: -90, paddingRight: 0, width: view.frame.width, height: 600)
        
        containerView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor).isActive = true
        
        
        PersonsIconImageView.anchor(top: containerView.topAnchor, left: nil, bottom: nil, right: nil, paddingTop: 60, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 48, height: 48)
        
        PersonsIconImageView.centerXAnchor.constraint(equalTo: containerView.centerXAnchor).isActive = true
        
        
        PersonsAccountLabel.anchor(top: PersonsIconImageView.bottomAnchor, left: nil, bottom: nil, right: nil, paddingTop: 20, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 150, height: 30)
        
        PersonsAccountLabel.centerXAnchor.constraint(equalTo: containerView.centerXAnchor).isActive = true
        
        
       
        
        pickerView.anchor(top: PersonsAccountLabel.bottomAnchor, left: nil, bottom: nil, right: nil, paddingTop: 20, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: view.frame.width, height: 200)
        
        pickerView.centerXAnchor.constraint(equalTo: containerView.centerXAnchor).isActive = true
        
 
        
        nextButton.anchor(top: pickerView.bottomAnchor, left: nil, bottom: nil, right: nil, paddingTop: 40, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 130, height: 25)
        
        nextButton.centerXAnchor.constraint(equalTo: containerView.centerXAnchor).isActive = true
        
        backButton.anchor(top: nextButton.bottomAnchor, left: nil, bottom: nil, right: nil, paddingTop: 10, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 130, height: 25)
        
        backButton.centerXAnchor.constraint(equalTo: containerView.centerXAnchor).isActive = true
        
        
        
        
        
        
        
    }
    
    
    
}

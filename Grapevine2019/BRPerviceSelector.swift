//
//  BRPServiceSelector.swift
//  Grapevine2019
//
//  Created by Ben Palmer on 2/2/18.
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

class BRPServiceSelector: UIViewController, UITextFieldDelegate{
    
    
    let defaults = UserDefaults.standard
    
    
    var ref = Database.database().reference()
    
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = true
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        
        self.navigationController?.isNavigationBarHidden = true
        
        self.hideKeyboardWhenTappedAround()
        
        UIApplication.shared.statusBarView?.backgroundColor = .white
        
        
        
        
    }
    
    
    
    
    
    
    let businessAccountIconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = UIColor.white
        imageView.translatesAutoresizingMaskIntoConstraints = false
        //imageView.layer.cornerRadius = 24
        imageView.layer.masksToBounds = true
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(named: "B icon 72x72")
        
        
        
        return imageView
        
    }()
    
    
    let businessAccountLabel: UILabel = {
        let label = UILabel()
        label.text = "Business Account"
        label.backgroundColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        return label
    }()
    
    
    
    
        
    
    
    lazy var serviceSelectorButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = UIColor.black
        button.setTitle("Select A Service Type?", for: .normal)
        button.setTitleColor(UIColor.white, for: .normal)
        button.addTarget(self, action: #selector(presentServiceSelector), for: .touchUpInside)
        button.layer.cornerRadius = 3
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        
        return button
    }()
    
    
    
    
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
        
        let brp4 = BRP3DisplaySubtitle()
//        let navController = UINavigationController(rootViewController: brp4)
        self.present(brp4, animated: true, completion: nil)
    }

    
    
    
    
    
    
    
    func presentServiceSelector(){
        
        let msts = MyServiceTypeSelector()
        //let navController = UINavigationController(rootViewController: msts)
        //self.present(navController, animated: true, completion: nil)
        
        self.navigationController?.pushViewController(msts, animated: true)
   
        self.navigationController?.isNavigationBarHidden = false
        

        
        
    }
    
    
    
    let serviceSelectorDescriptionLabel: UILabel = {
        let label = UILabel()
        label.text = "If you wish to be found by other users seeking a service it is important to set a service type, multiple service types and be selected"
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
        
        let brp4 = BRP4TagsContact()
        //let navController = UINavigationController(rootViewController: brp4)
        self.present(brp4, animated: true, completion: nil)
        
        
        
        guard let serviceTypeHasBeenSelected = self.defaults.string(forKey: "AServiceTypeHasBeenSelected") else { return }
        
       
        if serviceTypeHasBeenSelected != "true"{
            
            
            
            alertTheUser(title: "You have not selected a service type!", message: "Not selecting a service type means it is unlikely you will be found by other user seeking a given service.")
            
            
        } else {
            print("service type was = to true")
        }
        
        
       
       
    }
    
    
    private func alertTheUser(title: String , message: String) {
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let ok = UIAlertAction(title: "OK", style: .default, handler: nil);
        alert.addAction(ok);
        present(alert, animated: true, completion: nil);
    }
    
    
    
    
    
    
    func setupViews(){
        
        
        
        // add the scroll view to self.view
        self.view.addSubview(scrollView)
        scrollView.addSubview(containerView)
        containerView.addSubview(businessAccountIconImageView)
        containerView.addSubview(businessAccountLabel)
        containerView.addSubview(serviceSelectorButton)
        containerView.addSubview(serviceSelectorDescriptionLabel)
        containerView.addSubview(nextButton)
        containerView.addSubview(backButton)
        
        
        
        
        
        // constrain the scroll view to 8-pts on each side
        scrollView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 0).isActive = true
        scrollView.topAnchor.constraint(equalTo: view.topAnchor, constant: 0).isActive = true
        scrollView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 0).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0).isActive = true
        
        
        containerView.anchor(top: scrollView.topAnchor, left: nil, bottom: scrollView.bottomAnchor, right: nil, paddingTop: 0, paddingLeft: 0, paddingBottom: -90, paddingRight: 0, width: view.frame.width, height: 600)
        
        containerView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor).isActive = true
        
        
        businessAccountIconImageView.anchor(top: containerView.topAnchor, left: nil, bottom: nil, right: nil, paddingTop: 70, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 48, height: 48)
        
        businessAccountIconImageView.centerXAnchor.constraint(equalTo: containerView.centerXAnchor).isActive = true
        
        
        businessAccountLabel.anchor(top: businessAccountIconImageView.bottomAnchor, left: nil, bottom: nil, right: nil, paddingTop: 20, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 150, height: 30)
        
        businessAccountLabel.centerXAnchor.constraint(equalTo: containerView.centerXAnchor).isActive = true
        
        
        
        
        serviceSelectorButton.anchor(top: businessAccountLabel.bottomAnchor, left: nil, bottom: nil, right: nil, paddingTop: 50, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 220, height: 25)
        
        serviceSelectorButton.centerXAnchor.constraint(equalTo: containerView.centerXAnchor).isActive = true
        
        
        
        
        
        serviceSelectorDescriptionLabel.anchor(top: serviceSelectorButton.bottomAnchor, left: nil, bottom: nil, right: nil, paddingTop: 4, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 200, height: 30)
        
        serviceSelectorDescriptionLabel.centerXAnchor.constraint(equalTo: containerView.centerXAnchor).isActive = true
        
        
        
        nextButton.anchor(top: serviceSelectorDescriptionLabel.bottomAnchor, left: nil, bottom: nil, right: nil, paddingTop: 50, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 130, height: 25)
        
        nextButton.centerXAnchor.constraint(equalTo: containerView.centerXAnchor).isActive = true
        
        
        
        backButton.anchor(top: nextButton.bottomAnchor, left: nil, bottom: nil, right: nil, paddingTop: 10, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 130, height: 25)
        
        backButton.centerXAnchor.constraint(equalTo: containerView.centerXAnchor).isActive = true
        
        
        
        
        
        
        
    }
    
    
    
}

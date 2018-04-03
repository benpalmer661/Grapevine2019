//
//  AccountSelectionPage.swift
//  Grapevine2018
//
//  Created by Ben Palmer on 2/1/18.
//  Copyright © 2018 Ben Palmer. All rights reserved.
//



import Foundation
import UIKit

class AccountSelectionPage: UIViewController {
    
    
    
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        
        self.hideKeyboardWhenTappedAround()
        
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
    
    
    
    
    let selectAccountTypeLabel: UILabel = {
        let label = UILabel()
        label.text = "Select Account Type"
        label.backgroundColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.font = label.font.withSize(14)
        return label
    }()
    
    
    
    
    
    
    let PersonsIconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = UIColor.white
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.masksToBounds = true
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(named: "P icon-72x72")
        
        
        
        return imageView
        
    }()
    
    
    
    
    
    
    lazy var personsAccountButton: UIButton = {
        
        
        
        //must put .custom and not .standard otherwise button is blue
        let button = UIButton(type: .custom)
        
        
        
        button.backgroundColor = UIColor.clear
        button.setTitle("Next", for: .normal)
       
        
      //var  b = UIImage(named:  "P ICON..")?.withRenderingMode(.alwaysOriginal)
        
        
          button.setImage(UIImage(named: "P ICON.."), for: .normal)
        
        
        
        button.setTitleColor(UIColor.white, for: .normal)
        button.addTarget(self, action: #selector(personsAccountSelected), for: .touchUpInside)
        button.layer.cornerRadius = 3
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        
        
        
        
        return button
    }()
    
    
    func personsAccountSelected(){
        
        let p = PRP2Username()
        
        
        self.present(p, animated: true, completion: nil)
        
        
        
    }
    
    
    lazy var businessAccountButton: UIButton = {
        let button = UIButton(type: .custom)
        
        
        button.backgroundColor = UIColor.clear
        
        
     
         button.setImage(UIImage(named: "B ICON.."), for: .normal)
        
        button.setTitleColor(UIColor.white, for: .normal)
        button.addTarget(self, action: #selector(businessAccountSelected), for: .touchUpInside)
        button.layer.cornerRadius = 3
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        
        return button
    }()
    
    
    
    
    func businessAccountSelected(){
       
        let b = BRP2Username()
        
        
        self.present(b, animated: true, completion: nil)
        
        
        
    }
    
    
    
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
    
    
    
    
    
    func setupViews(){
        
        
        
        // add the scroll view to self.view
        self.view.addSubview(scrollView)
        scrollView.addSubview(containerView)
       
        containerView.addSubview(grapevineLogoImageView)
        containerView.addSubview(selectAccountTypeLabel)
        
        containerView.addSubview(personsAccountButton)
        containerView.addSubview(businessAccountButton)
        

        
        // constrain the scroll view to 8-pts on each side
        scrollView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 0).isActive = true
        scrollView.topAnchor.constraint(equalTo: view.topAnchor, constant: 0).isActive = true
        scrollView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 0).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0).isActive = true
        
        
        containerView.anchor(top: scrollView.topAnchor, left: nil, bottom: scrollView.bottomAnchor, right: nil, paddingTop: 0, paddingLeft: 0, paddingBottom: -90, paddingRight: 0, width: view.frame.width, height: 600)
        
        containerView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor).isActive = true
        
        
        grapevineLogoImageView.anchor(top: containerView.topAnchor, left: nil, bottom: nil, right: nil, paddingTop: 60, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 330, height: 60)
        
        grapevineLogoImageView.centerXAnchor.constraint(equalTo: containerView.centerXAnchor).isActive = true
        
        
        selectAccountTypeLabel.anchor(top: grapevineLogoImageView.bottomAnchor, left: nil, bottom: nil, right: nil, paddingTop: 20, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 300, height: 30)
        
        selectAccountTypeLabel.centerXAnchor.constraint(equalTo: containerView.centerXAnchor).isActive = true
        
        
        
        
        
        personsAccountButton.anchor(top: selectAccountTypeLabel.bottomAnchor, left: nil, bottom: nil, right: nil, paddingTop: 60, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 60, height: 60)
        
        personsAccountButton.centerXAnchor.constraint(equalTo: containerView.centerXAnchor).isActive = true
        
        
     
        businessAccountButton.anchor(top: personsAccountButton.bottomAnchor, left: nil, bottom: nil, right: nil, paddingTop: 80, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 60, height: 60)
        
        businessAccountButton.centerXAnchor.constraint(equalTo: containerView.centerXAnchor).isActive = true
        
        
        
    
       
        
        
        
        
        
    }
    
    
    
}

//
//  AdvancedSearchCell.swift
//  Grapevine 2017
//
//  Created by Ben Palmer on 22/11/17.
//  Copyright © 2017 Ben Palmer. All rights reserved.
//

import Foundation
import UIKit
import CoreData
import Firebase
import CoreLocation






class AdvancedSearchCell: UITableViewCell {
    var advancedSearchController: AdvancedSearchController?
    var accountTypeSelector: AccountTypeSelector?
    var genderTypeSelector: GenderTypeSelector?
    var serviceTypeSelector: ServiceTypeSelector?
    var sectionsSelector: ServiceTypeSelector?
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    let slider: UISlider = {
        let s = UISlider()
        return s
    }()
    let refinementsLabel: UILabel = {
        let label = UILabel()
        label.text = "Sample Item"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: 12)
        return label
    }()
    let selectedRefinementsLabel: UILabel = {
        let b = UILabel()
        b.text = "select"
        b.font = b.font.withSize(12)
        b.translatesAutoresizingMaskIntoConstraints = false
        return b
    }()
    
    
    
    lazy var updateButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Find Nearest Location Via Map?", for: .normal)
        button.backgroundColor = UIColor.white
        button.tintColor = UIColor.lightGray
        button.addTarget(self, action: #selector(setLocationFromMap), for: .touchUpInside)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 10)
        
        button.titleLabel?.textAlignment = NSTextAlignment.center
        return button
    }()
    
    
    
    
    
    func setLocationFromMap(){
        print("presenting map to set location from")
        //delegate?.presentLocationController()
    }
    
    
   
    
    
    
    
    
    
    
    func setupViews() {
        addSubview(refinementsLabel)
        addSubview(selectedRefinementsLabel)
        addSubview(updateButton)
        
     
        
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-16-[v0]-2-[v1(120)]-8-|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0": refinementsLabel, "v1": selectedRefinementsLabel]))
        
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[v0]|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0": refinementsLabel]))
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[v0]|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0": selectedRefinementsLabel]))
        
        
//        
//        updateButton.anchor(top: nil, left: nil, bottom: self.bottomAnchor, right: nil, paddingTop: 0, paddingLeft: 0, paddingBottom: -10, paddingRight: 0, width: 0, height: 20)
//        
//        
//        updateButton.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
//        
        
        
        
    }
}


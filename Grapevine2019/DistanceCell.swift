//
//  DistanceCell.swift
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



class DistanceCell: UITableViewCell {
    
    var distanceCell: DistanceCell?
    
    var delegate: DistanceCellDelegate?
    
    
    
    let defaults = UserDefaults.standard
    
    
    var advancedSearchController: AdvancedSearchController?
    var accountTypeSelector: AccountTypeSelector?
    var genderTypeSelector: GenderTypeSelector?
    var serviceTypeSelector: ServiceTypeSelector?
    
    
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
        
    }
    
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    
    lazy var slider: UISlider = {
        let s = UISlider()
        s.minimumValue = 0
        s.maximumValue = 20000
        s.isContinuous = true
        s.tintColor = UIColor.blue
        
        if let startDistance = self.defaults.string(forKey: "distancePreference"), let floatStartDistance = Float(startDistance) {
            
            s.value = floatStartDistance
            
        }
        
        s.addTarget(self, action: #selector(paybackSliderValueDidChange),for: .valueChanged)
        
        return s
    }()
    
    
    var sliderValue: String?
    
    
    @objc func paybackSliderValueDidChange(sender: UISlider!){
        let sliderValue = (String(Int(sender.value)))
        sliderLabel.text = "<  \(sliderValue) Km"
        self.sliderValue = sliderValue
        let distance = sliderValue
        defaults.set(distance, forKey: "distancePreference")
        
    }
    
    let refinementsLabel: UILabel = {
        let label = UILabel()
        label.text = "Distance"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: 12)
        return label
    }()
    
    
   


    
    let searchingFromTextField: UITextField = {
        let tf = UITextField()
        tf.backgroundColor = UIColor.white
        tf.textColor = UIColor.black
        tf.borderStyle = .roundedRect
        tf.font = UIFont.italicSystemFont(ofSize: 8)
        tf.textAlignment = .center
        tf.text = "current location"
        
        return tf
    }()
    
    lazy var updateButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Update", for: .normal)
        button.backgroundColor = UIColor.white
        button.tintColor = UIColor.lightGray
        button.addTarget(self, action: #selector(distanceFromUpdate), for: .touchUpInside)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 10)
        
        button.titleLabel?.textAlignment = NSTextAlignment.center
        return button
    }()
    
    func distanceFromUpdate(){
        
    }
    
    lazy var setLocationFromMapButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Set Location From Map", for: .normal)
        
        button.tintColor = UIColor.lightGray
        button.addTarget(self, action: #selector(setLocationFromMap), for: .touchUpInside)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 10)
        
        return button
    }()
    
    
    func setLocationFromMap(){
        print("presenting map to set location from")
        delegate?.presentLocationController()
    }
    
    
    
    
    
    lazy var sliderLabel: UILabel = {
        let b = UILabel()
        
        if let startDistance = self.defaults.string(forKey: "distancePreference") {
            b.text = " < \(startDistance) Km"
        }
        b.font = b.font.withSize(12)
        b.translatesAutoresizingMaskIntoConstraints = false
        return b
        
    }()
    
    
    
    
    func setupViews() {
        addSubview(refinementsLabel)
        addSubview(sliderLabel)
        addSubview(slider)
        //addSubview(searchingFromTextField)
       // addSubview(updateButton)
       // addSubview(setLocationFromMapButton)
        
        
        refinementsLabel.anchor(top: topAnchor, left: leftAnchor, bottom: nil, right: nil, paddingTop: 15, paddingLeft: 16, paddingBottom: 0, paddingRight: 0, width: 80, height: 24)
        
        sliderLabel.anchor(top: topAnchor, left: nil, bottom: nil, right: rightAnchor , paddingTop: 15, paddingLeft: 0, paddingBottom: 0, paddingRight: 8, width: 160, height: 24)
        
        slider.anchor(top: refinementsLabel.bottomAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, paddingTop: 15, paddingLeft: 26, paddingBottom: 0, paddingRight: 26, width: 0, height: 20)
  

        
    }
    
    
}


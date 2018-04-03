//
//  AgeCell.swift
//  Grapevine 2017
//
//  Created by Ben Palmer on 22/11/17.
//  Copyright © 2017 Ben Palmer. All rights reserved.
//

import UIKit
import CoreData
import Firebase
import CoreLocation
import QuartzCore

class AgeCell: UITableViewCell {
    
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
    
    
    lazy var rangeSlider: RangeSlider = {
        
        let rs = RangeSlider()
        
        
        let lower = self.defaults.integer(forKey: "LowerAgePreference")
            
            let higher = self.defaults.integer(forKey: "HigherAgePreference")
       
        
        
        
        rs.lowerValue = Double(lower)
        rs.upperValue = Double(higher)
        
        
        rs.addTarget(self, action: #selector(AgeCell.rangeSliderValueChanged(_:)), for: .valueChanged)

        
        return rs
        
    }()
    
    
    
    func rangeSliderValueChanged(_ rangeSlider: RangeSlider) {
        
        
        
        let lowerValueInt = Int(rangeSlider.lowerValue)
        
        let higherValueInt = Int(rangeSlider.upperValue)
        
        lowerSliderLabel.text = " < \(lowerValueInt) years"
        
        higherSliderLabel.text = " > \(higherValueInt) years"
        
        print("Range slider value changed: (\(rangeSlider.lowerValue) , \(rangeSlider.upperValue))")
        
     
        
           defaults.set(higherValueInt, forKey: "HigherAgePreference")
        
        
        defaults.set(lowerValueInt, forKey: "LowerAgePreference")
        
       
        
    }

  


    
    
    
    lazy var slider: UISlider = {
        
        let s = UISlider()
        
        s.minimumValue = 13
        s.maximumValue = 100
        
        s.isContinuous = true
        s.tintColor = UIColor.blue
        
        if let startDistance = self.defaults.string(forKey: "agePreference"), let floatStartDistance = Float(startDistance) {
            
            
            
            s.value = floatStartDistance
            
        }
        
        s.addTarget(self, action: #selector(paybackSliderValueDidChange),for: .valueChanged)
        
        return s
    }()
    
    
    
    
    var sliderValue: String?
    
    
    @objc func paybackSliderValueDidChange(sender: UISlider!)
    {
        
        let sliderValue = (String(Int(sender.value)))
        
        sliderLabel.text = "<  \(sliderValue) years"
        
        self.sliderValue = sliderValue
        
        
        let age = sliderValue
        
        defaults.set(age, forKey: "agePreference")
        
    }
    
    
    
    let refinementsLabel: UILabel = {
        let label = UILabel()
        label.text = "Age"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: 12)
        return label
    }()
    
    lazy var sliderLabel: UILabel = {
        let b = UILabel()
        if let startAge = self.defaults.string(forKey: "agePreference") {
            b.text = " < \(startAge) years"
        }
        b.font = b.font.withSize(12)
        b.translatesAutoresizingMaskIntoConstraints = false
        return b
        
    }()
    
    
    lazy var higherSliderLabel: UILabel = {
        let b = UILabel()
        if let startAge = self.defaults.string(forKey: "HigherAgePreference") {
            b.text = " < \(startAge) years"
        }
        b.font = b.font.withSize(12)
        b.translatesAutoresizingMaskIntoConstraints = false
        return b
        
    }()
    
    
    lazy var lowerSliderLabel: UILabel = {
        let b = UILabel()
        if let startAge = self.defaults.string(forKey: "LowerAgePreference") {
            b.text = " > \(startAge) years"
            
            
        }
        b.font = b.font.withSize(12)
        b.translatesAutoresizingMaskIntoConstraints = false
        return b
        
    }()
    
    
    
    
    func setupViews() {
        addSubview(refinementsLabel)
        addSubview(lowerSliderLabel)
        addSubview(higherSliderLabel)
        addSubview(rangeSlider)
        
        refinementsLabel.anchor(top: topAnchor, left: leftAnchor, bottom: nil, right: nil, paddingTop: 15, paddingLeft: 16, paddingBottom: 0, paddingRight: 0, width: 80, height: 24)
        
        higherSliderLabel.anchor(top: topAnchor, left: nil, bottom: nil, right: rightAnchor , paddingTop: 15, paddingLeft: 0, paddingBottom: 0, paddingRight: 8, width: 120, height: 24)
        
        lowerSliderLabel.anchor(top: topAnchor, left: nil, bottom: nil, right: higherSliderLabel.leftAnchor , paddingTop: 15, paddingLeft: 0, paddingBottom: 0, paddingRight: 8, width: 120, height: 24)
        
        
        
        rangeSlider.anchor(top: refinementsLabel.bottomAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, paddingTop: 15, paddingLeft: 26, paddingBottom: 0, paddingRight: 26, width: 0, height: 20)
        
        
        
    }
    
    
    
}






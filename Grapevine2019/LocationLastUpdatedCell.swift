//
//  LocationLastUpdatedCell.swift
//  Grapevine 2017
//
//  Created by Ben Palmer on 10/12/17.
//  Copyright © 2017 Ben Palmer. All rights reserved.
//

import Foundation
import UIKit
import CoreData
import Firebase
import CoreLocation

class LocationLastUpdatedCell: UITableViewCell {
    
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
        
        s.minimumValue = 1
        s.maximumValue = 60*60*8
        
        s.isContinuous = true
        s.tintColor = UIColor.blue
        
        
        
        // check if user defaults has a value and if so use that value as the starting value
        if let startDistance = self.defaults.string(forKey: "LastTimeLocationWasUpdatedPreference"), let floatStartDistance = Float(startDistance) {
            
            s.value = floatStartDistance
            
            var startSliderValueString: String?
            
            if floatStartDistance < 60 {
                
                startSliderValueString = "< 1 Minute ago"
                
            }
            
            //greater than 60 seconds but less than 1 hour show in minutes
            if floatStartDistance > 60 {
                
                if floatStartDistance < 60*60 {
                    let elapsedTimeInMinutes = floatStartDistance/60
                    
                    startSliderValueString = String(describing: "< \(Int(elapsedTimeInMinutes)) Minutes ago")
                    
                }
                
            }
            
            
            //greater than 1 hour but less than one day shows as 1 hour
            if floatStartDistance > 60*60{
                
                if floatStartDistance < 60*60*24 {
                    
                    let elapsedTimeInHours = (floatStartDistance/60)/60
                    
                    
                    startSliderValueString = String(describing: "< \(Int(elapsedTimeInHours)) Hour ago")
                    
                    
                }
            }
            
            
            
            
            
            //greater than 2 hours but less than one day shows in hours
            if floatStartDistance > 60*120{
                
                if floatStartDistance < 60*60*24 {
                    
                    let elapsedTimeInHours = (floatStartDistance/60)/60
                    
                    
                    startSliderValueString = String(describing: "< \(Int(elapsedTimeInHours)) Hours ago")
                    
                    
                }
            }
            
            
            // always returns 1 day ago
            if floatStartDistance > 60*60*24 {
                
                if floatStartDistance < 60*60*48{
                    
                    let elapsedTimeInDays = (((floatStartDistance/60)/60)/24)
                    
                    
                    startSliderValueString = String(describing: "> \(Int(elapsedTimeInDays)) Day ago")
                    
                    
                }
            }
            
            
            
             let finalString = startSliderValueString
            
            
           
            
            self.sliderLabel.text = finalString
            

        
        
        s.addTarget(self, action: #selector(paybackSliderValueDidChange),for: .valueChanged)
        
            
        }
        return s
    }()
    ///// end of  lazy var slider: UISlider ///////
    
    
    
        
        
        
    
    var sliderValue: String?
    
    
    
        
        
        
    
    /// this function see's that the slider value has changed and updates the label accordingly
    @objc func paybackSliderValueDidChange(sender: UISlider!)
    {
        
        let sliderValue = (Int(sender.value))
        
        
        sliderLabel.text = "<  \(sliderValue) years"
        
        self.sliderValue = String(sliderValue)
        
    
        
        
        defaults.set(sender.value, forKey: "LastTimeLocationWasUpdatedPreference")
        
        
        
       var sliderValueString: String?
        
        if sliderValue < 60 {
            
            sliderValueString = "< 1 Minute ago"
            
        }
        
        //greater than 60 seconds but less than 1 hour show in minutes
        if sliderValue > 60 {
            
            if sliderValue < 60*60 {
                let elapsedTimeInMinutes = sliderValue/60
                
                sliderValueString = String(describing: "< \(elapsedTimeInMinutes) Minutes ago")
                
            }
            
        }
        
        
        //greater than 1 hour but less than one day shows as 1 hour
        if sliderValue > 60*60{
            
            if sliderValue < 60*60*24 {
                
                let elapsedTimeInHours = (sliderValue/60)/60
                
                
                sliderValueString = String(describing: "< \(Int(elapsedTimeInHours)) Hour ago")
                
                
            }
        }
        
        
        
        
        
        //greater than 2 hours but less than one day shows in hours
        if sliderValue > 60*120{
            
            if sliderValue < 60*60*24 {
                
                let elapsedTimeInHours = (sliderValue/60)/60
                
                
                sliderValueString = String(describing: "< \(Int(elapsedTimeInHours)) Hours ago")
                
            
            }
        }
        
        
        // always returns 1 day ago
        if sliderValue > 60*60*24 {
            
            if sliderValue < 60*60*48{
                
//                let elapsedTimeInDays = (((sliderValue/60)/60)/24)
                
                
                sliderValueString = "Not Filtering"
                
//                sliderValueString = String(describing: "> \(Int(elapsedTimeInDays)) Day ago")
//                
                
            }
        }
        
    
        
        
        guard let final = sliderValueString else { return }
        
        print("elapsed time in days is", final)
        
        
        sliderLabel.text = final
        

     
    
    }
    
    
    
        
        func setupViews() {
            addSubview(refinementsLabel)
            addSubview(sliderLabel)
            addSubview(slider)
            
            refinementsLabel.anchor(top: topAnchor, left: leftAnchor, bottom: nil, right: nil, paddingTop: 15, paddingLeft: 16, paddingBottom: 0, paddingRight: 0, width: 160, height: 24)
            sliderLabel.anchor(top: topAnchor, left: nil, bottom: nil, right: rightAnchor , paddingTop: 15, paddingLeft: 0, paddingBottom: 0, paddingRight: 8, width: 120, height: 24)
            slider.anchor(top: refinementsLabel.bottomAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, paddingTop: 15, paddingLeft: 26, paddingBottom: 0, paddingRight: 26, width: 0, height: 20)
            
            
    }
    
    
    let refinementsLabel: UILabel = {
        let label = UILabel()
        label.text = "Location Last Updated"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: 12)
        return label
    }()
    
    
   
    
    
    lazy var doNotFilterLocationLastUpdatedButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Click here to disregard the filter", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        button.layer.borderColor = UIColor.lightGray.cgColor
        
        button.addTarget(self, action: #selector(turnOffFilter), for: .touchUpInside)
        return button
    }()

    
    func turnOffFilter(){
    
    print("turnFilterOnAndOff pressed")
        
        
        
        
         defaults.set("off", forKey: "LocationLastUpdatedFiltering")
        
        
        
    }
    
    
    
    lazy var sliderLabel: UILabel = {
        let b = UILabel()
        
        // set the sliders starting value from the timeStamp saved in user defaults
        
        if let timeStamp = self.defaults.string(forKey: "LastTimeLocationWasUpdatedPreference") {
            b.text = " < \(timeStamp)"
        }
        
        b.font = b.font.withSize(12)
        b.translatesAutoresizingMaskIntoConstraints = false
        return b
        
    }()
    
    
   
    
    
    
}






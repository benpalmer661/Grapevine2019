//
//  ElapsedTimeFunction.swift
//  Grapevine 2017
//
//  Created by Ben Palmer on 2/12/17.
//  Copyright © 2017 Ben Palmer. All rights reserved.
//

import Foundation
import UIKit
import Firebase

class ElapsedTimeFunction: UIViewController {



    
    private static let _instance = ElapsedTimeFunction();
    
    // static var below; we have created  an instance/object with in the class itself.
    // now we are returning a getthered to return the object.
    static var Instance: ElapsedTimeFunction {
        return _instance;
    }

    
    
    
    
    
    
    func elapsedTime(timeStamp: Double) -> (String) {
 
        
        
        var elapsedTimeString: String?
        
        
        let myNSDate = Date(timeIntervalSince1970: timeStamp)
        
        
        
        
          let elapsedTimeInSeconds = Date().timeIntervalSince(myNSDate)
        

        
        
                    
                    
                    if elapsedTimeInSeconds < 60 {
                      
                        
                        elapsedTimeString = "1 Minute ago"
                        
                        
                    }
                    
                    //greater than 60 seconds but less than 1 hour show in minutes
                    if elapsedTimeInSeconds > 60 {
                        
                        if elapsedTimeInSeconds < 60*60 {
                            let elapsedTimeInMinutes = elapsedTimeInSeconds/60
                          
                            
                             elapsedTimeString = String(describing: "\(elapsedTimeInMinutes) Minutes ago")
                            
                            
                        }
                        
                    }
                    
                    //greater than 1 hour but less than one day shows in hours
                    if elapsedTimeInSeconds > 60*60{
                        
                        if elapsedTimeInSeconds < 60*60*24 {
                            
                            let elapsedTimeInHours = (elapsedTimeInSeconds/60)/60
                            
                            
                         
                            
                             elapsedTimeString = String(describing: "\(Int(elapsedTimeInHours)) Hours ago")
                            
                        }
                    }
                    
                    
                    // always returns 1 day ago
                    if elapsedTimeInSeconds > 60*60*24 {
                        
                        if elapsedTimeInSeconds < 60*60*48{
                            
                            let elapsedTimeInDays = (((elapsedTimeInSeconds/60)/60)/24)
                            
                
                            
                            
                            elapsedTimeString = String(describing: "\(Int(elapsedTimeInDays)) Day ago")
                            
                            
                        }
                    }
                    
                    // greater than 48 hours shown in days
                    if elapsedTimeInSeconds > 60*60*48 {
                   
                        let elapsedTimeInDays = (((elapsedTimeInSeconds/60)/60)/24)
                      
                        
                        elapsedTimeString = String(describing: "\(Int(elapsedTimeInDays)) Days ago")
                        
                        
        }
        
       
        return elapsedTimeString!

        
}
    
    
    
    
    
    
    
    
    
    

}

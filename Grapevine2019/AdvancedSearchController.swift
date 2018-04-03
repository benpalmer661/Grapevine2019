//
//  AdvancedSearchController.swift
//  Grapevine 2017
//
//  Created by Ben Palmer on 26/10/17.
//  Copyright © 2017 Ben Palmer. All rights reserved.
//



// ns user default keys
//"distancePreference"
//"connectionStatusPreference"
//"accountTypePreference"
//"genderTypePreference"
//"serviceTypePreference"
//"agePreference"
//"Location"


import UIKit
import CoreData
import Firebase
import CoreLocation



protocol DistanceCellDelegate {
      func presentLocationController()
}


protocol SearchCellDelegate {
    func presentLocationController()
}




class AdvancedSearchController:UITableViewController,DistanceCellDelegate, SearchCellDelegate {
    
     var distanceCell: DistanceCell?
    
    var searchLocationCell: SearchLocationCell?
    
    
    let defaults = UserDefaults.standard
    
    
    
    var refinements = [" Search Location","Connection Status", "Account Type", "Gender", "Service Type"]
    
    
    override func viewWillAppear(_ animated: Bool) {
       
         tableView.reloadData()
        
        navigationItem.title = "Search Refinements"
    }
    
   
    
    var selectedRefinements = [ "location not set","online" ,"Person's","Both","All Service Types"]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        tableView.backgroundColor = UIColor.gray
        
        navigationItem.title = "Search Refinements"
   
               self.navigationController!.navigationBar.topItem!.title = ""
        
                tableView.register(AdvancedSearchCell.self, forCellReuseIdentifier: "cellId")
        
        
        tableView.register(DistanceCell.self, forCellReuseIdentifier: "distanceCellId")
        
        
        tableView.register(AgeCell.self, forCellReuseIdentifier: "ageCellId")
        
        tableView.register(LocationLastUpdatedCell.self, forCellReuseIdentifier: "locationLastUpdatedCellId")
        
       
        
        tableView.register(Header.self, forHeaderFooterViewReuseIdentifier: "headerId")
        
        tableView.sectionHeaderHeight = 50
     
        SetSearchingFromLocationFromUserDefaults()
        
        
    }// end of view did load

    
    
    func presentLocationController(){
    
       let locationController = LocationController()
        navigationController?.pushViewController(locationController, animated: true)
    }

    
    
    func SetSearchingFromLocationFromUserDefaults(){
    
     
        guard let searchingFromLatitude = self.defaults.string(forKey: "SearchingFromLatitude") else { return }
        
        guard let searchingFromLongitude = self.defaults.string(forKey: "SearchingFromLongitude") else { return }
        
       
        guard let doublesearchingFromLatitude = Double(searchingFromLatitude) else { return }
        
        guard let doublesearchingFromLongitude = Double(searchingFromLongitude) else { return }
        
        
            let Current_Users_Location = CLLocation(latitude:doublesearchingFromLatitude, longitude:doublesearchingFromLongitude)
            
            CLGeocoder().reverseGeocodeLocation(Current_Users_Location, completionHandler: { (placemark, err) in
                
                if err != nil {
                    print("there was an error in reverse geocode")
            
                } else {
                    
                    guard let place = placemark?[0],let st = place.subThoroughfare, let t = place.thoroughfare, let l = place.locality else { return }
                    
                    let locationLabelText = ("Searching From: \(st) \(t) \(l)")
                    
                  self.location = locationLabelText
                    
                   
                }
            }
            )
    }
    
    
    var location: String?{
        
        didSet{
            
          //reloadInputViews()
     tableView.reloadData()
        }
    }
    
    
    
    
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
        if indexPath.row == 0 {
            
            print("still needs to be set")
            
            
            let locationViewController = SearchLocationSelector()
            navigationController?.pushViewController(locationViewController, animated: true)
            
        }else{

        if indexPath.row == 1 {
           
        
            let connectionStatusSelectorViewController = ConnectionStatusSelector()
            navigationController?.pushViewController(connectionStatusSelectorViewController, animated: true)
            
        }else{
            if indexPath.row == 2 {
               
                let AccountSelectorViewController = AccountTypeSelector()
              
                navigationController?.pushViewController(AccountSelectorViewController, animated: true)
                
                
            }else{
                if indexPath.row == 3 {
                    
                    let GenderSelectorViewController = GenderTypeSelector()
                    navigationController?.pushViewController(GenderSelectorViewController, animated: true)
                    
                }else{
                    if indexPath.row == 4 {
                        
                        let serviceSelectorViewController = ServiceTypeSelector()
                        navigationController?.pushViewController(serviceSelectorViewController, animated: true)
                        
                    }else{
                        if indexPath.row == 5 {
                            
                  
    }
    }
    }
    }
    }
    }
    }
    
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        let headerHeight: CGFloat
        
        switch section {
        case 0:
            // hide the header
            headerHeight = CGFloat.leastNonzeroMagnitude
        default:
            headerHeight = 21
        }
        
        return headerHeight
    }
    
    
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
     
        
        
        if(indexPath.row == 5){
            return 100
        }else{
            
            if(indexPath.row == 6){
                return 100
            }else{
                if(indexPath.row == 7){
                    return 150
                }else{
                
            return 50
        }
            }
        }
    
    }
    
//    we need to create a new cell for search location cell
//    we need to add a "search via map for nearest location?"


    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return (refinements.count + 2)
        
        // un comment code below when you want the location last updated filter put back in there.
        //return (refinements.count + 3)
    }
    
    
    
    
    
    
    
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       
        
         if indexPath.row < refinements.count {
        
        let advancedSearchCell = tableView.dequeueReusableCell(withIdentifier: "cellId", for: indexPath) as! AdvancedSearchCell
            
            
        advancedSearchCell.refinementsLabel.text = refinements[indexPath.row]
        advancedSearchCell.selectedRefinementsLabel.text = selectedRefinements[indexPath.row]
             advancedSearchCell.advancedSearchController = self
            
            
            if(indexPath.row == 0){
                
                
              
                
                if let searchlocation = self.defaults.string(forKey: "searchLocation") {
                    
                    advancedSearchCell.selectedRefinementsLabel.text = "\(searchlocation)"
                    
                    
                
                }
            }
            
            
            if(indexPath.row == 1){
                
                if let connectStatusPreference = self.defaults.string(forKey: "connectionStatusPreference") {
                    
                    advancedSearchCell.selectedRefinementsLabel.text = "\(connectStatusPreference)"
               
                    advancedSearchCell.updateButton.isHidden = true
                    
                }
            }
            
                if(indexPath.row == 2){
                    
                   
                    
                    if let accountTypePreference = self.defaults.string(forKey: "accountTypePreference") {
                        
                        advancedSearchCell.selectedRefinementsLabel.text = "\(accountTypePreference)"
                        
                          advancedSearchCell.updateButton.isHidden = true
                    }
                    
            }
            
            if(indexPath.row == 3){
                
                if let genderTypePreference = self.defaults.string(forKey: "genderTypePreference") {
                    
                    advancedSearchCell.selectedRefinementsLabel.text = "\(genderTypePreference)"
                    
                    advancedSearchCell.updateButton.isHidden = true
                }
            }
            
            if(indexPath.row == 4){
                
                if let serviceTypePreference = self.defaults.string(forKey: "Service being searched") {
                    
                    advancedSearchCell.selectedRefinementsLabel.text = "\(serviceTypePreference)"
                    
                    advancedSearchCell.updateButton.isHidden = true
                }
                
            }

        return advancedSearchCell
            
        }
        
          if(indexPath.row == 5){
            
                    let distanceCell: DistanceCell = tableView.dequeueReusableCell(withIdentifier: "distanceCellId", for: indexPath) as! DistanceCell

            
            distanceCell.delegate = self
            
            
           SetSearchingFromLocationFromUserDefaults()
            
            distanceCell.searchingFromTextField.text = self.location
            

            
                       return distanceCell
            
            
        }
        
          if(indexPath.row == 6){
            
            let ageCell: AgeCell = tableView.dequeueReusableCell(withIdentifier: "ageCellId", for: indexPath) as! AgeCell
            
            
            return ageCell
        
            
        }
        
        if(indexPath.row == 7){
            
            let locationLastUpdatedCell: LocationLastUpdatedCell = tableView.dequeueReusableCell(withIdentifier: "locationLastUpdatedCellId", for: indexPath) as! LocationLastUpdatedCell
            
            
            return locationLastUpdatedCell
       
          } else {
            
            
            let ageCell: AgeCell = tableView.dequeueReusableCell(withIdentifier: "ageCellId", for: indexPath) as! AgeCell
            return ageCell
        }

        
        
        
        
        
    }
    

    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return tableView.dequeueReusableHeaderFooterView(withIdentifier: "headerId")
    }
    
}//class


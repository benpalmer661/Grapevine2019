//
//  GenderTypeSelector.swift
//  Grapevine 2017
//
//  Created by Ben Palmer on 3/11/17.
//  Copyright © 2017 Ben Palmer. All rights reserved.
//


import Foundation
import UIKit

class GenderTypeSelector: UITableViewController {
    
    
    
    let defaults = UserDefaults.standard
    
    //"Business Account": true,
    //"All Account Types": true
    //"All Users & Services": true,
    //"Online & Offline": true
    //"All Genders": true
    

    
    
    var refinements = ["Males", "Females", "All Genders"]
    
    var selectedRefinements = ["Select","Select","Select"]
    
    //active for business accounts only
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.backgroundColor = UIColor.gray
        
        
        navigationItem.title = "Gender Type"
        
        self.navigationController!.navigationBar.topItem!.title = ""
        
        tableView.register(AdvancedSearchCell.self, forCellReuseIdentifier: "cellId")
        tableView.register(Header.self, forHeaderFooterViewReuseIdentifier: "headerId")
        
        tableView.sectionHeaderHeight = 50
        
    }
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if indexPath.row == 0 {
            print("Males")
            
            let header = tableView.headerView(forSection: indexPath.section) as! Header;
            
            
            let maleAccountsOnly = "Male"
           
            
            header.nameLabel.text = "\(maleAccountsOnly)"
            
            
            defaults.set(maleAccountsOnly, forKey: "genderTypePreference")
            
            
            
            
        }else{
            if indexPath.row == 1 {
                print("Females")
                let header = tableView.headerView(forSection: indexPath.section) as! Header;
                
                let femaleAccountsOnly = "Female"
                
                
                header.nameLabel.text = "\(femaleAccountsOnly)"
                
                
                defaults.set(femaleAccountsOnly, forKey: "genderTypePreference")
                
                
                

                
                
            }else{
                if indexPath.row == 2 {
                    print("Both")
                    
                    let header = tableView.headerView(forSection: indexPath.section) as! Header;
                    
                    let allGenders = "All Genders"
                    
                    
                    header.nameLabel.text = "\(allGenders)"
                    
                    
                    
                    defaults.set(allGenders, forKey: "genderTypePreference")
                    
                }else{
                    print("nothing")
                }
            }
        }
    }
    
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return refinements.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let advancedSearchCell = tableView.dequeueReusableCell(withIdentifier: "cellId", for: indexPath) as! AdvancedSearchCell
        advancedSearchCell.refinementsLabel.text = refinements[indexPath.row]
        advancedSearchCell.selectedRefinementsLabel.text = selectedRefinements[indexPath.row]
        advancedSearchCell.genderTypeSelector = self
        
        
        return advancedSearchCell
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return tableView.dequeueReusableHeaderFooterView(withIdentifier: "headerId")
    }
    
    
    
}


    

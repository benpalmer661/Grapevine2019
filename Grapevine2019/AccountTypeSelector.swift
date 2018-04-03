//
//  AccountTypeSelector.swift
//  Grapevine 2017
//
//  Created by Ben Palmer on 2/11/17.
//  Copyright © 2017 Ben Palmer. All rights reserved.
//

import Foundation
import UIKit

class AccountTypeSelector: UITableViewController {
    
    
    //Firestore contains;
    //"All Account Types": true,
    //"Persons Account": true,
    //"Business Account": true
    
    let defaults = UserDefaults.standard
    
    
        var refinements = ["Person's Accounts Only", "Business Accounts Only", "All Account Types"]
            var selectedRefinements = ["Select","Select","Select"]
        
    

    
        override func viewDidLoad() {
            super.viewDidLoad()
            
            tableView.backgroundColor = UIColor.gray
            
            
            navigationItem.title = "Account Type"
            
            self.navigationController!.navigationBar.topItem!.title = ""
            
            tableView.register(AdvancedSearchCell.self, forCellReuseIdentifier: "cellId")
            tableView.register(Header.self, forHeaderFooterViewReuseIdentifier: "headerId")
            
            tableView.sectionHeaderHeight = 50
            
        }
    
    let header = Header()
        
        override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            
            if indexPath.row == 0 {
                print("Person's Account Selected")
                
                let header = tableView.headerView(forSection: indexPath.section) as! Header;
              
                header.nameLabel.text = "Searching Person's Accounts Only"
                
                 let personAccountsOnly = "Persons Account"
                let personAccountSearchString = "Persons Account"
                
                
                header.nameLabel.text = "\(personAccountsOnly)"
                
                 defaults.set(personAccountSearchString, forKey: "accountTypePreference")
                
                
            
                
                
                
            }else{
                if indexPath.row == 1 {
                    print("Business Account Selected")
                    
                    let header = tableView.headerView(forSection: indexPath.section) as! Header;
                    
                    let businessAccountsOnly = "Business Accounts"
                    
                    let businessAccountSearchString = "Business Account"
                    
                    
                    header.nameLabel.text = "\(businessAccountsOnly)"
                    
                    
                    defaults.set(businessAccountSearchString, forKey: "accountTypePreference")
                    
                    
                    
                    //Firestore contains;
                    //"All Account Types": true,
                    //"Persons Account": true,
                    //"Business Account": true
                    
                    
                }else{
                    if indexPath.row == 2 {
                        print("All Account Type's Selected")
                        let header = tableView.headerView(forSection: indexPath.section) as! Header;
                        
                        
                        let noPreference = "All Account Types"
                        
                        
                        
                        header.nameLabel.text = "All Accounts"
                        
                        
                        
                        defaults.set(noPreference, forKey: "accountTypePreference")

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
            advancedSearchCell.accountTypeSelector = self
            
            
            return advancedSearchCell
        }
        
        override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
            return tableView.dequeueReusableHeaderFooterView(withIdentifier: "headerId")
        }
        
        
        
    }
    

    

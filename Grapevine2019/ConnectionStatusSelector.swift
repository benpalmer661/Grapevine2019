//
//  ConnectionStatusSelector.swift
//  Grapevine 2017
//
//  Created by Ben Palmer on 2/11/17.
//  Copyright © 2017 Ben Palmer. All rights reserved.
//


//Firestore contains;
//"Online & Offline": true
//"Online" : true
//"Offline" : true


import Foundation
import UIKit

class ConnectionStatusSelector: UITableViewController {
    
    
    let defaults = UserDefaults.standard
    
//    var refinements = ["Online Users Only", "Offline Users Only", "All Users"]
    
        var refinements = ["Online & Offline", "Online Users Only", "Offline Users Only"]


    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.backgroundColor = UIColor.gray
        
        
        navigationItem.title = "Connection Status Type"
        
        self.navigationController!.navigationBar.topItem!.title = ""
        
        
        
        tableView.register(MyConnectionStatusCell.self, forCellReuseIdentifier: "cellId")
        tableView.register(ConntectionStatusHeader.self, forHeaderFooterViewReuseIdentifier: "headerId")
        
        tableView.sectionHeaderHeight = 50
        
        
              
    }
    
    


    //Firestore contains;
    //"Online & Offline": true
    //"Online" : true
    //"Offline" : true
    
    let csh = ConntectionStatusHeader()
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if indexPath.row == 0 {
            
            
            let csh = tableView.headerView(forSection: indexPath.section) as! ConntectionStatusHeader;
            
            
            let allUsers = "Online & Offline"
            
            csh.nameLabel.text = "Online & Offline"
            
            
            defaults.set(allUsers, forKey: "connectionStatusPreference")
            
            
            
            
            
            
        }else{
        if indexPath.row == 1 {
            print("Online")
           
            let csh = tableView.headerView(forSection: indexPath.section) as! ConntectionStatusHeader;
           
           
            let onlineUsersOnly = "Online"
            
            csh.nameLabel.text = "Online Users"
            
            
            defaults.set(onlineUsersOnly, forKey: "connectionStatusPreference")
            

            
            
            
            
        }else{
            if indexPath.row == 2 {
                print("Offline")
                
                let csh = tableView.headerView(forSection: indexPath.section) as! ConntectionStatusHeader;
                
                let offlineUsersOnly = "Offline"
                
                csh.nameLabel.text = "Offline Users"
                
            
                 defaults.set(offlineUsersOnly, forKey: "connectionStatusPreference")
                
          

               
                
                    

                        }else{
                            print("error 4563")
                        }
                }
        }
    }
   // }
    
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return refinements.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let myConnectionStatusCell = tableView.dequeueReusableCell(withIdentifier: "cellId", for: indexPath) as! MyConnectionStatusCell
        myConnectionStatusCell.refinementsLabel.text = refinements[indexPath.row]
        //myConnectionStatusCell.selectedRefinementsLabel.text = selectedRefinements[indexPath.row]
        myConnectionStatusCell.connectionStatusSelector = self
     
        return myConnectionStatusCell
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return tableView.dequeueReusableHeaderFooterView(withIdentifier: "headerId")
    }
    
    
    
}

class ConntectionStatusHeader: UITableViewHeaderFooterView {
    
      let defaults = UserDefaults.standard
    
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    lazy var nameLabel: UILabel = {
        let label = UILabel()
        if let connectStatusPreference = self.defaults.string(forKey: "connectionStatusPreference") {
           
        label.text = "\(connectStatusPreference)"
        }
        
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: 14)
        return label
    }()
    
    
   
    
    func setupViews() {
        addSubview(nameLabel)
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-16-[v0]|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0": nameLabel]))
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[v0]|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0": nameLabel]))
        
    }
    
}

class MyConnectionStatusCell: UITableViewCell {
    
    var connectionStatusSelector: ConnectionStatusSelector?
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let refinementsLabel: UILabel = {
        let label = UILabel()
        label.text = "Sample Item"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: 14)
        return label
    }()
    
    let selectedRefinementsLabel: UILabel = {
        let b = UILabel()
        b.text = "Select"
        b.font = b.font.withSize(14)
        b.translatesAutoresizingMaskIntoConstraints = false
        return b
    }()
    
    func setupViews() {
        addSubview(refinementsLabel)
        addSubview(selectedRefinementsLabel)
        
        //selectedPreferenceLabel.addTarget(self, action: #selector(MyCell.handleAction), for: .touchUpInside)
        
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-16-[v0]-2-[v1(80)]-8-|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0": refinementsLabel, "v1": selectedRefinementsLabel]))
        
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[v0]|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0": refinementsLabel]))
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[v0]|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0": selectedRefinementsLabel]))
        
    }
    
    func handleAction() {
        //advancedSearchController?.deleteCell(self)
        
        print("button pressed")
    }
    
}











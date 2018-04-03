//
//  MyServiceTypeSelector.swift
//  Grapevine2019
//
//  Created by Ben Palmer on 26/1/18.
//  Copyright © 2018 Ben Palmer. All rights reserved.


import Foundation
import UIKit
import Firebase


class MyServiceTypeSelector: UITableViewController {
    
    
    
    var activityIndicator:UIActivityIndicatorView = UIActivityIndicatorView()
    
    
    
    func activityIndicatorStart(){
        activityIndicator.center = self.view.center
        activityIndicator.hidesWhenStopped = true
        activityIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.gray
        view.addSubview(activityIndicator)
        
        activityIndicator.startAnimating()
        
    }
    
    func activityIndicatorFinish(){
        activityIndicator.stopAnimating()
        
    }
    
    
    
    let defaults = UserDefaults.standard
    
    
    
    let sections = ["Automotive", "Building & Construction", "Cleaning", "Landscaping & Gardening"]
    
    let services = [["Automotive"],["Air Conditioning & Heating","Bricklaying", "Carpentry","Carpet Layer","Concreting & Paving","Electrical","Fencing and Gates","Flooring","Handyman","Other","Painting & Decorating","Pet Control","Plastering","Plumbing","Roofing","Rubbish Removal","Scaffolding","Tiling"], ["Cleaning"],["Landscaping & Gardening"]]
    
     let uid = Auth.auth().currentUser?.uid
    
    //active for business accounts only
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.backgroundColor = UIColor.gray
        
        
        navigationItem.title = "My Service Types"
        
        self.navigationController!.navigationBar.topItem!.title = ""
        
        tableView.register(MyServiceCell.self, forCellReuseIdentifier: "cellId")
        tableView.register(Header.self, forHeaderFooterViewReuseIdentifier: "headerId")
        
        tableView.sectionHeaderHeight = 50
        
    }
    
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        
        
        
            return self.sections[section]
    }
    
    
    
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return sections.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return services[section].count
    }
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        activityIndicatorStart()
        
        
        defaults.set("true", forKey: "AServiceTypeHasBeenSelected")
   
       
        
        //let serviceTypeCell = tableView.dequeueReusableCell(withIdentifier: "cellId", for: indexPath) as! MyServiceCell
        
        
        //tableView.cellForRow(at: indexPath)?.accessoryType = UITableViewCellAccessoryType.checkmark
        
      let service = services[indexPath.section][indexPath.row]
        
        print("this is service" ,service as Any)
        
        
        guard let uid = Auth.auth().currentUser?.uid else { return }
        
        let db = Firestore.firestore()
        
        let docRef = db.collection("Users").document(uid)
        
        docRef.getDocument { (document, error) in
            if let document = document {

                if document.exists{
                    
                    let dictionary = document.data()
        
                    
                    let serviceType = dictionary[String(describing: service)] as? Bool
                    
                    if serviceType == nil {
                      
                        db.collection("Users").document(uid).setData([String(describing: service): true ], options: SetOptions.merge()){ err in
                            if let err = err {
                                print("Error writing document: \(err)")
                            } else {
                                print("Document successfully written!  -    was nil now setting to true")
                                
                                
                                self.activityIndicatorFinish()
                                tableView.reloadData()
                            }
                        }

                        
                  
                        //if value is there and is true set to false
                    } else if serviceType == true {
                        
                        
                        
                        db.collection("Users").document(uid).setData([String(describing: service): false ], options: SetOptions.merge()){ err in
                            if let err = err {
                                print("Error writing document: \(err)")
                            } else {
                                print("Document successfully written!   -  service type was true now false")
                                
                                
                                self.activityIndicatorFinish()
                                tableView.reloadData()
                            }
                        }

                        
                        //if value is there and is false set to true
                    } else if serviceType == false {
                        
                        
                        db.collection("Users").document(uid).setData([String(describing: service): true ], options: SetOptions.merge()){ err in
                            if let err = err {
                                print("Error writing document: \(err)")
                            } else {
                                print("Document successfully written!  -    service type was false now true")
                                
                                
                                
                                self.activityIndicatorFinish()
                                tableView.reloadData()
                                
                            }
                        }

                        
                    }
                }
            }
        }
        
        

//        
//        var selectUnselectLabel = tableView.cellForRow(at: indexPath)?.accessoryType
//        
//        if selectUnselectLabel == UITableViewCellAccessoryType.checkmark {
//            
//            selectUnselectLabel = UITableViewCellAccessoryType.none
//            
//        } else if selectUnselectLabel == UITableViewCellAccessoryType.none
//        {
//            
//            selectUnselectLabel = UITableViewCellAccessoryType.checkmark
//            
//            
//            
//        }
        
    }

    
   

    
    
   
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        let serviceTypeCell = tableView.dequeueReusableCell(withIdentifier: "cellId", for: indexPath) as! MyServiceCell
        serviceTypeCell.refinementsLabel.text = services[indexPath.section][indexPath.row]
        
        let service = services[indexPath.section][indexPath.row]
        
          serviceTypeCell.mysectionsSelector = self
        
     let uid = Auth.auth().currentUser?.uid
        
        
          let db = Firestore.firestore()
        
                let docRef = db.collection("Users").document(uid!)
        
                docRef.getDocument { (document, error) in
                    if let document = document {
        
                        if document.exists{
        
                            let dictionary = document.data()
        
                            let serviceType = dictionary[String(describing: service)] as? Bool
                            
                            
                          
                            if serviceType == nil {
        
                                tableView.cellForRow(at: indexPath)?.accessoryType = UITableViewCellAccessoryType.none
                                
                                //serviceTypeCell.selectedRefinementsLabel.text = "select"

                            } else if serviceType == true {
        
                                //serviceTypeCell.selectedRefinementsLabel.text = "unselect"
                                
                                tableView.cellForRow(at: indexPath)?.accessoryType = UITableViewCellAccessoryType.checkmark
                                
                            } else if serviceType == false {
                        
                                //serviceTypeCell.selectedRefinementsLabel.text = "select"
                                
                            
                                tableView.cellForRow(at: indexPath)?.accessoryType = UITableViewCellAccessoryType.none
                                
                            }
                        }
                    }
        }
        
        
        
        return serviceTypeCell
    }
    
    
    
    
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return tableView.dequeueReusableHeaderFooterView(withIdentifier: "headerId")
    }
}



class MyServiceCell: UITableViewCell {
    
    var serviceTypeSelector: ServiceTypeSelector?
    var sectionsSelector: ServiceTypeSelector?
    var serviceSelector: ServiceTypeSelector?
    var mysectionsSelector: MyServiceTypeSelector?
    
    
    
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
    
}

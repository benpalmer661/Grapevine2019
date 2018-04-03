//
//  SearchLocationSelector.swift
//  Grapevine2019
//
//  Created by Ben Palmer on 14/2/18.
//  Copyright © 2018 Ben Palmer. All rights reserved.
//

import Foundation



import Foundation
import UIKit
import CoreLocation

class SearchLocationSelector: UITableViewController,UINavigationBarDelegate {
    
    
    
    let defaults = UserDefaults.standard
    
    
    let statesTerritories = ["Australian Capital Territory",
        "Northern Territory",
        "New South Wales",
        "Queensland",
        "South Australia",
        "Tasmania",
        "Victoria",
        "Western Australia"]
    
    
    
    
    
    let citiesTownsRegions = [["Canberra"],["Alice Springs","Darwin","Katherine"],["Albury","Gosford","Newcastle","Sydney","Wagga Wagga"],["Brisbane","Gold Coast","Sunshine Coast"],["Adelaide","Port Augusta","Port Pirie"],["Hobart","Launceston"],["Ballarat","Geelong","Melbourne"],["Armadale","Bunbury","Busselton","Joondalup","Mandurah","Margaret River","Perth","Rockingham"]]
    
    
   
   
    
    
    //active for business accounts only
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        tableView.backgroundColor = UIColor.gray
        
        guard let locationBeingSearched = self.defaults.string(forKey: "searchLocation") else { return }
        
        
        navigationItem.title = locationBeingSearched
        
        self.navigationController!.navigationBar.topItem!.title = ""
        
        tableView.register(SearchLocationCell.self, forCellReuseIdentifier: "cellId")
        tableView.register(Header.self, forHeaderFooterViewReuseIdentifier: "headerId")
        
        tableView.sectionHeaderHeight = 50
        
    }
    
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        
        
        
        let serviceBeingSearched = self.defaults.string(forKey: "searchLocation")
        
        
        
        if serviceBeingSearched == nil {
            defaults.set("Sydney", forKey: "searchLocation")
            
            tableView.reloadData()
        }
        
        
//        if section == 0 {
//          
//            
//            
//            
//            
//            return "Searching: \(String(describing: serviceBeingSearched!))"
//            
//        } else {
            return self.statesTerritories[section]
      //  }
        
    }
    
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return statesTerritories.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return citiesTownsRegions[section].count
    }
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let serviceTypeCell = tableView.dequeueReusableCell(withIdentifier: "cellId", for: indexPath) as! SearchLocationCell
        
        var service = serviceTypeCell.refinementsLabel.text
        
        service = citiesTownsRegions[indexPath.section][indexPath.row]
        
        
        defaults.set(service, forKey: "searchLocation")
        
        
        
        guard let serviceBeingSearched = self.defaults.string(forKey: "searchLocation") else { return }
        
        
        navigationItem.title = serviceBeingSearched
        
      
        
        guard let locationBeingSearched = self.defaults.string(forKey: "searchLocation") else { return }
        
        
        navigationItem.title = locationBeingSearched
        
        
        tableView.reloadData()
        
        
        
        
        let citiesArray = ["Adelaide": CLLocation(latitude: -34.9286600, longitude: 138.5986300),"Albury": CLLocation(latitude: -36.0737, longitude: 146.9135),"Alice Springs": CLLocation(latitude: -23.6980, longitude: 133.8807),"Armadale": CLLocation(latitude: -32.1530, longitude: 116.0150),"Ballarat": CLLocation(latitude: -37.5622, longitude: 143.8503),"Brisbane": CLLocation(latitude: -27.470125, longitude: 153.021072),"Bunbury": CLLocation(latitude: -33.3256, longitude: 115.6396),
                           "Busselton": CLLocation(latitude: -33.6555, longitude: 115.3500),"Darwin":CLLocation(latitude: -12.462827, longitude: 130.841782),"Geelong": CLLocation(latitude: -38.1499, longitude: 144.3617),"Gold Coast": CLLocation(latitude: -28.0167, longitude: 153.4000),"Gosford": CLLocation(latitude: -33.4267, longitude: 151.3417),
                           "Hobart":CLLocation(latitude: -42.837284, longitude: 147.505005),
                           "Joondalup":CLLocation(latitude: -32.5361, longitude: 115.7424),"Katherine": CLLocation(latitude: -14.4521, longitude: 132.2715),"Launceston": CLLocation(latitude: -41.4332, longitude: 147.1441),"Mandurah": CLLocation(latitude: -32.5361, longitude: 115.7424),"Margaret River": CLLocation(latitude: -33.9536, longitude: 115.07391),
                           "Melbourne": CLLocation(latitude: -37.81425, longitude: 144.963169),"Newcastle": CLLocation(latitude: -32.9283, longitude: 151.7817),"Perth": CLLocation(latitude: -31.953512, longitude: 115.857048),"Port Augusta": CLLocation(latitude: -32.4952, longitude: 137.7894),"Port Pirie": CLLocation(latitude: -33.1708, longitude: 138.0089),"Rockingham": CLLocation(latitude: -32.2810, longitude: 115.7270),"Sunshine Coast": CLLocation(latitude: -26.6500, longitude: 153.0667),
                           "Sydney": CLLocation(latitude: -33.865143, longitude: 151.209900),"Wagga Wagga": CLLocation(latitude: -35.1082, longitude: 147.3598)]
        


        let latitude = citiesArray[service!]?.coordinate.latitude
        let longitude = citiesArray[service!]?.coordinate.longitude

        
        
        
        defaults.set(latitude, forKey: "SearchingFromLatitude")
        
        
        
        defaults.set(longitude, forKey: "SearchingFromLongitude")
        
        
   
        
    }
    
    
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        let serviceTypeCell = tableView.dequeueReusableCell(withIdentifier: "cellId", for: indexPath) as! SearchLocationCell
        serviceTypeCell.refinementsLabel.text = citiesTownsRegions[indexPath.section][indexPath.row]
        
        serviceTypeCell.searchlocationSelector = self
        
        
        return serviceTypeCell
    }
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return tableView.dequeueReusableHeaderFooterView(withIdentifier: "headerId")
    }
}



class SearchLocationCell: UITableViewCell {
    

    var searchlocationSelector: SearchLocationSelector?
    
    
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
    
}

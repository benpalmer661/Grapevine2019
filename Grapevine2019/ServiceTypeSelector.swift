
import Foundation
import UIKit

class ServiceTypeSelector: UITableViewController,UINavigationBarDelegate {
    
    
    
    let defaults = UserDefaults.standard
    
    
    
    let sections = ["All Users & Services","Automotive", "Building & Construction", "Cleaning", "Landscaping & Gardening"]
    
    let services = [["All Users & Services"],["Automotive"],["Air Conditioning & Heating","Bricklaying", "Carpentry","Carpet Layer","Concreting & Paving","Electrical","Fencing and Gates","Flooring","Handyman","Other","Painting & Decorating","Pet Control","Plastering","Plumbing","Roofing","Rubbish Removal","Scaffolding","Tiling"], ["Cleaning"],["Landscaping & Gardening"]]
    
    
    //active for business accounts only
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        tableView.backgroundColor = UIColor.gray
        
        
        guard let serviceBeingSearched = self.defaults.string(forKey: "Service being searched") else { return }
        
        
        navigationItem.title = serviceBeingSearched
        
        self.navigationController!.navigationBar.topItem!.title = ""
        
        tableView.register(ServiceCell.self, forCellReuseIdentifier: "cellId")
        tableView.register(Header.self, forHeaderFooterViewReuseIdentifier: "headerId")
        
        tableView.sectionHeaderHeight = 50
        
    }
    
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        
        let serviceBeingSearched = self.defaults.string(forKey: "Service being searched")
        
        
    
                    if serviceBeingSearched == nil {
                        defaults.set("All Users & Services", forKey: "Service being searched")
        
                        tableView.reloadData()
                    }
        
//        
//        if section == 0 {
//            
//            
//            return "Searching: \(String(describing: serviceBeingSearched!))"
//            
//        } else {
        return self.sections[section]
  //  }
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
        
        let serviceTypeCell = tableView.dequeueReusableCell(withIdentifier: "cellId", for: indexPath) as! ServiceCell
        
        var service = serviceTypeCell.refinementsLabel.text
        
        service = services[indexPath.section][indexPath.row]
        
       
    defaults.set(service, forKey: "Service being searched")
        
        
        guard let serviceBeingSearched = self.defaults.string(forKey: "Service being searched") else { return }
        
        
        navigationItem.title = serviceBeingSearched

        

         tableView.reloadData()
        
    }
    
    
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        let serviceTypeCell = tableView.dequeueReusableCell(withIdentifier: "cellId", for: indexPath) as! ServiceCell
        serviceTypeCell.refinementsLabel.text = services[indexPath.section][indexPath.row]
        
        serviceTypeCell.sectionsSelector = self
        
        
        return serviceTypeCell
    }
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return tableView.dequeueReusableHeaderFooterView(withIdentifier: "headerId")
    }
}



class ServiceCell: UITableViewCell {
    
    var serviceTypeSelector: ServiceTypeSelector?
    var sectionsSelector: ServiceTypeSelector?
    var serviceSelector: ServiceTypeSelector?
    
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

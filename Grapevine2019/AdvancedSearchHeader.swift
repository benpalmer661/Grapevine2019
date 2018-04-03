//
//  AdvancedSearchHeader.swift
//  Grapevine 2017
//
//  Created by Ben Palmer on 22/11/17.
//  Copyright © 2017 Ben Palmer. All rights reserved.
//

import Foundation
import UIKit
import CoreData
import Firebase
import CoreLocation




class Header: UITableViewHeaderFooterView {

    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        setupViews()
    }




    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    let nameLabel: UILabel = {
        let label = UILabel()
        //label.text = ""
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


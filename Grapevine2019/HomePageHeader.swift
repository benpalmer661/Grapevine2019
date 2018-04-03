//
//  HomePageHeader.swift
//  Grapevine2019
//
//  Created by Ben Palmer on 3/1/18.
//  Copyright © 2018 Ben Palmer. All rights reserved.
//



import Foundation
import UIKit
import Firebase
import FirebaseAuth




protocol HomePageHeaderDelegate {
    
    func homePageShowAdvancedSearchController()
    func uploadPhoto()
    func closeOpenHeader()
   func  changeCellTypeToLarge()
    func changeCellTypeToSmall()
    
}




class HomePageHeader: UICollectionViewCell {
    
    var delegate: HomePageHeaderDelegate?
    
    
    
    let defaults = UserDefaults.standard
    
    
    
    var currentUser: User2? {
        didSet {
            
            
            let homePage = HomePage(collectionViewLayout: UICollectionViewFlowLayout())
            
            
            //set profile image
            guard let profileImageUrl = currentUser?.profileImageURL
                else { return }
            profileImageView.loadImage(urlString: profileImageUrl)
            
            print("this is profile image url \(profileImageUrl)")
            
            // set username label
            guard let displayName = currentUser?.DisplayName else {return}
            usernameLabel.text = displayName
            print(displayName)
            
            
            // set subtitle label
            guard let subtitle = currentUser?.subtitle else {return}
            subtitleLabel.text = subtitle
            print(subtitle)
            
            
            //set online offline status
            guard let status = currentUser?.onlineOfflineStatus else { return }
            onlineOfflineStatusLabel.text = status
            
            
            guard let currentLocation = currentUser?.Location else { return }
            locationLabel.text = currentLocation
            
            
           
            guard let searchLocation = self.defaults.string(forKey: "searchLocation") else { return }
            
            searchingCityLabel.text = "Searching: \(String(describing: searchLocation))"
            
            
            homePage.collectionView?.reloadData()
            
        }
    }
    
    
    var usersLocation: String?{
        didSet{
            
            
          

            
            guard let location = usersLocation else { return }
           // locationLabel.text = location
        }
    }
    
    
    
    let onlineOfflineSwitch: UISwitch = {
        let s = UISwitch()
        
        return s
    }()
    
    
    
    let profileImageView: CustomImageView = {
        let iv = CustomImageView()
        iv.clipsToBounds = true
        iv.contentMode = .scaleAspectFill
        iv.backgroundColor = .white
        return iv
    }()
    
    
    lazy var advancedSearchButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(#imageLiteral(resourceName: "search_selected"), for: .normal)
        button.tintColor = UIColor.black
        button.addTarget(self, action: #selector(showAdvancedSearchController), for: .touchUpInside)
        return button
    }()
    
    lazy var advancedSearchWordButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("refine", for: .normal)
        
        button.tintColor = UIColor.black
        button.addTarget(self, action: #selector(showAdvancedSearchController), for: .touchUpInside)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        
        return button
    }()
    
    
    func showAdvancedSearchController(){
        delegate?.homePageShowAdvancedSearchController()
    }
    
    
    lazy var uploadPhotoButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Upload Photo", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        
        button.layer.borderColor = UIColor.lightGray.cgColor
        button.addTarget(self, action: #selector(uploadPhoto), for: .touchUpInside)
        return button
    }()
    
  
    
    
    
    func uploadPhoto(){
        print("uploading photo")
        delegate?.uploadPhoto()
    }
    
    
    
    
    
//    / have this segue to a view controller which says:  Select Your Location , selecting the correct Region that your are in will help others locate you,  grapevine will not allow you to select a city as your location that you are not with 200km of
//    
//
//     you can have a coordinate for perth city and if someone chooses a city and they are not with 200km it will now allow them to chooes this city, if they actually are there will a button for them to update their location.
//    
    
    // get coordinates 
    // compare distance with coordinates of cities , Perth , Brisbane, Adelaide etc,
    //return the closest city
    // if closest city is equal to defaults closest city, do nothing else
    //updated database with new closest city.
    
    
    lazy var yourCityButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Your City: Perth", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        
        button.layer.borderColor = UIColor.lightGray.cgColor
        button.addTarget(self, action: #selector(uploadPhoto), for: .touchUpInside)
        return button
    }()
    
    
    
    func selectYourCity(){
        
        
    }
    
    
    
    
    
    
    
    
    
    
    
    
    lazy var gridButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(#imageLiteral(resourceName: "grid"), for: .normal)
        button.addTarget(self, action: #selector(handleChangeToGridView), for: .touchUpInside)
        return button
    }()
    
    func handleChangeToGridView() {
                    print("Changing to grid view")
                    gridButton.tintColor = .mainBlue()
        
                    listButton.tintColor = UIColor(white: 0, alpha: 0.2)
                    delegate?.changeCellTypeToSmall()
    }
    
    
    
    
    lazy var listButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(#imageLiteral(resourceName: "list"), for: .normal)
        button.tintColor = UIColor(white: 0, alpha: 0.2)
        button.addTarget(self, action: #selector(handleChangeToListView), for: .touchUpInside)
        return button
    }()
    
    
    
    func handleChangeToListView() {
                    print("Changing to list view")
                    listButton.tintColor = .mainBlue()
                    gridButton.tintColor = UIColor(white: 0, alpha: 0.2)
                delegate?.changeCellTypeToLarge()
    }
    

    
    
    
    lazy var bookmarkButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(#imageLiteral(resourceName: "ribbon"), for: .normal)
        button.tintColor = UIColor(white: 0, alpha: 0.2)
        button.addTarget(self, action: #selector(closeOpenHeader), for: .touchUpInside)
        
        return button
    }()
    
    func closeOpenHeader(){
             delegate?.closeOpenHeader()
    }
    
    
    
    
    let onlineOfflineStatusLabel: UILabel = {
        let label = UILabel()
        label.text = "offline"
        label.font = UIFont.boldSystemFont(ofSize: 14)
        return label
    }()
    
    lazy var locationLabel: UILabel = {
        let label = UILabel()
        label.text = "Your Location:"
        label.font = UIFont.boldSystemFont(ofSize: 12)
        label.backgroundColor = UIColor.white
        return label
    }()
    
    
    lazy var searchingCityLabel: UILabel = {
        let label = UILabel()
        label.text = "Searching:"
        label.font = UIFont.boldSystemFont(ofSize: 12)
        label.backgroundColor = UIColor.white
        label.textAlignment = .right
        return label
    }()
    
    
    let usernameLabel: UILabel = {
        let label = UILabel()
        label.text = "loading Username..."
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.backgroundColor = UIColor.white
        return label
    }()
    
    
    let subtitleLabel: UILabel = {
        let label = UILabel()
        label.text = "loading subtitle..."
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.textColor = UIColor.lightGray
        label.backgroundColor = UIColor.white
        return label
    }()
    
    
    
    
    
    
    let postsLabel: UILabel = {
        let label = UILabel()
        
        let attributedText = NSMutableAttributedString(string: "11\n", attributes: [NSFontAttributeName: UIFont.boldSystemFont(ofSize: 14)])
        
        attributedText.append(NSAttributedString(string: "posts", attributes: [NSForegroundColorAttributeName: UIColor.lightGray, NSFontAttributeName: UIFont.systemFont(ofSize: 14)]))
        
        label.attributedText = attributedText
        
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()
    
    let followersLabel: UILabel = {
        let label = UILabel()
        
        let attributedText = NSMutableAttributedString(string: "0\n", attributes: [NSFontAttributeName: UIFont.boldSystemFont(ofSize: 14)])
        
        attributedText.append(NSAttributedString(string: "followers", attributes: [NSForegroundColorAttributeName: UIColor.lightGray, NSFontAttributeName: UIFont.systemFont(ofSize: 14)]))
        
        label.attributedText = attributedText
        
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()
    
    let followingLabel: UILabel = {
        let label = UILabel()
        
        let attributedText = NSMutableAttributedString(string: "0\n", attributes: [NSFontAttributeName: UIFont.boldSystemFont(ofSize: 14)])
        
        attributedText.append(NSAttributedString(string: "following", attributes: [NSForegroundColorAttributeName: UIColor.lightGray, NSFontAttributeName: UIFont.systemFont(ofSize: 14)]))
        
        label.attributedText = attributedText
        
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }()
    
    
     var headerOpen = true
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        //this color will be overriden if set in HomePage under the viewForSupplementaryElementOfKind kind func
        backgroundColor = UIColor.white
        
        setupBottomToolbar()
        
        
       
      
        
        addSubview(onlineOfflineStatusLabel)
        addSubview(locationLabel)
        addSubview(profileImageView)
        addSubview(usernameLabel)
        addSubview(subtitleLabel)
        addSubview(searchingCityLabel)
        addSubview(uploadPhotoButton)
        //addSubview(searchingViaLabel)
        
        
        onlineOfflineStatusLabel.anchor(top: topAnchor, left: self.leftAnchor, bottom: nil, right: nil, paddingTop: 2, paddingLeft: 16, paddingBottom: 0, paddingRight: 0, width: 80, height: 15)
        
        
        
        uploadPhotoButton.anchor(top: topAnchor, left: nil , bottom: nil, right: self.rightAnchor, paddingTop: 2, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 110, height: 15)
        
        
      
        
        profileImageView.anchor(top: onlineOfflineStatusLabel.bottomAnchor, left: leftAnchor, bottom: nil, right: nil, paddingTop: 8, paddingLeft: 8, paddingBottom: 0, paddingRight: 0, width: 70, height: 70)
        profileImageView.layer.cornerRadius = 70 / 2
        profileImageView.clipsToBounds = true
        
        
        
        
        
        locationLabel.anchor(top: profileImageView.bottomAnchor, left: leftAnchor, bottom: nil, right: nil, paddingTop: 20, paddingLeft: 8, paddingBottom: 0, paddingRight: 0, width: 150, height: 20)
        
        
        
        
        searchingCityLabel.anchor(top: profileImageView.bottomAnchor, left: nil, bottom: nil, right: rightAnchor, paddingTop: 20, paddingLeft: 0, paddingBottom: 0, paddingRight: 8, width: 150, height: 20)
        
         //searchingCityLabel.centerYAnchor.constraint(equalTo: locationLabel.centerYAnchor)
        
        
        
        usernameLabel.anchor(top: profileImageView.topAnchor, left: profileImageView.rightAnchor, bottom: nil, right: nil, paddingTop: 4, paddingLeft: 16, paddingBottom: 0, paddingRight: 0, width: 140, height: 0)
        
        
        
        
        subtitleLabel.anchor(top: usernameLabel.bottomAnchor, left: profileImageView.rightAnchor, bottom: nil, right: nil, paddingTop: 3, paddingLeft: 17, paddingBottom: 0, paddingRight: 0, width: 140, height: 0)
        
        
        addSubview(advancedSearchButton)
        addSubview(advancedSearchWordButton)
        
        
        
        advancedSearchButton.anchor(top: profileImageView.topAnchor, left: nil, bottom: nil, right: rightAnchor, paddingTop: 12, paddingLeft: 0, paddingBottom: 0, paddingRight: 35, width: 25, height: 25)
        
        advancedSearchWordButton.anchor(top: advancedSearchButton.bottomAnchor, left: nil, bottom: nil, right: rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 9, width: 80, height: 25)
        
        advancedSearchWordButton.centerXAnchor.constraint(equalTo: advancedSearchButton.centerXAnchor)
    
    
    }
    
    
    fileprivate func setupBottomToolbar() {
        
        let topDividerView = UIView()
        topDividerView.backgroundColor = UIColor.lightGray
        
        let bottomDividerView = UIView()
        bottomDividerView.backgroundColor = UIColor.lightGray
        
        let stackView1 = UIStackView(arrangedSubviews: [gridButton, listButton, bookmarkButton])
        
        stackView1.axis = .horizontal
        stackView1.distribution = .fillEqually
        
        addSubview(stackView1)
        addSubview(topDividerView)
        addSubview(bottomDividerView)
        
        stackView1.anchor(top: nil, left: leftAnchor, bottom: self.bottomAnchor, right: rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 50)
        
        topDividerView.anchor(top: stackView1.topAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0.5)
        
        bottomDividerView.anchor(top: stackView1.bottomAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0.5)
    }
    
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}











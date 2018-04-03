////
////  CustomTabBarController.swift
////  Grapevine 2017
////
////  Created by Ben Palmer on 22/8/17.
////  Copyright © 2017 Ben Palmer. All rights reserved.
////
//
import UIKit

class CustomTabBarController: UITabBarController, UISearchBarDelegate {
    
    


    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    
        
        
        //colour for tab titles
        UITabBarItem.appearance().setTitleTextAttributes([NSForegroundColorAttributeName: UIColor.black], for: .normal)
        
        
        /////HomePage///////
        
        
         let homePage_VC =  HomePage(collectionViewLayout: UICollectionViewFlowLayout())
         let navigationController = UINavigationController(rootViewController: homePage_VC)
        
        
       
    
        navigationController.title = "Home"
        navigationController.tabBarItem.image = UIImage(named: "icons8-Home Filled-35")?.withRenderingMode(.alwaysOriginal)
        
        
        
        /////CONTACTS///////
        
        let Contacts_Vc = Contacts(collectionViewLayout: UICollectionViewFlowLayout())
        let navigationController2 = UINavigationController(rootViewController: Contacts_Vc)
        
        navigationController2.title =  "Contacts"
        
        navigationController2.tabBarItem.image = UIImage(named:  "icons8-Address Book 2 Filled-35")?.withRenderingMode(.alwaysOriginal)
        
        
        
        /////PROFILE///////
       
        
        let profile_Vc = MyProfile(collectionViewLayout: UICollectionViewFlowLayout())
        let navigationController3 = UINavigationController(rootViewController: profile_Vc)
        
        navigationController3.title =  "My Profile"
        navigationController3.tabBarItem.image = UIImage(named:  "icons8-User Filled-35")?.withRenderingMode(.alwaysOriginal)
        
        
        
        /////MAIL PAGE///////
        
        
        let MailController = MessagesController()
        let navigationController4 = UINavigationController(rootViewController: MailController)
        
        
        navigationController4.title = "Mail"
        navigationController4.tabBarItem.image = UIImage(named: "icons8-Message Filled-35")?.withRenderingMode(.alwaysOriginal)
        
        
        
        /////map page///////
        
        
        let locationController = LocationController()
        let navigationController5 = UINavigationController(rootViewController: locationController)
        
     
        navigationController5.title = "Map"
        navigationController5.tabBarItem.image = UIImage(named: "icons8-Map Marker Filled-35")?.withRenderingMode(.alwaysOriginal)
        
        
//        
//    
//        
//        
//        
        ///////////////////photo selector Controller////////////////////
        
        
        
        let photoSelectorController = FriendsController(collectionViewLayout: UICollectionViewFlowLayout())
        let navigationController7 = UINavigationController(rootViewController: photoSelectorController)
        
        navigationController7.title =  "Friends"
        navigationController7.tabBarItem.image = UIImage(named:  "icons8-Plus Filled-35")?.withRenderingMode(.alwaysOriginal)
        
        
//
//
        
        /// new messages controller ///////
        
        let NMC = BlockedUsers(collectionViewLayout: UICollectionViewFlowLayout())
        let navigationController9 = UINavigationController(rootViewController: NMC)
        
        
        navigationController9.title = "Blocked Users"
        navigationController9.tabBarItem.image = UIImage(named: "icons8-Settings Filled-35")?.withRenderingMode(.alwaysOriginal)
        
        
        
        
        
        
        
        
        /////// edit profile controller /////
        
        let PE = FriendsRequestsController(collectionViewLayout: UICollectionViewFlowLayout())
        let navigationController11 = UINavigationController(rootViewController: PE)
        
        
        navigationController11.title = "Friend Resquests"
        navigationController11.tabBarItem.image = UIImage(named: "icons8-Settings Filled-35")?.withRenderingMode(.alwaysOriginal)
        
        
      
//        
        /////// HomePageAllUsers controller /////
        
        let homePageAllUsers = HomePageAllUsers(collectionViewLayout: UICollectionViewFlowLayout())
        let navigationController14 = UINavigationController(rootViewController: homePageAllUsers)
        
        
        navigationController14.title = "Home Page All Users"
        navigationController14.tabBarItem.image = UIImage(named: "icons8-Settings Filled-35")?.withRenderingMode(.alwaysOriginal)
        
        
        
        
//        viewControllers = [navigationController, navigationController2,navigationController3, navigationController4,navigationController5,navigationController7,navigationController9,navigationController11, navigationController14]
        
        
        viewControllers = [navigationController, navigationController2,navigationController3, navigationController4,navigationController5,navigationController14,navigationController11,navigationController7,navigationController9]
    
  
}

}

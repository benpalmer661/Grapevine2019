//
//  NewMessageController.swift
//  Grapevine 2017

//  Created by Ben Palmer on 20/10/17.
//  Copyright © 2017 Ben Palmer. All rights reserved.


import Foundation

import UIKit
import Firebase

class NewMessageController: UITableViewController {
    
    let cellId = "cellId"
    
    var users = [User2]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "New Message"
        
        tableView.separatorStyle = .none
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(handleCancel))
        
        tableView.register(UserCell2.self, forCellReuseIdentifier: cellId)
     
        //fetchUser()
        firestoreFetchContactsUserIds()
    }
    
     
    
    
    
    
    
    
    fileprivate func firestoreFetchContactsUserIds() {
        
        guard let uid = Auth.auth().currentUser?.uid else { return }
        
        
        let db = Firestore.firestore()
        
        
        ////// GET ALL DOCUMENTS IN A COLLECTION////////////////
        db.collection("Users").document(uid).collection("Contacts").getDocuments() { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                for document in querySnapshot!.documents {
                    
                    //print("\(document.documentID) => \(document.data())")
                    
                    
                    let d = document.data()
                    
                    d.forEach({ (key: String, value: Any) in
                        
                        print("this is the key",key)
                        
                        
                        Database.firestorefetchUserWithUID(uid: key, completion: { (user) in
                            
                            self.users.append(user)
                            
                            self.tableView.reloadData()
                        }
                            
                        )}
                        
                    )}
            }
        }
    }
    
    
    
    
    
    
    
    
    
    func handleCancel() {
        dismiss(animated: true, completion: nil)
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! UserCell2
        
        let user = users[indexPath.row]
        cell.textLabel?.text = user.DisplayName
        cell.detailTextLabel?.text = user.email
        
        
      
        
        let profileImageUrl = user.profileImageURL
        
        cell.profileImageView.loadImageUsingCacheWithUrlString(urlString: profileImageUrl)
        

        let accountTypeImageView = user.accountTypeImageUrl
        
        cell.AccountTypeImage.loadImageUsingCacheWithUrlString(urlString: accountTypeImageView)
    
        
        
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 55
    }
    
    
 
    
    var messagesController: MessagesController?
    
    
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        dismiss(animated: true) {
            print("Dismiss completed")
            let user = self.users[indexPath.row]
            
            print("new message controller user",user)
            
            self.messagesController?.showChatControllerForUser(user)
        }
    }
    
}
 



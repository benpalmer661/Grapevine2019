//
//  MyProfile.swift
//  Grapevine 2017
//
//  Created by Ben Palmer on 20/10/17.
//  Copyright © 2017 Ben Palmer. All rights reserved.
//

import Foundation
import UIKit
import Firebase
import FirebaseAuth
import CoreLocation


class MyProfile: UICollectionViewController, UICollectionViewDelegateFlowLayout, MyProfileHeaderDelegate,ProfileHeaderClosedDelegate {
    
    let cellId = "cellId"
    let homePostCellId = "homePostCellId"
    
    var userId: String?
    
    var isGridView = true
    
    let headerIdClosed = "headerIdClosed"
    
    
    var activityIndicator:UIActivityIndicatorView = UIActivityIndicatorView()
    
    
    var largeCell = false
    
    
    
    func changeCellTypeToLarge(){
        if largeCell == false {
            largeCell = true
            print("header open is false")
            
            collectionView?.reloadData()
        }
        
    }
    
    func changeCellTypeToSmall(){
        
        if largeCell == true{
            largeCell = false
            collectionView?.reloadData()
        }
        
    }

    
    func activityIndicatorStart(){
        activityIndicator.center = self.view.center
        activityIndicator.hidesWhenStopped = true
        activityIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.gray
        view.addSubview(activityIndicator)
        
        activityIndicator.startAnimating()
        
    }
    
    
    
    
    
    
    
    var headerOpen = true
    
    
    func homePageShowAdvancedSearchController(){
        
    }
    
   
    
    
    func closeOpenHeader(){
        
        if headerOpen == true {
            headerOpen = false
            print("header open is false")
            
            collectionView?.reloadData()
        } else if headerOpen == false {
            
            headerOpen = true
            print("header open is true")
            
            collectionView?.reloadData()
        }
        
        
    }

   
    
    
    func changeNumber(){
        
        //1. Create the alert controller.
        let alert = UIAlertController(title: "Change Number", message: "Please enter your new number", preferredStyle: .alert)
        
        //2. Add the text field. You can configure it however you need.
        
        guard let contactNumber = user?.contactNumber else { return }
        

        alert.addTextField { (textField) in
            textField.text = "\(contactNumber)"
        }
        
        // 3. Grab the value from the text field, and print it when the user clicks OK.
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { [weak alert] (_) in
            let textField = alert?.textFields![0] // Force unwrapping because we know it exists.
            print("Text field: \(String(describing: textField?.text))")
            
            
            guard let number = textField?.text else { return }
            
            guard let uid = Auth.auth().currentUser?.uid else { return }
            
            
            let db = Firestore.firestore()
            
            let values = ["Contact Number": number]
            
            db.collection("Users").document(uid).setData(values, options: SetOptions.merge())
            
        self.viewWillAppear(true)
            
        }))
        
        // 4. Present the alert.
        self.present(alert, animated: true, completion: nil)
        
    }
    
    
    
    
    func activityIndicatorFinish(){
        activityIndicator.stopAnimating()
        
    }
    
    
    func openChatLogController(){
        let chatLogController = ChatLogController(collectionViewLayout: UICollectionViewFlowLayout())
        chatLogController.user = self.user
        navigationController?.pushViewController(chatLogController, animated: true)
    }
    
    
    func didTapEditProfile(){
        print("didTapEditProfile")
        let profileEditor = ProfileEditor(collectionViewLayout: UICollectionViewFlowLayout())
        profileEditor.user = self.user
        navigationController?.pushViewController(profileEditor, animated: true)
    }
    
    
   
    
    
    func changeDisplayName(){
        
        
            let alert = UIAlertController(title: "Change Display Name", message: "Please enter your new display name", preferredStyle: .alert)
            
            //2. Add the text field. You can configure it however you need.
            
            guard let displayName = user?.DisplayName else { return }
            
        
            alert.addTextField { (textField) in
                textField.text = "\(displayName)"
            }
            
            // 3. Grab the value from the text field, and print it when the user clicks OK.
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { [weak alert] (_) in
                let textField = alert?.textFields![0] // Force unwrapping because we know it exists.
                print("Text field: \(String(describing: textField?.text))")
                
                
                guard let displayName = textField?.text else { return }
                
                guard let uid = Auth.auth().currentUser?.uid else { return }
                
                
                let db = Firestore.firestore()
                
                
                let values = ["Display Name": displayName]
                
                
                
                db.collection("Users").document(uid).setData(values, options: SetOptions.merge())
                
                self.viewWillAppear(true)
                
            }))
            
            // 4. Present the alert.
            self.present(alert, animated: true, completion: nil)
            
        
    }
    
    
    
    func changeSubtitle(){
        
        //1. Create the alert controller.
        let alert = UIAlertController(title: "Change Subtitle", message: "Please enter your new subtitle.", preferredStyle: .alert)
        
        //2. Add the text field. You can configure it however you need.
        
        guard let subtitle = user?.subtitle else { return }
        
        
        alert.addTextField { (textField) in
            textField.text = "\(subtitle)"
        }
        
        // 3. Grab the value from the text field, and print it when the user clicks OK.
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { [weak alert] (_) in
            let textField = alert?.textFields![0] // Force unwrapping because we know it exists.
            print("Text field: \(String(describing: textField?.text))")
            
            
            guard let subtitle = textField?.text else { return }
            
            guard let uid = Auth.auth().currentUser?.uid else { return }
            
            
            let db = Firestore.firestore()
            
            let values = ["Subtitle": subtitle]
            
            
            
            db.collection("Users").document(uid).setData(values, options: SetOptions.merge())
            
            self.viewWillAppear(true)
            
        }))
        
        // 4. Present the alert.
        self.present(alert, animated: true, completion: nil)
        

    }
    
    
    func didChangeToGridView() {
        isGridView = true
        collectionView?.reloadData()
        
    }
    
    
    func didChangeToListView() {
        
        isGridView = false
        collectionView?.reloadData()
    }
    
    func presentTagWordsController(){
        
        let tagWordsViewController = tagWordsController()
     
        navigationController?.pushViewController(tagWordsViewController, animated: true)
    }
    
    
    func presentEditServicesController(){
        let myServiceTypeSelectorController = MyServiceTypeSelector()
        
        navigationController?.pushViewController(myServiceTypeSelectorController, animated: true)
    }
    
    
    func uploadPhoto(){
        let photoSelectorController = PhotoSelectorController(collectionViewLayout: UICollectionViewFlowLayout())
        
        navigationController?.pushViewController(photoSelectorController, animated: true)
        
        
    }
    
    
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    
        let alert = UIAlertController(title: "",
                                      message: "",
                                      preferredStyle: .alert)
        
        
        // Change font of the title and message
        let titleFont:[String : AnyObject] = [ NSFontAttributeName : UIFont(name: "AmericanTypewriter", size: 18)! ]
        let messageFont:[String : AnyObject] = [ NSFontAttributeName : UIFont(name: "HelveticaNeue-Thin", size: 14)! ]
        let attributedTitle = NSMutableAttributedString(string: "Please Make A Selection", attributes: titleFont)
        let attributedMessage = NSMutableAttributedString(string: "", attributes: messageFont)
        alert.setValue(attributedTitle, forKey: "attributedTitle")
        alert.setValue(attributedMessage, forKey: "attributedMessage")
        
        
        
        let action1 = UIAlertAction(title: "Delete Image", style: .default, handler: { (action) -> Void in
            print("delete image selected")
            
            
                        guard let uid = Auth.auth().currentUser?.uid else { return }
            
                        let post = self.posts[indexPath.item]
            
                        self.posts.remove(at: indexPath.item)
            
                        self.collectionView?.deleteItems(at: [indexPath])
            
                        guard let postId = post.id else { return }
            
                        Database.database().reference().child("posts").child(uid).child(postId).removeValue { (err, ref) in
            
                            if let err = err {
                                print("Failed to block user:", err)
                                return
                            }
                            print("Successfully removed post from firebase database")
                            self.reloadInputViews()
                        }

            
            
            
        })
        
        let action2 = UIAlertAction(title: "Set as Profile Picture", style: .default, handler: { (action) -> Void in
           
            
            
            guard let uid = Auth.auth().currentUser?.uid else { return }
                       
                let post = self.posts[indexPath.item]
            
           let imageUrl = post.imageUrl
            
            
            let db = Firestore.firestore()
            
            db.collection("Users").document(uid).setData(["profileImageUrl": imageUrl], options: SetOptions.merge())
            
            
            self.collectionView?.reloadData()
            self.viewWillAppear(true)
            
       
        })
        
       
        
        // Cancel button
        let cancel = UIAlertAction(title: "Cancel", style: .destructive, handler: { (action) -> Void in })
    
        alert.addAction(action1)
        alert.addAction(action2)
        alert.addAction(cancel)
        present(alert, animated: true, completion: nil)
        
        
        
        
        
        
        
        
        
//        // Declare Alert
//        let dialogMessage = UIAlertController(title: "Please Confirm", message: "Are you sure you want to delete this image?", preferredStyle: .alert)
//        
//        
//        // Create Cancel button with action handlder
//        let cancel = UIAlertAction(title: "Cancel", style: .cancel) { (action) -> Void in
//            print("Cancel button click...")
//        }
//        
//        
//        // Create OK button with action handler
//        let ok = UIAlertAction(title: "Yes", style: .default, handler: { (action) -> Void in
//            print("Ok button click...")
//            
//            
//            guard let uid = Auth.auth().currentUser?.uid else { return }
//            
//            let post = self.posts[indexPath.item]
//            
//            self.posts.remove(at: indexPath.item)
//            
//            self.collectionView?.deleteItems(at: [indexPath])
//            
//            guard let postId = post.id else { return }
//            
//            Database.database().reference().child("posts").child(uid).child(postId).removeValue { (err, ref) in
//                
//                if let err = err {
//                    print("Failed to block user:", err)
//                    return
//                }
//                print("Successfully removed post from firebase database")
//                self.reloadInputViews()
//            }
//        })
//        
//        
//        
//        //Add OK and Cancel button to dialog message
//           dialogMessage.addAction(cancel)
//        dialogMessage.addAction(ok)
//     
//        // Present dialog message to user
//        self.present(dialogMessage, animated: true, completion: nil)
    }

    
    
    
    
    
    
    override func viewWillAppear(_ animated: Bool) {
        fetchUser()
        //collectionView?.reloadData()
        //collectionView?.reloadInputViews()
        
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        

        self.navigationItem.backBarButtonItem = UIBarButtonItem(title:"", style:.plain, target:nil, action:nil)
    
         collectionView?.register(ProfileHeaderClosed.self, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: headerIdClosed)
      
        navigationItem.title = "My Profile"
        
        collectionView?.backgroundColor = .white
        
        //register header cell
        collectionView?.register(MyProfileHeader.self, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: "headerId")
        
        collectionView?.register(UserProfilePhotoCell.self, forCellWithReuseIdentifier: cellId)
        
        collectionView?.register(HomePostCell.self, forCellWithReuseIdentifier: homePostCellId)
        
        //setupLogOutButton()
        
        fetchUser()
        fetchOrderedPosts()
    }
    
    
    
    
    
    var user: User2?
    fileprivate func fetchUser() {
        
        //guard let uid = user?.userId else {return}
        
        guard let uid = Auth.auth().currentUser?.uid else { return }
               
        Database.firestorefetchUserWithUID(uid: uid) { (user) in
        
        
        //Database.fetchUserWithUID(uid: uid) { (user) in
            self.user = user
            
            
            self.collectionView?.reloadData()
            
            self.paginatePosts()
        }
    }
    
    
    
    
    
    var isFinishedPaging = false
    var posts = [Post]()
    
    
    fileprivate func paginatePosts(){
        print("start paging for more posts")
        
        
        guard let uid = Auth.auth().currentUser?.uid else { return }
        
        
//        guard let uid = self.user?.uid else {return}
        
        let ref = Database.database().reference().child("posts").child(uid)
        
        
        //var query = ref.queryOrderedByKey()
        
        
        var query = ref.queryOrdered(byChild: "creationDate")
        
        if posts.count > 0 {
            
            let value = posts.last?.creationDate.timeIntervalSince1970
            
            query = query.queryEnding(atValue: value)
        }
        
        
        query.queryLimited(toLast: 4).observeSingleEvent(of: .value, with: { (snapshot) in
            
            
            
            guard var allObjects = snapshot.children.allObjects as? [DataSnapshot] else {return}
            
            allObjects.reverse()
            
            
            
            if allObjects.count < 4 {
                self.isFinishedPaging = true
            }
            
            if self.posts.count > 0 && allObjects.count > 0 {
                allObjects.removeFirst()
            }
            
            
            guard let user = self.user else {return}
            
            allObjects.forEach({ (snapshot) in
                
                guard let dictionary = snapshot.value as? [String: Any] else {return}
                
                
                var post = Post(user: user, dictionary: dictionary)
                
                post.id = snapshot.key
                
                self.posts.append(post)
                
            })
            
            self.posts.forEach({ (post) in
                print(post.id ?? "")
            })
            
            self.collectionView?.reloadData()
            
        }) { (err) in
            print("failed to paginate",err)
        }
        
    }
    
    
    
    
    fileprivate func fetchOrderedPosts() {
        guard let uid = self.user?.uid else { return }
        let ref = Database.database().reference().child("posts").child(uid)
        
        //perhaps later on we'll implement some pagination of data
        ref.queryOrdered(byChild: "creationDate").observe(.childAdded, with: { (snapshot) in
            guard let dictionary = snapshot.value as? [String: Any] else { return }
            
            guard let user = self.user else { return }
            
            let post = Post(user: user, dictionary: dictionary)
            
            self.posts.insert(post, at: 0)
            //            self.posts.append(post)
            
            self.collectionView?.reloadData()
            
        }) { (err) in
            print("Failed to fetch ordered posts:", err)
        }
    }
    
    fileprivate func setupLogOutButton() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "gear").withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(handleLogOut))
        
        
    }
    
    
    
    func handleLogOut() {
        let alertController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        
        alertController.addAction(UIAlertAction(title: "Log Out", style: .destructive, handler: { (_) in
            
            do {
                try Auth.auth().signOut()
                
                //what happens? we need to present some kind of login controller
                let loginController = SignInVC()
                let navController = UINavigationController(rootViewController: loginController)
                self.present(navController, animated: true, completion: nil)
                
            } catch let signOutErr {
                print("Failed to sign out:", signOutErr)
            }
            
            
        }))
        
        alertController.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        present(alertController, animated: true, completion: nil)
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return posts.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        
        
        //show you how to fire off the paginate call
        
        if indexPath.item == self.posts.count - 1 && !isFinishedPaging {
            print("paginating for posts")
            paginatePosts()
        }
        
        
        
        
        if isGridView{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! UserProfilePhotoCell
            
            cell.post = posts[indexPath.item]
            
            return cell
        }else {
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: homePostCellId, for: indexPath) as! HomePostCell
            
            cell.post = posts[indexPath.item]
            
            return cell
            
            
        }
        
     
        
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        
        if isGridView {
            let width = (view.frame.width - 2) / 3
            return CGSize(width: width, height: width)
            
        }else {
            
            var height: CGFloat = 40 + 8 + 8 //username userprofileimageview
            height += view.frame.width
            height += 50
            height += 60
            
            return CGSize(width: view.frame.width, height: height)
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        if self.headerOpen == true {
            
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "headerId", for: indexPath) as! MyProfileHeader
        
        header.user = self.user
        header.delegate = self
        
        //not correct
        //header.addSubview(UIImageView())
        
        return header
    
    } else {
    
    let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: headerIdClosed, for: indexPath) as! ProfileHeaderClosed
            
            header.currentUser = self.user
            header.delegate = self
    reloadInputViews()
    
    return header
    
    }
    }
    
    
    
    
    
    
    
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        if headerOpen == true {
            return CGSize(width: view.frame.width, height: 500)
        } else {
            return CGSize(width: view.frame.width, height: 50)
        }
    }
    
    
    
    
}




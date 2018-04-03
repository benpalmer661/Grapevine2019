//
//  ProfilePage.swift
//  Grapevine 2017
//
//  Created by Ben Palmer on 28/9/17.
//  Copyright © 2017 Ben Palmer. All rights reserved.
//
import UIKit
import Firebase
import FirebaseAuth
import CoreLocation


class UserProfileController: UICollectionViewController, UICollectionViewDelegateFlowLayout, UserProfileHeaderDelegate, ProfileHeaderClosedDelegate {
    
    
    func openChatLogController() {
        print("opening chat log controller")
        
    
      self.showChatControllerForUser(user!)
        
    }
    
    


    override func viewWillAppear(_ animated: Bool) {
        
        fetchUser()
    }
    
    
    func presentFRC() {
        
        let PE = FriendsRequestsController(collectionViewLayout: UICollectionViewFlowLayout())
        let NPE = UINavigationController(rootViewController: PE)
        self.present(NPE, animated: true, completion: nil)
    }
    
    
    var db = Firestore.firestore()
    
    
    
    
    func sendFriendRequest(){
        
        
        //check if friends
        
        guard let uid = Auth.auth().currentUser?.uid else { return }
        
        
        guard let user = self.user?.uid else { return }
        
        
        print("users is", user)
        
        print("this is uid", uid)
        
        self.db.collection("Users").document(user).collection("Friends").document(uid).getDocument(completion: { (document, error) in
            
            if (document?.exists)!{
                
                // do nothing
                
                
            } else {
                
                
              //if not friends add a pending friend request to database 
                
                print("func called from inside UserProfileController")
                
                guard let uid = Auth.auth().currentUser?.uid else { return }
                
                guard let user = self.user?.uid else { return }
                
                print("this is user uid ?", user)
                
                let db = Firestore.firestore()
                
                db.collection("Users").document(user).collection("Pending Requests").document(uid).setData([uid:uid], options: SetOptions.merge())
                
                
              
                
            }
        })

        
        
    }
    
    
    
    
    func homePageShowAdvancedSearchController(){
        
    }
    func uploadPhoto(){
        
    }
    
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
    
  
    
    
    func showChatControllerForUser(_ user: User2) {
        
        
        let chatLogController = ChatLogController(collectionViewLayout: UICollectionViewFlowLayout())
        chatLogController.user = user
        navigationController?.pushViewController(chatLogController, animated: true)
    }
    
  
    

    
    func callNumber(phoneNumber:String) {
        
        if let phoneCallURL = URL(string: "tel://\(phoneNumber)") {
            
            let application:UIApplication = UIApplication.shared
            if (application.canOpenURL(phoneCallURL)) {
                application.open(phoneCallURL, options: [:], completionHandler: nil)
                
            }
        }
        
//        if  let url = URL(string: "tel://\(phoneNumber)"){ UIApplication.shared.canOpenURL(url)
//        UIApplication.shared.open(url)
//        }
        
    }
    
    
    
    
    
    
    
    
    
    
    let defaults = UserDefaults.standard
    
    
    
    var currentUsersActualLocation: CLLocation?
    
    var currentUserSearchingFromLocation: CLLocation?
    
    
    
    
    
    
    
    let cellId = "cellId"
    let homePostCellId = "homePostCellId"
    
    var userId: String?
    
    var isGridView = true
    
    
//    func openChatLogController(){
//        let chatLogController = ChatLogController(collectionViewLayout: UICollectionViewFlowLayout())
//        chatLogController.user = self.user
//        navigationController?.pushViewController(chatLogController, animated: true)
//        
//        
//    }
//    
    
    
    
    let headerIdClosed = "headerIdClosed"
    
    
    var headerOpen = true
    
    
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

    
    func didChangeToGridView() {
        isGridView = true
        
        collectionView?.reloadData()
    }
    
    
    func didChangeToListView() {
        
        isGridView = false
        collectionView?.reloadData()
    }
    
    
    
    func reload() {
        
        
        self.collectionView?.reloadData()
        

    }
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
               navigationItem.rightBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "icons8-refresh-filled-50").withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(reload))
        
      
        collectionView?.backgroundColor = .white
        
        //register header cell
        collectionView?.register(UserProfileHeader.self, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: "headerId")
        
        collectionView?.register(UserProfilePhotoCell.self, forCellWithReuseIdentifier: cellId)
        
        collectionView?.register(HomePostCell.self, forCellWithReuseIdentifier: homePostCellId)
        
        
        collectionView?.register(ProfileHeaderClosed.self, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: headerIdClosed)
        
        
        
        
        //setupLogOutButton()
        
        //fetchOrderedPosts()
       
    }
    
    
  
    
    

    

    
    
    
    
    
    
    var user: User2?
    @objc fileprivate func fetchUser() {
        
        
        
        guard let user = user?.uid else { return  }
        
    
        Database.firestorefetchUserWithUID(uid: user) { (user) in
            self.user = user
         
            
            self.collectionView?.reloadData()
            
            self.paginatePosts()
        }
    }


    
    
    
    var isFinishedPaging = false
    var posts = [Post]()
    
    
    fileprivate func paginatePosts(){
        print("start paging for more posts")
        
        
        guard let uid = self.user?.uid else {return}
        
        let ref = Database.database().reference().child("posts").child(uid)
        
        
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
            
            var height: CGFloat = 40 + 8 + 8
            height += view.frame.width
            height += 50
            height += 60
            
            return CGSize(width: view.frame.width, height: height)
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        
        
        
        if self.headerOpen == true {
        
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "headerId", for: indexPath) as! UserProfileHeader
        
        header.user = self.user
        header.delegate = self
      
    
        
        
        
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
            return CGSize(width: view.frame.width, height: 640)
        } else {
            return CGSize(width: view.frame.width, height: 50)
        }
    }







}



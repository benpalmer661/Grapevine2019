
import Foundation
import UIKit
import Firebase
import FirebaseAuth
import CoreLocation


class FriendsRequestsController: UICollectionViewController, UICollectionViewDelegateFlowLayout,friendsRequestControllerDelegate {
    
    let cellId = "cellId"
    
    var HomePage: HomePage?
    
    // put header back later with the current users details in it
    //let headerId = "headerId"
    
    var userId: String?
    
    var isGridView = true
    
    
    var currentUserLocation: CLLocation?
    
    
 
    
  
    
    override func viewWillAppear(_ animated: Bool) {
        print("view will appear called")
      users.removeAll()
        firestoreFetchFriendsRequestsUserIds()
       
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "X", style: .plain, target: self, action: #selector(handleCancel))
        
    }
    
    
    func handleCancel() {
        dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //users.removeAll()
        
        
        
        
        collectionView?.backgroundColor = UIColor.red
        
        // register ContactsPageCell
        collectionView?.register(FriendsRequestsCell.self, forCellWithReuseIdentifier: cellId)
        
        collectionView?.backgroundColor = .white
        
        navigationItem.title = "Friend Requests"
        
        
        
    }//viewDidLoad
    
    
    
    
    
    var users = [User2]()
    
    
    
    var profilePage: UserProfileController?
    var profilePageHeader: UserProfileHeader?
    var messagesController: MessagesController?
    
    
    
    
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        
        let user = users[indexPath.item]
        
        
        let profilePage = UserProfileController(collectionViewLayout: UICollectionViewFlowLayout())
        
        profilePage.user = user
        
        navigationController?.pushViewController(profilePage, animated: true)
    }
    
    
   
    
    
    
    var userProfileController: UserProfileController?
    
    
    
    
    
    func fetch(){
        
        DispatchQueue.main.async {
            
            
            self.viewWillAppear(true)
        }
    }
    
    
    //collectionView?.reloadData()
    
     func firestoreFetchFriendsRequestsUserIds() {
        
        
        print("firestoreFetchFriendsRequestsUserIds")
        
                guard let uid = Auth.auth().currentUser?.uid else { return }
        
        
        let db = Firestore.firestore()
        
    
        
        db.collection("Users").document(uid).collection("Pending Requests").getDocuments() { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                for document in querySnapshot!.documents {
                    
                    
                    
                    let d = document.data()
                    
                    d.forEach({ (key: String, value: Any) in
                        
                        print("this is the key",key)
                        
                        
                        Database.firestorefetchUserWithUID(uid: key, completion: { (user) in
                            
                            self.users.append(user)
                            
                            
                            self.collectionView?.reloadData()
                        }
                          
                        )}
                        
                    )}
            }
            
            self.collectionView?.reloadData()
            
        }
        
        self.collectionView?.reloadData()
    }
    
    
    
    
    
    
    
    
    
    
    ///start of code for ContactsCell/////
    
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: self.cellId, for: indexPath)as! FriendsRequestsCell
        
        cell.user = users[indexPath.item]
        
        cell.delegate = self
        
        return cell
        
    }
    
    
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        print(users.count)
        return users.count
        
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (self.view.frame.width)
        return CGSize(width: width, height: 110)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    
    
    /////////end of code for ContactsCell/////////////////////
    
    
    
    
}//class



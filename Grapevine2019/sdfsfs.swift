//  
//  
//  
//  class FriendsRequestsController: UICollectionViewController, UICollectionViewDelegateFlowLayout,friendsRequestControllerDelegate {
//    
//    
//    fileprivate func firestoreFetchFriendsRequestsUserIds() {
//        
//        guard let uid = Auth.auth().currentUser?.uid else { return }
//        
//        let db = Firestore.firestore()
//        
//        db.collection("Users").document(uid).collection("Pending Requests").getDocuments() { (querySnapshot, err) in
//            if let err = err {
//                print("Error getting documents: \(err)")
//            } else {
//                for document in querySnapshot!.documents {
//                   
//                    let d = document.data()
//                    
//                    d.forEach({ (key: String, value: Any) in
//                        
//                        print("this is the key",key)
//                        
//                        
//                        Database.firestorefetchUserWithUID(uid: key, completion: { (user) in
//                            
//                            self.users.append(user)
//                            
//                            self.collectionView?.reloadData()
//                        }
//                        )}
//                    )}
//            }
//        }
//    }
//  }
//  
//  
//  
//  
//  
//  
//  class FriendsRequestsCell: UICollectionViewCell, CLLocationManagerDelegate  {
//  
//  
//  lazy var declineButton: UIButton = {
//    let b = UIButton(type: .system)
//    b.backgroundColor = UIColor.black
//    b.setTitle("Decline", for: .normal)
//    b.setTitleColor(UIColor.white, for: .normal)
//    b.addTarget(self, action: #selector(declineFriendRequest), for: .touchUpInside)
//    b.layer.cornerRadius = 3
//    b.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
//    
//    return b
//  }()
//  
//  func declineFriendRequest(){
// 
//    guard let userAtRow = user?.uid else { return }
//    
//    guard let uid = Auth.auth().currentUser?.uid else { return }
//    
//    let db = Firestore.firestore()
//    
//    db.collection("Users").document(uid).collection("Pending Requests").document(userAtRow).delete() { err in
//        if let err = err {
//            print("Error removing document: \(err)")
//        } else {
//            print("Document successfully removed!")
//        }
//        
//    }
//    
//    let frc = FriendsRequestsController(collectionViewLayout: UICollectionViewFlowLayout())
//    
//    frc.collectionView?.reloadData()
//    
//  }
//  }

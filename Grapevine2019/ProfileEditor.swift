//
//  ProfileEditor.swift
//  Grapevine 2017
//
//  Created by Ben Palmer on 24/10/17.
//  Copyright © 2017 Ben Palmer. All rights reserved.
//



import Foundation
import UIKit
import Firebase
import FirebaseAuth
import CoreLocation


class ProfileEditor: UICollectionViewController, UICollectionViewDelegateFlowLayout, ProfileEditorHeaderDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextFieldDelegate {
    

    
    let cellId = "cellId"
    let homePostCellId = "homePostCellId"
    
    var userId: String?
    
    var isGridView = true
    
    
    
    
    override func viewWillAppear(_ animated: Bool) {
        
        fetchUser()
        self.collectionView?.reloadData()
    
    }
    
    
    func openChatLogController(){
        let chatLogController = ChatLogController(collectionViewLayout: UICollectionViewFlowLayout())
        chatLogController.user = self.user
        navigationController?.pushViewController(chatLogController, animated: true)
        
    }
    
    
    
    func didTapEditProfile(){
        print("need to set up action")
    }
    
    
    
    
    
    func uploadPhoto(){
        print("need to set up action")
    }
    
    
    
    
    func presentTagWordsController(){
        
        let tagWordsViewController = tagWordsController()
        
        navigationController?.pushViewController(tagWordsViewController, animated: true)
    }
    
    
    func presentEditServicesController(){
        let myServiceTypeSelectorController = MyServiceTypeSelector()
        
        navigationController?.pushViewController(myServiceTypeSelectorController, animated: true)
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
    

   
    
    
    
    func didChangeToGridView() {
        isGridView = true
        
        collectionView?.reloadData()
    }
    
    
    func didChangeToListView() {
        
        isGridView = false
        collectionView?.reloadData()
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        //using the below will make the back button going back to messages controller an empty string ""
        let backButton = UIBarButtonItem()
        backButton.title = ""
        self.navigationController?.navigationBar.topItem?.backBarButtonItem = backButton
        
        navigationItem.title = "Edit Profile"
        
        collectionView?.backgroundColor = .white
        
        //register header cell
        collectionView?.register(ProfileHeaderEditor.self, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: "headerId")
        
        collectionView?.register(UserProfilePhotoCell.self, forCellWithReuseIdentifier: cellId)
        
        collectionView?.register(HomePostCell.self, forCellWithReuseIdentifier: homePostCellId)
        
        //setupLogOutButton()
        
        fetchUser()
      fetchOrderedPosts()
        
        
    
       
    }
    
    
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        
        
        let currentCharacterCount = textField.text?.characters.count ?? 0
        
        if (range.length + range.location > currentCharacterCount){
            return false
        }
        let newLength = currentCharacterCount + string.characters.count - range.length
        
        var maxLength = 0
//        if textField.isEqual(header.displayNameTextField) {
//            maxLength = 13
//        } else if textField.isEqual(header.subtitleTextField) {
//            maxLength = 5
//        }
        
        return newLength <= maxLength
        
    }
    
    
    
    
    //////////////////////start of upload profile picture code/////////////////
    
    
    var header = ProfileHeaderEditor()
    
    
    var pickedImage: UIImage?
    
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        var selectedImageFromPicker: UIImage?
        
        if let editedImage = info["UIImagePickerControllerEditedImage"] as? UIImage {
            print("is equal to edited image")
            selectedImageFromPicker = editedImage
            
        } else if let originalImage = info["UIImagePickerControllerOriginalImage"] as? UIImage {
              print("is equal to original image")
            selectedImageFromPicker = originalImage
        }
        
        
        if let selectedImage = selectedImageFromPicker {
           pickedImage = selectedImage
        }
      
        ////////////////////////////////
        
        let userID = Auth.auth().currentUser?.uid
        let imageName = NSUUID().uuidString
        let storageRef = Storage.storage().reference().child("profile images").child("\(imageName)png")
        
        if let uploadData = UIImagePNGRepresentation(pickedImage!) {
            
            storageRef.putData(uploadData, metadata: nil, completion: { (metadata, error) in
                
                if let error = error {
                    print(error)
                    return
                }
                
                if let profileImageUrl = metadata?.downloadURL()?.absoluteString {
                    
                    let values = ["profileImageUrl": profileImageUrl]
                    
                    self.registerUserIntoDatabaseWithUID(userID!, values: values as [String : AnyObject])
                }
                
                print("fetch user top called")
                 self.fetchUser()
            }
                
            )}
        
      
                    
        dismiss(animated: true, completion: nil)
        
        
    }
    
    
   
        

    
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        print("canceled picker")
        dismiss(animated: true, completion: nil)
    }
    
    
    
  func UploadProfileImageButton() {
        
        
        let picker = UIImagePickerController()
        
        picker.delegate = self
        picker.allowsEditing = true
        picker.sourceType = UIImagePickerControllerSourceType.photoLibrary
        self.present(picker, animated: true, completion: nil)
    }
    
    
    //////////////////////end of upload profile picture code/////////////////
    
    
    
    func SubmitButton() {
        
        //submitButtonADD()
        
        let userID = Auth.auth().currentUser?.uid
        let imageName = NSUUID().uuidString
        let storageRef = Storage.storage().reference().child("profile images").child("\(imageName)png")
        
        if let uploadData = UIImagePNGRepresentation(header.profileImageView.image!) {
            
            storageRef.putData(uploadData, metadata: nil, completion: { (metadata, error) in
                
                if let error = error {
                    print(error)
                    return
                }
                
                if let profileImageUrl = metadata?.downloadURL()?.absoluteString {
                    
                    let values = ["profileImageUrl": profileImageUrl]
                    
                    self.registerUserIntoDatabaseWithUID(userID!, values: values as [String : AnyObject])
                    
                    
                  
                    self.fetchUser()
                    
                    
                }
            })
        }
        
    }
    
    

    

    fileprivate func registerUserIntoDatabaseWithUID(_ uid: String, values: [String: AnyObject]) {
        
        let userID = Auth.auth().currentUser?.uid
        let ref = Database.database().reference()
        let usersReference = ref.child("Users").child(userID!)
        
        usersReference.updateChildValues(values, withCompletionBlock: { (err, ref) in
            
            if let err = err {
                print(err)
                return
            }
            
            //self.dismiss(animated: true, completion: nil)
        })
        
    }
    
    
    
    
    
    
    
    
    
    
    
    
    var user: User2?
    func fetchUser() {
        
        //guard let uid = user?.userId else {return}
        
        guard let uid = Auth.auth().currentUser?.uid else { return }
        
        
        Database.firestorefetchUserWithUID(uid: uid) { (user) in
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
    
    
    
    
    
    
    
    
    func presentBlockedUsersController(){
        print("present blocked users controller")
        
        let msts = BlockedUsers(collectionViewLayout: UICollectionViewFlowLayout())
        
        
        //let navController = UINavigationController(rootViewController: msts)
        //self.present(navController, animated: true, completion: nil)
        
        self.navigationController?.pushViewController(msts, animated: true)
        
        self.navigationController?.isNavigationBarHidden = false
        

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
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "headerId", for: indexPath) as! ProfileHeaderEditor
        
        header.user = self.user
        header.delegate = self
   
        //header.displayNameTextField.delegate = self
        
        
        return header
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: view.frame.width, height: 1000)
    }
    
    
    
    
    
    
}





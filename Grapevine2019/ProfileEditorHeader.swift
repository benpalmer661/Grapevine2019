//
//  ProfileEditorHeader.swift
//  Grapevine 2017
//
//  Created by Ben Palmer on 24/10/17.
//  Copyright © 2017 Ben Palmer. All rights reserved.
//

import Foundation
import UIKit
import Firebase



protocol ProfileEditorHeaderDelegate {
    func didChangeToListView()
    func didChangeToGridView()
    func openChatLogController()
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any])
    func UploadProfileImageButton()
    func fetchUser()
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool
    
    func didTapEditProfile()
    func uploadPhoto()
    func presentTagWordsController()
    func presentEditServicesController()
    func changeNumber()
    func changeDisplayName()
    func changeSubtitle()
    func presentBlockedUsersController()
}







class ProfileHeaderEditor: UICollectionViewCell {
    
    var delegate: ProfileEditorHeaderDelegate?
    
    var user: User2? {
        didSet {
            guard let profileImageUrl = user?.profileImageURL else { return }
//            profileImageView.loadImage(urlString: profileImageUrl)
            
            profileImageView.loadImageUsingCacheWithUrlString(urlString: profileImageUrl)
            
            topProfileImageView.loadImage(urlString: profileImageUrl)
            
            guard let displayName = user?.DisplayName else { return }
            
            
            
            displayNameButton.setTitle("\(displayName)", for: .normal)
            
            guard let subtitle = user?.subtitle else { return }
            
             subtitleButton.setTitle("\(subtitle)", for: .normal)
            
          
            
            subtitleLabel.text = user?.subtitle
            
            guard let contactNumber = user?.contactNumber else { return }
            
            
            contactNumberButton.setTitle("\(contactNumber)", for: .normal)
            
            
            guard let AccountImage = user?.accountTypeImageUrl else { return }
            topAccountTypeImageView.loadImage(urlString: AccountImage)
            
            AccountTypeImageView.loadImage(urlString: AccountImage)
            
             guard let uniqueUserID = user?.username else { return }
        
            
            
            guard let accountType = user?.accountType else { return }
            
            if accountType == "Persons" {
                
                servicesButton.isHidden = true
                tagWordsButton.isHidden = true
            } else {
               // do nothing
            }
        }
    }
    
    
    
    
    
    func EditProfile(){
        delegate?.didTapEditProfile()
    }
    
    

    
    
    
   
    
    lazy var profileImageView: UIImageView = {
        let iv = UIImageView()
        iv.backgroundColor = UIColor.white
        iv.contentMode = .scaleAspectFill
        return iv
    }()
    
    

    lazy var updateProfilePictureButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = UIColor.black
        button.setTitle("Update Profile Picture", for: .normal)
        button.setTitleColor(UIColor.white, for: .normal)
        button.addTarget(self, action: #selector(updateProfilePicture), for: .touchUpInside)
        button.layer.cornerRadius = 3
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        
        return button
    }()
    
    

    
    func updateProfilePicture(){
        print("updating profile Picture")
        delegate?.UploadProfileImageButton()
        
        
    }
    
    
    lazy var changeAccountTypeButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = UIColor.black
        button.setTitle("Change Account Type", for: .normal)
        button.setTitleColor(UIColor.white, for: .normal)
        button.addTarget(self, action: #selector(changeAccountType), for: .touchUpInside)
        button.layer.cornerRadius = 3
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        
        return button
    }()
    
    
    func changeAccountType(){
        print("update account type")
        
        
    }
    
    
    
  
    
    
    
    let topProfileImageView: CustomImageView = {
        let iv = CustomImageView()
        iv.backgroundColor = UIColor.white
        return iv
    }()
    
    
    
    
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
        delegate?.didChangeToGridView()
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
        delegate?.didChangeToListView()
    }
    
    
    
    let ContactNumberLabel: UILabel = {
        let label = UILabel()
        label.text = "Contact Number"
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.backgroundColor = UIColor.white
        return label
    }()
    
    
    lazy var displayNameButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Username & Subtitle ", for: .normal)
        button.tintColor = UIColor.black
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        button.addTarget(self, action: #selector(changeDisplayName), for: .touchUpInside)
        return button
    }()
    
    
    func changeDisplayName(){
        delegate?.changeDisplayName()
    }
    
    
    
    lazy var subtitleButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Username & Subtitle ", for: .normal)
        button.tintColor = UIColor.lightGray
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 12)
        button.addTarget(self, action: #selector(changeSubtitle), for: .touchUpInside)
        return button
    }()
    
    
    func changeSubtitle(){
        delegate?.changeSubtitle()
    }
    
 
   
 
    
    
    let separatorLine: UIView = {
    let tsl = UIView()
        tsl.backgroundColor = UIColor.lightGray
        
        return tsl
    }()
    
  
    
    //Phone Privacy
    
    //Who can View my number
    
    //All Users Except Blocked Users
    
    //Only Authorised Users
    
    
    
    
    
    //Message Privacy
    //Who can message me
    
   //All Users Except Blocked Users
    
    //Only Authorised Users
    
    
    
    
    lazy var BlockedUsersButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = UIColor.black
        button.setTitle("Blocked Users", for: .normal)
        button.setTitleColor(UIColor.white, for: .normal)
        button.addTarget(self, action: #selector(presentBlockedUsersController), for: .touchUpInside)
        button.layer.cornerRadius = 3
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        
        return button
    }()
    
    
    func presentBlockedUsersController(){
      delegate?.presentBlockedUsersController()
    }
    
    
    
    lazy var FriendRequestButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = UIColor.black
        button.setTitle("Friend Request Privacy", for: .normal)
           button.setTitleColor(UIColor.white, for: .normal)
        button.addTarget(self, action: #selector(k), for: .touchUpInside)
        button.layer.cornerRadius = 3
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        
        return button
    }()
    
    
    lazy var MessagePrivacyButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = UIColor.black
        button.setTitle("Message Privacy", for: .normal)
          button.setTitleColor(UIColor.white, for: .normal)
        button.addTarget(self, action: #selector(k), for: .touchUpInside)
        button.layer.cornerRadius = 3
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        
        return button
    }()
    
    func k(){
        
    }
    
    
    
   
//    func saveDetails() {
//        
//        let db = Firestore.firestore()
//        
//        guard let uid = Auth.auth().currentUser?.uid else { return }
//        
//        guard let displayName = self.displayNameTextField.text else { return }
//        
//        guard let subtitle = self.subtitleTextField.text else { return }
//        
//        guard let number = self.contactNumberTextField.text else {
//            return
//        }
//        
//        let values = ["Display Name": displayName, "Subtitle": subtitle,"Contact Number": number]
//        
//        
//        
//        db.collection("Users").document(uid).setData(values, options: SetOptions.merge())
//        
//        
//        
//        
//        
//        
//        self.DisplayNameLabel.text = displayName
//        
//        self.SubtitleStatusLabel.text = subtitle
//    
//    
//        
//        print("details saved")
//        
//    }


    
    
    
    
        
    let editLabel: UILabel = {
        let tf = UILabel()
        tf.text = "Click To Edit"
        tf.font = UIFont.boldSystemFont(ofSize: 16)
        tf.textColor = UIColor.black
        tf.backgroundColor = UIColor.white
        
        return tf
    }()
    
    
    lazy var contactNumberButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Ph: 991", for: .normal)
        button.tintColor = UIColor.black
        
        button.addTarget(self, action: #selector(changeNumber), for: .touchUpInside)
        return button
    }()
    
    
    func changeNumber(){
        delegate?.changeNumber()
    }
    
    
    
    lazy var tagWordsButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Tag Words?", for: .normal)
        button.tintColor = UIColor.black
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 12)
        button.addTarget(self, action: #selector(presentTagWordsController), for: .touchUpInside)
        return button
    }()
    
    
    func presentTagWordsController(){
        delegate?.presentTagWordsController()
    }
    
    
   
    lazy var servicesButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Services?", for: .normal)
        button.tintColor = UIColor.black
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 12)
        button.addTarget(self, action: #selector(presentEditServicesController), for: .touchUpInside)
        return button
    }()
    

    
    func presentEditServicesController(){
        
        delegate?.presentEditServicesController()
        
    }
    
    
    
    let subtitleLabel: UILabel = {
        let tf = UILabel()
        tf.text = "Subtitle"
        tf.font = UIFont.boldSystemFont(ofSize: 20)
        tf.textColor = UIColor.lightGray
        tf.backgroundColor = UIColor.white
        
        return tf
    }()
    
    
    let topAccountTypeImageView: CustomImageView = {
        let iv = CustomImageView()
        iv.backgroundColor = UIColor.white
        return iv
    }()
    
    
    let AccountTypeImageView: CustomImageView = {
        let iv = CustomImageView()
        iv.backgroundColor = UIColor.white
             iv.layer.cornerRadius = 6
        iv.clipsToBounds = true
        iv.translatesAutoresizingMaskIntoConstraints = true
        return iv
    }()
    
    

    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        
        addSubview(editLabel)
       addSubview(profileImageView)
        addSubview(topAccountTypeImageView)
        addSubview(displayNameButton)
        addSubview(subtitleButton)
        addSubview(separatorLine)
        addSubview(contactNumberButton)
        addSubview(servicesButton)
        addSubview(tagWordsButton)
        addSubview(BlockedUsersButton)
        addSubview(FriendRequestButton)
        addSubview(MessagePrivacyButton)

        
        editLabel.anchor(top: topAnchor, left: nil, bottom: nil, right: nil, paddingTop: 20, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        
        editLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        
        
        
        profileImageView.anchor(top: editLabel.bottomAnchor, left: nil, bottom: nil, right: nil, paddingTop: 20, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 80, height: 80)
        profileImageView.layer.cornerRadius = 80 / 2
        profileImageView.clipsToBounds = true
        
        profileImageView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        
        
              topAccountTypeImageView.anchor(top: nil, left: nil, bottom: profileImageView.bottomAnchor, right: profileImageView.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 20, height: 20)
        
        
        
        topAccountTypeImageView.layer.cornerRadius = 10
        topAccountTypeImageView.clipsToBounds = true
        
        
        displayNameButton.anchor(top: profileImageView.bottomAnchor, left: nil, bottom: nil, right: nil, paddingTop: 5, paddingLeft: 8, paddingBottom: 0, paddingRight: 4, width: 0, height: 28)
        
        displayNameButton.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        
        subtitleButton.anchor(top: displayNameButton.bottomAnchor, left: nil, bottom: nil, right: nil, paddingTop: -4, paddingLeft: 9, paddingBottom: 0, paddingRight: 4, width: 0, height: 25)
        
        subtitleButton.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        
        
        contactNumberButton.anchor(top: subtitleButton.bottomAnchor, left: nil, bottom: nil, right: nil, paddingTop: 5, paddingLeft: 8, paddingBottom: 0, paddingRight: 4, width: 0, height: 28)
        
        
        contactNumberButton.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        
        servicesButton.anchor(top: contactNumberButton.bottomAnchor, left: nil, bottom: nil, right: nil, paddingTop: 5, paddingLeft: 8, paddingBottom: 0, paddingRight: 4, width: 0, height: 15)
        
        
        servicesButton.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        
        
        tagWordsButton.anchor(top: servicesButton.bottomAnchor, left: nil, bottom: nil, right: nil, paddingTop: 5, paddingLeft: 8, paddingBottom: 0, paddingRight: 4, width: 0, height: 15)
        
        
        tagWordsButton.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        
        
        
        separatorLine.anchor(top: tagWordsButton.bottomAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, paddingTop: 20, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0.5)
     
        BlockedUsersButton.anchor(top: separatorLine.bottomAnchor, left: nil, bottom: nil, right: nil, paddingTop: 30, paddingLeft: 8, paddingBottom: 0, paddingRight: 0, width: 200, height: 30)
        
        
        BlockedUsersButton.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        
        FriendRequestButton.anchor(top: BlockedUsersButton.bottomAnchor, left: nil, bottom: nil, right: nil, paddingTop: 20, paddingLeft: 8, paddingBottom: 0, paddingRight: 0, width: 200, height: 30)
        
        
        FriendRequestButton.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        
        MessagePrivacyButton.anchor(top: FriendRequestButton.bottomAnchor, left: nil, bottom: nil, right: nil, paddingTop: 20, paddingLeft: 8, paddingBottom: 0, paddingRight: 0, width: 200, height: 30)
        
        
        MessagePrivacyButton.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        
       
        
      // Blocked Users
        
        
        
        
        
        
      // Contact Privacy
        
        
        //Phone
        
          //All User Except For expressely blocked Users from number and blocked users // can be ticked or not ticked
        //All Users is the Default for busines accounts
        
          //Users With Authority
        //collection("Users Allowed For Number")
        //user i348u324g084ybgy24
        //user 031535345345314531
        //fetch users
        
        //expressely blocked Users from number
        
        
        
        //Messages
        //All User Except For expressely blocked Users from messages and blocked users // can be ticked or not ticked
        //All Users is the Default for busines accounts
        
        //Users With Authority
        //collection("Users Allowed For Number")
        //user i348u324g084ybgy24
        //user 031535345345314531
        //fetch users
        
        //expressely blocked Users from messages
        
        
        
        
        
    }
    
    
    
    
    
    fileprivate func setupBottomToolbar() {
        
        let topDividerView = UIView()
        topDividerView.backgroundColor = UIColor.lightGray
        
        let bottomDividerView = UIView()
        bottomDividerView.backgroundColor = UIColor.lightGray
        
        let stackView = UIStackView(arrangedSubviews: [gridButton, listButton])
        
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        
        addSubview(stackView)
        addSubview(topDividerView)
        addSubview(bottomDividerView)
        
        stackView.backgroundColor = UIColor.green
        
        stackView.anchor(top: nil, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0.5, paddingRight: 0, width: 0, height: 50)
        
        topDividerView.anchor(top: stackView.topAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0.5)
        
        bottomDividerView.anchor(top: stackView.bottomAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0.5)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}









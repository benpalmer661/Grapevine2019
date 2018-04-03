//
//  PRP5AgePicker.swift
//  Grapevine2018
//
//  Created by Ben Palmer on 1/1/18.
//  Copyright © 2018 Ben Palmer. All rights reserved.
//



import UIKit

import UIKit
import Firebase
import FirebaseDatabase
import FirebaseAuth
import FirebaseCore
import FirebaseStorage
import FirebaseInstanceID

class PRP5AgePicker: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {
    
    
    
    // @IBOutlet var AgePicker: UIPickerView!
    
    let pickerView: UIPickerView = {
        let v = UIPickerView()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.backgroundColor = .white
        v.delegate = self as? UIPickerViewDelegate
        
        return v
    }()
    
    
    var AgePickerViewArray = [ "","13","14","15","16","17","18","19","20","21","22","23","24","25","26","27","28","29","30","31","32","33","34","35","36","37","38","39","40","41","42","43","44","45","46","47","48","49","50","51","52","53","54","55","56","57","58","59","60","61","62","63","64","65","66","67","68","69","70","71","72","73","74","75","76","77","78","79","80","81","82","83","84","85","86","","87","88","89","90","91","92","93","94","95","96","97","98","99","100"]
    
    var selectedAge: String? = nil
    
 
    var ref: DatabaseReference!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        self.hideKeyboardWhenTappedAround()
        
        UIApplication.shared.statusBarView?.backgroundColor = .white
        

        
        
        pickerView.delegate = self
        pickerView.dataSource = self
        
        ref = Database.database().reference()
        
        setupViews()
        
        
    }//view did load
    
    
    
    
    
    func setupViews(){
        
        
        
        // add the scroll view to self.view
        self.view.addSubview(scrollView)
        scrollView.addSubview(containerView)
        containerView.addSubview(PersonsIconImageView)
        containerView.addSubview(PersonsAccountLabel)
        containerView.addSubview(pickerView)
        
        containerView.addSubview(nextButton)
        containerView.addSubview(backButton)
        
        
        scrollView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 0).isActive = true
        scrollView.topAnchor.constraint(equalTo: view.topAnchor, constant: 0).isActive = true
        scrollView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 0).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0).isActive = true
        
        
        containerView.anchor(top: scrollView.topAnchor, left: nil, bottom: scrollView.bottomAnchor, right: nil, paddingTop: 0, paddingLeft: 0, paddingBottom: -90, paddingRight: 0, width: view.frame.width, height: 600)
        
        containerView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor).isActive = true
        
        
        PersonsIconImageView.anchor(top: containerView.topAnchor, left: nil, bottom: nil, right: nil, paddingTop: 60, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 48, height: 48)
        
        PersonsIconImageView.centerXAnchor.constraint(equalTo: containerView.centerXAnchor).isActive = true
        
        
        PersonsAccountLabel.anchor(top: PersonsIconImageView.bottomAnchor, left: nil, bottom: nil, right: nil, paddingTop: 20, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 150, height: 30)
        
        PersonsAccountLabel.centerXAnchor.constraint(equalTo: containerView.centerXAnchor).isActive = true
        
        
        
        
        pickerView.anchor(top: PersonsAccountLabel.bottomAnchor, left: nil, bottom: nil, right: nil, paddingTop: 20, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: view.frame.width, height: 200)
        
        pickerView.centerXAnchor.constraint(equalTo: containerView.centerXAnchor).isActive = true
        
        
        
        nextButton.anchor(top: pickerView.bottomAnchor, left: nil, bottom: nil, right: nil, paddingTop: 40, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 130, height: 25)
        
        nextButton.centerXAnchor.constraint(equalTo: containerView.centerXAnchor).isActive = true
        
        backButton.anchor(top: nextButton.bottomAnchor, left: nil, bottom: nil, right: nil, paddingTop: 10, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 130, height: 25)
        
        backButton.centerXAnchor.constraint(equalTo: containerView.centerXAnchor).isActive = true
        
        
        
        
        
        
        
    }

    
    
    
    
    
    
    
    
    
    
    ////portrait mode only code
    
    
    
    open override var supportedInterfaceOrientations: UIInterfaceOrientationMask{
        get {
            return .portrait
        }
    }
    
    
    
    open override var shouldAutorotate: Bool {
        get {
            return false
        }
    }
    
    
    
    open override var preferredInterfaceOrientationForPresentation: UIInterfaceOrientation{
        get {
            return .portrait
        }
    }
    
    // end of portrait mode only code
    
    
    
    
    
    
    
    
    
    
    
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView == pickerView{ return AgePickerViewArray[row]
        } else {
            return ""
            
        }
    }
    
    
    
    
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView == pickerView{
            return AgePickerViewArray.count
        } else {
            return 1
        }
        
    }
    
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
        
    }
    
    
    
    
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        guard row < AgePickerViewArray.count else {
            return
        }
        
        let db = Firestore.firestore()
        
        guard let uid = Auth.auth().currentUser?.uid else { return }
        
        selectedAge = AgePickerViewArray[row].lowercased()
        
        
        
        let selectedAgeInteger = Int(selectedAge!)
        
        
        db.collection("Users").document(uid).setData([ "Age" : selectedAgeInteger!], options: SetOptions.merge())
        
        
    }
    
    
    
 
    
    
    
    
    
    
    
    
    
    
    
    private func alertTheUser(title: String , message: String) {
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let ok = UIAlertAction(title: "OK", style: .default, handler: nil);
        alert.addAction(ok);
        present(alert, animated: true, completion: nil);
    }
    
    
    
    
    
    
    
    
    
    
    let PersonsIconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = UIColor.white
        imageView.translatesAutoresizingMaskIntoConstraints = false
        //imageView.layer.cornerRadius = 24
        imageView.layer.masksToBounds = true
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(named: "P icon-72x72")
        
        return imageView
        
    }()
    
    
    let PersonsAccountLabel: UILabel = {
        let label = UILabel()
        label.text = "Person's Account"
        label.backgroundColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        return label
    }()
    
    
    
    
    let CellExampleImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = UIColor.white
        imageView.translatesAutoresizingMaskIntoConstraints = false
        //imageView.layer.cornerRadius = 24
        imageView.layer.masksToBounds = true
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(named: "Main Page Cell Personal")
        
        
        
        return imageView
        
    }()
    
    
    
    
    
    
    let containerView: UIView = {
        let v = UIView()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.backgroundColor = .white
        return v
    }()
    
    
    
    
    
    let scrollView: UIScrollView = {
        let v = UIScrollView()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.backgroundColor = .white
        return v
    }()
    
    
    
    
    
    lazy var nextButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = UIColor.black
        button.setTitle("Next", for: .normal)
        button.setTitleColor(UIColor.white, for: .normal)
        button.addTarget(self, action: #selector(nextButtonPressed), for: .touchUpInside)
        button.layer.cornerRadius = 3
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        
        return button
    }()
    
    
    
    
    
    
    
    func nextButtonPressed(){
        
        
        if selectedAge != "" && selectedAge != nil {
            
            
            if Auth.auth().currentUser != nil  {
                
                
                
                
                let prp6 = PRP6ImageUpload()
                //let navController = UINavigationController(rootViewController: prp6)
                self.present(prp6, animated: true, completion: nil)
                
            }// END OF - if FIRAuth.auth()?.currentUser != nil
            
        } else { alertTheUser(title: "Age not selected", message: "please select an age")
            
        }
        
    }
    
    
    
    
    
    lazy var backButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = UIColor.black
        button.setTitle("Back", for: .normal)
        button.setTitleColor(UIColor.white, for: .normal)
        button.addTarget(self, action: #selector(backButtonPressed), for: .touchUpInside)
        button.layer.cornerRadius = 3
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        
        return button
    }()
    
    
    
    
    func backButtonPressed(){
        
        let prp4 = PRP4GenderPicker()
        //let navController = UINavigationController(rootViewController: prp4)
        self.present(prp4, animated: true, completion: nil)
    }
    
    
    
    
    
}//class











//
//  LocationController.swift
//  Grapevine 2017
//
//  Created by Ben Palmer on 1/10/17.
//  Copyright © 2017 Ben Palmer. All rights reserved.
//

import Foundation
import UIKit
import CoreLocation
import MapKit
import Firebase
//import GeoFire

class LocationController: UIViewController, CLLocationManagerDelegate,UISearchBarDelegate, MKLocalSearchCompleterDelegate {
   
    
    
    
    let defaults = UserDefaults.standard
    
    
    let newPin = MKPointAnnotation()
    
    var home_page_cell = HomePageCell()
   
   var user : User2?
    
    let manager = CLLocationManager()
    

    
    var ActualLocation: CLLocation! {
        didSet{
            
            //location is set in the location manager func which is which is updated via the gps.
            guard let latDouble = Double(ActualLocation.coordinate.latitude.description),
            let longDouble = Double(ActualLocation.coordinate.longitude.description)
                else { return }
            

            //setting a variable of CLLocation
            let Current_Users_Location = CLLocation(latitude:latDouble, longitude: longDouble)
            
            
            CLGeocoder().reverseGeocodeLocation(Current_Users_Location, completionHandler: { (placemark, err) in
                
                if err != nil {
                    
                    self.actualLocationLabel.text = ""
                    
                    
                    print("there was an error in reverse geocode")
                } else {
                    
                    guard let place = placemark?[0] else { return }

                    guard let st = place.subThoroughfare, let t = place.thoroughfare, let l = place.locality
                    else { return }
                    
                    
                    
                    
                    
                    
                    
                    
            
                        
                    
                    self.actualLocationLabel.text =
                        ("    Actual Location: \(st) \(t) \(l)")
                }
            })
        }
    }
    
   
    
    
    func searchingFromLocationLabelToSearchCity(){
        
        guard let closestCityToSearchingFromLocation = self.defaults.string(forKey: "searchLocation") else { return }
        
        self.SearchingFromLocationLabel.text = "    Search Location: \(closestCityToSearchingFromLocation)"
        
    }
    
    
    
   
    
    func setSearchCityAsClosestCityToWhereUserDropsPinOnMapForWhenSettingSearchFromLocation(){
        
        // SearchingFromLatitude and SearchingFromLongitude are set in the function SaveSearchingFromLocation
        
        
        guard let latitude = self.defaults.string(forKey: "SearchingFromLatitude")
            else {
                self.alertTheUser(title: "error setting Searching From Latitude ", message: "")
                return }
        
        guard  let longitude = self.defaults.string(forKey: "SearchingFromLongitude") else {
            self.alertTheUser(title: "error setting SearchingFromLongitude ", message: "")
            return }
        
        guard let doubleLatitude = Double(latitude) else { return }
        guard let doubleLongitude = Double(longitude) else { return }
        
        let searchingFromLocation = CLLocation(latitude: (doubleLatitude), longitude: Double(doubleLongitude))
        
        
        
        
        let citiesArray = ["Adelaide": CLLocation(latitude: -34.9286600, longitude: 138.5986300),"Albury": CLLocation(latitude: -36.0737, longitude: 146.9135),"Alice Springs": CLLocation(latitude: -23.6980, longitude: 133.8807),"Armadale": CLLocation(latitude: -32.1530, longitude: 116.0150),"Ballarat": CLLocation(latitude: -37.5622, longitude: 143.8503),"Brisbane": CLLocation(latitude: -27.470125, longitude: 153.021072),"Bunbury": CLLocation(latitude: -33.3256, longitude: 115.6396),
                           "Busselton": CLLocation(latitude: -33.6555, longitude: 115.3500),"Darwin":CLLocation(latitude: -12.462827, longitude: 130.841782),"Geelong": CLLocation(latitude: -38.1499, longitude: 144.3617),"Gold Coast": CLLocation(latitude: -28.0167, longitude: 153.4000),"Gosford": CLLocation(latitude: -33.4267, longitude: 151.3417),
                           "Hobart":CLLocation(latitude: -42.837284, longitude: 147.505005),
                           "Joondalup":CLLocation(latitude: -32.5361, longitude: 115.7424),"Katherine": CLLocation(latitude: -14.4521, longitude: 132.2715),"Launceston": CLLocation(latitude: -41.4332, longitude: 147.1441),"Mandurah": CLLocation(latitude: -32.5361, longitude: 115.7424),"Margaret River": CLLocation(latitude: -33.9536, longitude: 115.07391),
                           "Melbourne": CLLocation(latitude: -37.81425, longitude: 144.963169),"Newcastle": CLLocation(latitude: -32.9283, longitude: 151.7817),"Perth": CLLocation(latitude: -31.953512, longitude: 115.857048),"Port Augusta": CLLocation(latitude: -32.4952, longitude: 137.7894),"Port Pirie": CLLocation(latitude: -33.1708, longitude: 138.0089),"Rockingham": CLLocation(latitude: -32.2810, longitude: 115.7270),"Sunshine Coast": CLLocation(latitude: -26.6500, longitude: 153.0667),
                           "Sydney": CLLocation(latitude: -33.865143, longitude: 151.209900),"Wagga Wagga": CLLocation(latitude: -35.1082, longitude: 147.3598)]
        
        
        let cities = citiesArray.sorted { $0.value.distance(from: searchingFromLocation) < $1.value.distance(from: searchingFromLocation) }
        
        
        guard let closestCity = cities.first else {  return }
    
        
        
        print("dddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd",closestCity.value)
        
        
        defaults.set(closestCity.key, forKey: "searchLocation")
        
        

        searchingFromLocationLabelToSearchCity()
        
        
        
    }
    
    
    
    
    
    
    
    
    
    
    

    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar)
    {
        showSearchingFromLocationInUse = true
    
        print("search bar button clicked")
    
        //Ignoring user
        UIApplication.shared.beginIgnoringInteractionEvents()
        
        //Activity Indicator
        let activityIndicator = UIActivityIndicatorView()
        activityIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.gray
        activityIndicator.center = self.view.center
        activityIndicator.hidesWhenStopped = true
        activityIndicator.startAnimating()
        
        self.view.addSubview(activityIndicator)
        
        //Hide search bar
        searchBar.resignFirstResponder()
        dismiss(animated: true, completion: nil)
        
        //Create the search request
        let searchRequest = MKLocalSearchRequest()
        searchRequest.naturalLanguageQuery = searchBar.text
        
        let activeSearch = MKLocalSearch(request: searchRequest)
        
        activeSearch.start { (response, error) in
            
            activityIndicator.stopAnimating()
            UIApplication.shared.endIgnoringInteractionEvents()
            
            if response == nil
            {
                print("ERROR")
            }
            else
            {
                
                
                //Remove annotations
                let annotations = self.map.annotations
                self.map.removeAnnotations(annotations)
                
                
                //Getting data
                guard let latitude = response?.boundingRegion.center.latitude else { return }
                
                guard let longitude = response?.boundingRegion.center.longitude else { return }
                
                
                print("lat and long both set to equal respones")
                
                
                let stringLongitude = longitude.description
                
                let stringLatitude = latitude.description
                
                
                self.searchLongitude = stringLongitude
                self.searchLatitude = stringLatitude
                
                
                //Create annotation
                let annotation = MKPointAnnotation()
                annotation.title = searchBar.text
                annotation.coordinate = CLLocationCoordinate2DMake(latitude, longitude)
                self.map.addAnnotation(annotation)
                
                
                //Zooming in on annotation
                let coordinate:CLLocationCoordinate2D = CLLocationCoordinate2DMake(latitude, longitude)
                let span = MKCoordinateSpanMake(0.1, 0.1)
                let region = MKCoordinateRegionMake(coordinate, span)
                self.map.setRegion(region, animated: true)
                
                
                
                //set up auto complete
                let searchCompleter = MKLocalSearchCompleter()
                searchCompleter.delegate = self
                ///var searchResults = [MKLocalSearchCompletion]()
                
                searchCompleter.queryFragment = searchBar.text!
                
                
            }
        }
    }
    

    
    var searchLatitude: String?
    var searchLongitude: String?
    

    
    
    func SaveSearchingFromLocation(){
        
        
       let lat =  String(self.map.centerCoordinate.latitude)
        
       let long =  String(self.map.centerCoordinate.longitude)
        
        
        defaults.set(lat, forKey: "SearchingFromLatitude")
        
        defaults.set(long, forKey: "SearchingFromLongitude")
        
        
            
            //self.SetSearchingFromLocationLabelFromUserDefaults()
            
            self.showSearchingFromLocationOnMap()
            
            self.setSearchCityAsClosestCityToWhereUserDropsPinOnMapForWhenSettingSearchFromLocation()
        
    }

    
    
    
    
    
//updates the users Actual location and show's it on the screen
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation])
    {
        
        if showSearchingFromLocationInUse == false {
        
         //map.removeAnnotation(newPin)
        let location = locations[0]
    
        let span:MKCoordinateSpan = MKCoordinateSpanMake(0.5, 0.5)
        let myLocation:CLLocationCoordinate2D = CLLocationCoordinate2DMake(location.coordinate.latitude, location.coordinate.longitude)
            
        let region:MKCoordinateRegion = MKCoordinateRegionMake(myLocation, span)
        map.setRegion(region, animated: true)
        
        
        self.map.showsUserLocation = true
        
        self.ActualLocation = location
        
        
        newPin.coordinate = location.coordinate
        map.addAnnotation(newPin)

        }
        
    }
    
    
    
    
var showSearchingFromLocationInUse = false

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        guard let closestCityToSearchingFromLocation = self.defaults.string(forKey: "searchLocation") else { return }
        
        self.SearchingFromLocationLabel.text = "    Searching:  \(closestCityToSearchingFromLocation)"
        
        
        showSearchingFromLocationInUse = false
        
        //SetSearchingFromLocationLabelFromUserDefaults()
        
        self.edgesForExtendedLayout = []
        
        self.navigationItem.title = "Tap Icon To Search"
        
        self.navigationController?.navigationBar.topItem?.title = ""
        
        manager.delegate = self
        manager.desiredAccuracy = kCLLocationAccuracyBest
        manager.requestWhenInUseAuthorization()
        manager.startUpdatingLocation()
        
        view.backgroundColor = UIColor.red
        
        map.showsUserLocation = true
        
                navigationItem.rightBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "search_selected"), style: .plain, target: self, action: #selector(searchFunc))
        
        setUpMapView()
        
       
  
       }
    
 
    
  
    
    
    func searchFunc(){
    
    let searchController = UISearchController(searchResultsController: nil)
    searchController.searchBar.delegate = self
    present(searchController, animated: true, completion: nil)
        
    }
    
    
    
    func dropPinZoomIn(placemark: MKPlacemark){   // This function will "poste" the dialogue bubble of the pin.
        var selectedPin: MKPlacemark?
        
        // cache the pin
        selectedPin = placemark    // MKPlacemark() give the details like location to the dialogue bubble. Place mark is initialize in the function getLocationAddress (location: ) who call this function.
        
        // clear existing pins to work with only one dialogue bubble.
        map.removeAnnotations(map.annotations)
        let annotation = MKPointAnnotation()    // The dialogue bubble object.
        annotation.coordinate = placemark.coordinate
        annotation.title = placemark.name// Here you should test to understand where the location appear in the dialogue bubble.
        
        if let city = placemark.locality,
            let state = placemark.administrativeArea {
            annotation.subtitle = String((city))+String((state));
        } // To "post" the user's location in the bubble.
        
        map.addAnnotation(annotation)     // To initialize the bubble.
        let span = MKCoordinateSpanMake(0.05, 0.05)
        let region = MKCoordinateRegionMake(placemark.coordinate, span)
        map.setRegion(region, animated: true)   // To update the map with a center and a size.
        
    }
    
    
    
    





private func alertTheUser(title: String , message: String) {
    
    let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
    
    let ok = UIAlertAction(title: "OK", style: .default, handler: nil);
    alert.addAction(ok);
    present(alert, animated: true, completion: nil);
}














    var map: MKMapView = {
        let m = MKMapView()
        m.backgroundColor = UIColor.white
        return m
    }()
    
    
    let actualLocationLabel: UILabel = {
        let v = UILabel()
        v.backgroundColor = UIColor.black
        v.text = ""
        v.textColor = UIColor.white
        v.font = v.font.withSize(10)
        return v
    }()
    
    
    
    let SearchingFromLocationLabel: UILabel = {
        let v = UILabel()
        v.backgroundColor = UIColor.black
        v.text = "  Searching From Location:"
        v.textColor = UIColor.white
        v.font = v.font.withSize(10)
        return v
    }()
    
    
    
    
    
    lazy var setSearchingFromLocationButton: UIButton = {
        let b = UIButton(type: .system)
        b.setTitle("Set Searching From Location", for: .normal)
        b.setTitleColor(UIColor.black, for: .normal)
        b.titleLabel?.font = UIFont.boldSystemFont(ofSize: 8)
        b.backgroundColor = UIColor.white
        b.addTarget(self, action: #selector(self.SaveSearchingFromLocation), for: .touchUpInside)
        //button.layer.borderColor = UIColor.black.cgColor
        b.layer.borderColor = UIColor.black.cgColor
        return b
    }()
    
    
    
    lazy var showActualLocationButton: UIButton = {
        let b = UIButton(type: .system)
        b.setTitle("Show Actual Location", for: .normal)
        b.setTitleColor(UIColor.black, for: .normal)
        b.titleLabel?.font = UIFont.boldSystemFont(ofSize: 8)
        b.backgroundColor = UIColor.white
        b.addTarget(self, action: #selector(self.ShowActualLocationOnMap), for: .touchUpInside)
        //button.layer.borderColor = UIColor.black.cgColor
        b.layer.borderColor = UIColor.black.cgColor
        return b
    }()
    
    
    
    func ShowActualLocationOnMap(){
        
        print("Showing Actual Location")
        
        self.showSearchingFromLocationInUse = false
    }
    
    
    
    lazy var showSearchingFromLocationButton: UIButton = {
        let b = UIButton(type: .system)
        b.titleLabel?.font = UIFont.boldSystemFont(ofSize: 8)
        
        
        b.setTitle("Show Searching From Location", for: .normal)
        b.setTitleColor(UIColor.black, for: .normal)
        b.layer.borderColor = UIColor.black.cgColor
        b.backgroundColor = UIColor.white
        b.addTarget(self, action: #selector(self.showSearchingFromLocationOnMap), for: .touchUpInside)
        return b
    }()
    
    
    
    
    
    func showSearchingFromLocationOnMap(){
      
        
       self.showSearchingFromLocationInUse = true
        
        
        
        guard let latitude = self.defaults.string(forKey: "SearchingFromLatitude")
            else { return }
        
        guard  let longitude = self.defaults.string(forKey: "SearchingFromLongitude") else {
            return }
        
        
        guard let doubleLatitude = Double(latitude) else { return }
        guard let doubleLongitude = Double(longitude) else { return }
        
            
            
            //Remove annotations
            let annotations = self.map.annotations
            self.map.removeAnnotations(annotations)
            
            
            //Create annotation
            let annotation = MKPointAnnotation()
            annotation.coordinate = CLLocationCoordinate2DMake(doubleLatitude, doubleLongitude)
            self.map.addAnnotation(annotation)
            

   
        //Zooming in on searching from coordinate
        let coordinate:CLLocationCoordinate2D = CLLocationCoordinate2DMake(doubleLatitude, doubleLongitude)
        let span = MKCoordinateSpanMake(0.1, 0.1)
        let region = MKCoordinateRegionMake(coordinate, span)
        self.map.setRegion(region, animated: true)
        
     
        
        
    }
    
    
    
    
    func setUpMapView(){
        
        view.addSubview(setSearchingFromLocationButton)
        view.addSubview(map)
        view.addSubview(SearchingFromLocationLabel)
        view.addSubview(actualLocationLabel)
        view.addSubview(showSearchingFromLocationButton)
        view.addSubview(showActualLocationButton)
        
        
      map.anchor(top: view.topAnchor, left: view.leftAnchor, bottom: setSearchingFromLocationButton.topAnchor, right: view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        
        
        
        showSearchingFromLocationButton.anchor(top: nil, left: nil, bottom: SearchingFromLocationLabel.topAnchor, right: view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: view.frame.width/2, height: 30)
        
        
        showActualLocationButton.anchor(top: nil, left: view.leftAnchor, bottom: SearchingFromLocationLabel.topAnchor, right: nil, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: view.frame.width/2, height: 30)
        
        
        SearchingFromLocationLabel.anchor(top: nil, left: view.leftAnchor, bottom: actualLocationLabel.topAnchor, right: view.rightAnchor, paddingTop: 0, paddingLeft: 00, paddingBottom: 0, paddingRight: 0, width: view.frame.width, height: 30)
        
        actualLocationLabel.anchor(top: nil, left: view.leftAnchor, bottom: setSearchingFromLocationButton.topAnchor, right: view.rightAnchor, paddingTop: 0, paddingLeft: 00, paddingBottom: 0, paddingRight: 0, width: view.frame.width, height: 30)
        
        setSearchingFromLocationButton.anchor(top: nil, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, paddingTop: 0, paddingLeft: 00, paddingBottom: 0, paddingRight: 0, width: view.frame.width, height: 30)
        
        
    }
    
    
    
    
    
}


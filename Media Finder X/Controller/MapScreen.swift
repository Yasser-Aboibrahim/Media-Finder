//
//  MapScreen.swift
//  Media Finder X
//
//  Created by yasser on 8/6/20.
//  Copyright © 2020 Yasser Aboibrahim. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

//Delegation Desgin Pattern
//1-set protocol
protocol AddressSendingDelegate: class{
    func sendAdress (_ address: String)
}

class MapScreen: UIViewController {
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var addressLable: UILabel!
    
    // MARK:- Properties
    //2-set delegate
    weak var delegate: AddressSendingDelegate?
    lazy var geoCoder = CLGeocoder()
    
    // MARK:- Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        mapView.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        let mapScreen = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: ViewController.mapScreen) as! MapScreen
        //4-
        mapScreen.delegate = self as? AddressSendingDelegate
    }
    
    // MARK:- Actions
    @IBAction func sendDataButtonPressed(_ sender: Any) {
            dismiss(animated: true, completion: nil)
    }
}

// MARK:- center coordinates extension
extension MapScreen: MKMapViewDelegate{
    func mapView(_ mapView: MKMapView, regionDidChangeAnimated animated: Bool) {
        let center = mapView.centerCoordinate
        getNameOfLocation(lat: center.latitude, long: center.longitude)
    }
}

// MARK:- geoCode location extension
extension MapScreen{
    private func getNameOfLocation(lat: CLLocationDegrees , long: CLLocationDegrees){
    let location = CLLocation(latitude: lat, longitude: long)
        //Geocoder Location
        geoCoder.reverseGeocodeLocation(location) { (placemarks, error) in
            //process responsee
            self.processResponse(withplacemarks: placemarks , error: error)
    }
}
    // MARK:- Public Methods
    private func processResponse(withplacemarks placemarks: [CLPlacemark]? , error: Error?){
        if error != nil{
            addressLable.text = "unable to find address location"
        }else{
            if let placemarks = placemarks, let placemark = placemarks.first {
                addressLable.text = placemark.compactAddress ?? ""
                //3-action
                delegate?.sendAdress(placemark.compactAddress ?? "N/A")
            }else{
                addressLable.text = "No Matching Address"
                delegate?.sendAdress("No Matching Address")
            }
        }
    }
}

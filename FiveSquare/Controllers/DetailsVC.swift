//
//  DetailsVC.swift
//  FiveSquare
//
//  Created by Yasin Cengiz on 8.03.2020.
//  Copyright © 2020 MrYC. All rights reserved.
//

import UIKit
import MapKit
import Parse

class DetailsVC: UIViewController {
    
    @IBOutlet weak var detalsImageView: UIImageView!
    @IBOutlet weak var detailsMapView: MKMapView!
    @IBOutlet weak var detalsNameLabel: UILabel!
    @IBOutlet weak var detailsTypeLabel: UILabel!
    @IBOutlet weak var detailsAtmosphereLabel: UILabel!

    var chosenPlaceID = ""
    var chosenLatitude = Double()
    var chosenLongitude = Double()
    var registerVC = RegisterVC()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getDataFromParse()
        
    }
    


    func getDataFromParse() {
        let query = PFQuery(className: "Places")
        query.whereKey("objectId", equalTo: chosenPlaceID)
        query.findObjectsInBackground { (objects, error) in
            if error != nil {
                self.registerVC.pushAlert(title: "Error", message: error?.localizedDescription ?? "Error")
            } else {
                if objects != nil {
                    let chosenPlaceObject = objects![0]
                    
                    //Objects
                    
                    if let placeName = chosenPlaceObject.object(forKey: "name") as? String {
                        self.detalsNameLabel.text = placeName
                        if let placeType = chosenPlaceObject.object(forKey: "type") as? String {
                            self.detailsTypeLabel.text = placeType
                            if let atmosphere = chosenPlaceObject.object(forKey: "atmosphere") as? String {
                                self.detailsAtmosphereLabel.text = atmosphere
                            }
                        }
                    }
                    if let placeLatitude = chosenPlaceObject.object(forKey: "latitude") as? String {
                        if let placeLatitudeDouble = Double(placeLatitude) {
                            self.chosenLatitude = placeLatitudeDouble
                            if let placeLongitude = chosenPlaceObject.object(forKey: "longitude") as? String {
                                if let placeLongitudeDouble = Double(placeLongitude) {
                                    self.chosenLongitude = placeLongitudeDouble
                                }
                            }
                        }
                    }
                    if let imageData = chosenPlaceObject.object(forKey: "image") as? PFFileObject {
                        imageData.getDataInBackground { (data, error) in
                            if error == nil {
                                if data != nil {
                                    self.detalsImageView.image = UIImage(data: data!)
                                }
                            }
                        }
                    }
                    
                    // Maps
                    let location = CLLocationCoordinate2D(latitude: self.chosenLatitude, longitude: self.chosenLongitude)
                    let span = MKCoordinateSpan(latitudeDelta: 0.035, longitudeDelta: 0.035)
                    let region = MKCoordinateRegion(center: location, span: span)
                    self.detailsMapView.setRegion(region, animated: true)
                    let annotation = MKPointAnnotation()
                    annotation.coordinate = location
                    annotation.title = self.detalsNameLabel.text!
                }
            }
        }
    }
    
    
    
    
    
}

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

class DetailsVC: UIViewController, MKMapViewDelegate {
    
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
        
        detailsMapView.delegate = self
        
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
                    if let placeLatitude = chosenPlaceObject.object(forKey: "latitude") as? Double {
                        self.chosenLatitude = placeLatitude
                        if let placeLongitude = chosenPlaceObject.object(forKey: "longitude") as? Double {
                            self.chosenLongitude = placeLongitude
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
                    let span = MKCoordinateSpan(latitudeDelta: 0.015, longitudeDelta: 0.015)
                    let region = MKCoordinateRegion(center: location, span: span)
                    self.detailsMapView.setRegion(region, animated: true)
                    let annotation = MKPointAnnotation()
                    annotation.coordinate = location
                    annotation.title = self.detalsNameLabel.text!

                }
                

            }

        }
    }
    
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        
        if annotation is MKUserLocation {
            return nil
        }
        
        let reuseId = "pin"
        var pinView = mapView.dequeueReusableAnnotationView(withIdentifier: reuseId)
        
        if pinView == nil {
            pinView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: reuseId)
            pinView?.canShowCallout = true
            let button = UIButton(type: .detailDisclosure)
            pinView?.rightCalloutAccessoryView = button
        } else {
            pinView?.annotation = annotation
        }
        
        return pinView
        
    }
    
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        
        if self.chosenLongitude != 0.0 , self.chosenLatitude != 0.0 {
            let requestLocation = CLLocation(latitude: self.chosenLatitude, longitude: self.chosenLongitude)
            CLGeocoder().reverseGeocodeLocation(requestLocation) { (placemarks, error) in
                if let placemark = placemarks {
                    if placemark.count > 0 {
                        let mkPlaceMark = MKPlacemark(placemark: placemark[0])
                        let mapItem = MKMapItem(placemark: mkPlaceMark)
                        mapItem.name = self.detalsNameLabel.text
                        let launchOptions = [MKLaunchOptionsDirectionsModeKey : MKLaunchOptionsDirectionsModeDriving]
                        mapItem.openInMaps(launchOptions: launchOptions)
                    }
                }
            }
        }
        
    }
    
}

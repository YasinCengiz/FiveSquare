//
//  MapVC.swift
//  FiveSquare
//
//  Created by Yasin Cengiz on 7.03.2020.
//  Copyright © 2020 MrYC. All rights reserved.
//

import UIKit
import MapKit

class MapVC: UIViewController {

    @IBOutlet weak var mapView: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.topItem?.rightBarButtonItem = UIBarButtonItem(title: "Save", style: .plain, target: self, action: #selector(saveButtonClicked))
        
        print(PlaceModel.sharedInstance.placeName)
        
    }
    
    
    
    @objc func saveButtonClicked() {
        // PARSE
        
    }
    

}

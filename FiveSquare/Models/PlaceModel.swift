//
//  PlaceModel.swift
//  FiveSquare
//
//  Created by Yasin Cengiz on 8.03.2020.
//  Copyright © 2020 MrYC. All rights reserved.
//

import UIKit

class PlaceModel {
    
    static let sharedInstance = PlaceModel()
    
    var placeName = ""
    var placeType = ""
    var placeAtmosphere = ""
    var placeImage = UIImage()
    var placeLongitude = Double()
    var placeLatitude = Double()
    
    private init(){}
    
}



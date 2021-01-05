//
//  ParkAnnotation.swift
//  NationalParkMapOverlay
//
//  Created by Sreekuttan Sudarsanan on 1/4/21.
//

import UIKit
import MapKit

class ParkAnnotation : NSObject, MKAnnotation {
    dynamic var coordinate : CLLocationCoordinate2D
    /* dynamic */ var title: String?
    var subtitle: String?
    
    init(location coord:CLLocationCoordinate2D) {
        self.coordinate = coord
        super.init()
    }

}

//
//  MapView.swift
//  NationalParkMapOverlay
//
//  Created by Sreekuttan Sudarsanan on 12/30/20.
//

import SwiftUI
import MapKit
import CoreLocation

class ParkAnnotation : NSObject, MKAnnotation {
    dynamic var coordinate : CLLocationCoordinate2D
    /* dynamic */ var title: String?
    var subtitle: String?
    var image: UIImage
    
    init(coordinate: CLLocationCoordinate2D, title: String, image: String, subtitle: String) {
        self.coordinate = coordinate
        self.title = title
        self.subtitle = subtitle
        self.image = UIImage(named: image)!
    }

}

class ParkAnnotationView: MKAnnotationView {
}

struct MapView: UIViewRepresentable {
    
    var parkList: [Park] = Park.Parks
    
    static let reuseId = "park"
    
    //Define a class which works as a delegate
    class MyMapViewDelegate: NSObject, MKMapViewDelegate {
        func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
            let annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: MapView.reuseId, for: annotation) as! ParkAnnotationView
            
            if let parkAnnotation = annotation as? ParkAnnotation {

                let imageLayer = CALayer()
                imageLayer.frame = CGRect(x: 0, y: 0, width: 40, height: 40)
                imageLayer.contents = parkAnnotation.image.cgImage
                imageLayer.cornerRadius = imageLayer.frame.size.width / 2
                imageLayer.masksToBounds = true
                imageLayer.borderWidth = 4.0
                imageLayer.borderColor = UIColor.white.cgColor
                annotationView.layer.addSublayer(imageLayer)
                annotationView.frame = imageLayer.frame

            }
            
            annotationView.canShowCallout = true
            
            annotationView.leftCalloutAccessoryView = UIImageView(image: #imageLiteral(resourceName: "apple"))

            return annotationView
        }
    }
    
    //Instantiate the delegate class
    var mapViewDelegate: MKMapViewDelegate = MyMapViewDelegate()
    
    func makeUIView(context: Context) -> MKMapView {
        let mapView = MKMapView(frame: .zero)
        mapView.delegate = mapViewDelegate //<- Set delegate
        mapView.register(ParkAnnotationView.self, forAnnotationViewWithReuseIdentifier: MapView.reuseId)
        addAnnotations(to: mapView)
        return mapView
    }
    
    func updateUIView(_ uiView: MKMapView, context: Context) {
        //No need to add annotations here...
    }
        
    func addAnnotations(to mapView: MKMapView) {
        for park in parkList {
            
            let annotation = ParkAnnotation(coordinate: CLLocationCoordinate2D(latitude: park.latitude, longitude: park.longitude), title: park.name, image: park.img, subtitle: park.state)
            
            mapView.addAnnotation(annotation)
        }
    }
    //...
}

struct MapView_Previews: PreviewProvider {
    static var previews: some View {
        MapView()
    }
}

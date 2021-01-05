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
        self.image = UIImage(imageLiteralResourceName: image)
    }

}

class ParkAnnotationView: MKAnnotationView {
    //No subclassing needed...
}

struct MapView: UIViewRepresentable {
    
    var parkList: [Park] = Park.Parks
    
    static let reuseId = "park"
    
    //Define a class which works as a delegate
    class MyMapViewDelegate: NSObject, MKMapViewDelegate {
        func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
            let annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: reuseId, for: annotation) as! ParkAnnotationView
            if let observationAnnotation = annotation as? ParkAnnotation {
                
                annotationView.image = observationAnnotation.image
            }
            annotationView.canShowCallout = true
            
            print("Here")
            
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


//struct MapView: UIViewRepresentable{
//
//    let locationManager = CLLocationManager()
//
////    var locValue : CLLocationCoordinate2D
//
//    class Coordinator: NSObject, MKMapViewDelegate {
//        var parent:MapView
//
//        init(_ parent: MapView) {
//            self.parent = parent
//        }
//
//        func mapViewDidChangeVisibleRegion(_ mapView: MKMapView) {
//            print(mapView.centerCoordinate)
//        }
//
//        func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
//            let view = MKPinAnnotationView(annotation: annotation, reuseIdentifier: nil)
//            view.canShowCallout = true
//            return view
//        }
//
//    }
//
//    func makeCoordinator() -> Coordinator {
//        Coordinator(self)
//    }
//
//
//    func makeUIView(context: Context) -> MKMapView {
//        let mapView = MKMapView(frame: .zero)
//        mapView.delegate = context.coordinator
//
//        let annotation = ParkAnnotation(location: CLLocationCoordinate2D(latitude: 37.83, longitude: -119.5))
//        annotation.title = "Yosemite"
//        annotation.subtitle = "National Park"
//        mapView.addAnnotation(annotation)
//
//        return mapView
//    }
//
//    func updateUIView(_ view: MKMapView, context: Context){
//            let coordinate = CLLocationCoordinate2D(
//                latitude: 40, longitude: -75)
//            let span = MKCoordinateSpan(latitudeDelta: 10.0, longitudeDelta: 5.0)
//            let region = MKCoordinateRegion(center: coordinate, span: span)
//            view.setRegion(region, animated: true)
//    }
//
//}

struct MapView_Previews: PreviewProvider {
    static var previews: some View {
        MapView()
    }
}

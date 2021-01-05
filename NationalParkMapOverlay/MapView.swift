//
//  MapView.swift
//  NationalParkMapOverlay
//
//  Created by Sreekuttan Sudarsanan on 12/30/20.
//

import SwiftUI
import MapKit
import CoreLocation

struct MapView: UIViewRepresentable{
    
    let locationManager = CLLocationManager()

//    var locValue : CLLocationCoordinate2D
    
    class Coordinator: NSObject, MKMapViewDelegate {
        var parent:MapView
        
        init(_ parent: MapView) {
            self.parent = parent
        }
        
        func mapViewDidChangeVisibleRegion(_ mapView: MKMapView) {
            print(mapView.centerCoordinate)
        }
        
        func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
            let view = MKPinAnnotationView(annotation: annotation, reuseIdentifier: nil)
            view.canShowCallout = true
            return view
        }

    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }


    func makeUIView(context: Context) -> MKMapView {
        let mapView = MKMapView(frame: .zero)
        mapView.delegate = context.coordinator
        
        let annotation = ParkAnnotation(location: CLLocationCoordinate2D(latitude: 37.83, longitude: -119.5))
        annotation.title = "Yosemite"
        annotation.subtitle = "National Park"
        mapView.addAnnotation(annotation)
        
        return mapView
    }
    
    func updateUIView(_ view: MKMapView, context: Context){
            let coordinate = CLLocationCoordinate2D(
                latitude: 40, longitude: -75)
            let span = MKCoordinateSpan(latitudeDelta: 10.0, longitudeDelta: 5.0)
            let region = MKCoordinateRegion(center: coordinate, span: span)
            view.setRegion(region, animated: true)
    }

}

struct MapView_Previews: PreviewProvider {
    static var previews: some View {
        MapView()
    }
}

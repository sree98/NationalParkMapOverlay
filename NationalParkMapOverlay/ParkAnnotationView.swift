////
////  ParkAnnotationView.swift
////  NationalParkMapOverlay
////
////  Created by Sreekuttan Sudarsanan on 1/4/21.
////
//
//import SwiftUI
//import MapKit
//
//struct ParkAnnotationView: MKAnnotationView {
//    let logo : String = ""
//    
//    override var annotation: MKAnnotation? {
//        willSet {
//            self.image = UIImage(named:"clipartdirtbike.gif")
//        }
//    }
//
//    override func didMoveToSuperview() {
//        super.didMoveToSuperview()
//        self.bounds.size.height /= 3.0
//        self.bounds.size.width /= 3.0
//        self.centerOffset = CGPoint(x: 0,y: -20)
//        self.canShowCallout = true
//    }
//
//}
//
////struct ParkAnnotationView_Previews: PreviewProvider {
////    static var previews: some View {
////        ParkAnnotationView()
////    }
////}

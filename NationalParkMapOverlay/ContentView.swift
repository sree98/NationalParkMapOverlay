//
//  ContentView.swift
//  NationalParkMapOverlay
//
//  Created by Sreekuttan Sudarsanan on 12/30/20.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        MapView()
            .edgesIgnoringSafeArea(.all)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

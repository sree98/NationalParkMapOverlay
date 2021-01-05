//
//  Park.swift
//  NationalParkMapOverlay
//
//  Created by Sreekuttan Sudarsanan on 1/4/21.
//

// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let parks = try? newJSONDecoder().decode(Parks.self, from: jsonData)
import Foundation
import SwiftyJSON

struct Park {
    let id: Int
    let img: String
    var name: String
    var state: String
    var latitude: Double
    var longitude: Double

    static var Parks:[Park] {
        var parksArr = [Park]()
        if let path = Bundle.main.path(forResource: "NationalParks", ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .alwaysMapped)
                let jsonObj = try JSON(data: data)
                
                let parks = jsonObj.arrayValue
                var count = 0
                
                for park in parks {
                    let url = park["image"]["url"].stringValue.replacingOccurrences(of: "-", with: "_")
                    let name = park["title"].stringValue
                    let latitude = park["coordinates"]["latitude"].doubleValue
                    let longitude = park["coordinates"]["longitude"].doubleValue
                    var statesStr = ""
                    
                    for state in park["states"].arrayValue {
                        if !statesStr.isEmpty {
                            statesStr += ", "
                        }
                        statesStr.append(state["title"].stringValue)
                    }
                    
                    parksArr += [Park(id: count, img: url, name: name, state: statesStr, latitude: latitude, longitude: longitude)]
                    count += 1
                }
                return parksArr
            } catch let error {
                print("parse error: \(error.localizedDescription)")
            }
        } else {
            print("Invalid filename/path.")
        }
        return []
    }
}

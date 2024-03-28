//
//  Restaurant.swift
//  Akintoye_Final
//
//  Created by Arogs on 3/12/24.
//

import Foundation

struct Restaurant: Codable, Hashable {
    var id : String? = UUID().uuidString
    var restaurant : String = ""
    var latitude : Double = 45.55
    var longitude: Double = 73.33
    
    init(_ restaurant: String, _ latitude: Double,_ longitude: Double) {
        self.restaurant = restaurant
        self.latitude = latitude
        self.longitude = longitude
    }
}

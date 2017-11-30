//
//  Mapas.swift
//  EVA_Transporte_IOS
//
//  Created by MAC 2 on 30/11/17.
//  Copyright © 2017 EVA Transporte. All rights reserved.
//

import Foundation

class Mapas {
    var latitude:Double
    var longitude:Double
    var name:String
    var details: String
    init(latitude:Double,longitude:Double,name:String,details:String) {
        self.latitude = latitude
        self.longitude = longitude
        self.name = name
        self.details = details
    }
}

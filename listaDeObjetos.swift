//
//  listaDeObjetos.swift
//  EVA_Transporte_IOS
//
//  Created by MAC 2 on 19/10/17.
//  Copyright © 2017 EVA Transporte. All rights reserved.
//

import Foundation

public class Lista {
    var nombre: String
    var nombreId: String
    var item = [String]()
    var itemId = [String]()
    var estado: Bool
    init(nombre: String,nombreId:String,item:[String],itemId:[String],estado:Bool) {
        self.nombre = nombre
        self.nombreId = nombreId
        self.item = item
        self.itemId = itemId
        self.estado = estado
    }
    init() {
        nombre = ""
        nombreId = ""
        item = []
        itemId = []
        estado = false
    }
    
}

public class listaDeObjetos {
    var nombre: String
    var nombreId: String
    var item = [String]()
    var itemId = [String]()
    var estado: Bool
    init(nombre: String,nombreId:String,item:[String],itemId:[String],estado:Bool) {
        self.nombre = nombre
        self.nombreId = nombreId
        self.item = item
        self.itemId = itemId
        self.estado = estado
    }
    init() {
        nombre = ""
        nombreId = ""
        item = []
        itemId = []
        estado = false
    }
    init(nombre:String) {
        self.nombre = nombre
        nombreId = ""
        item = []
        itemId = []
        estado = false
    }
}

public class ViajesCh {
    var carrier_line_id: Int
    var company_id: Int
    var driver_id: String
    var id: Int
    var idDestine: String
    var idOrigen: String
    var details: String
    init(carrier_line_id: Int,company_id:Int,driver_id:String,id:Int,idDestine:String,idOrigen:String,details:String) {
        self.carrier_line_id = carrier_line_id
        self.company_id = company_id
        self.driver_id = driver_id
        self.id = id
        self.idDestine = idDestine
        self.idOrigen = idOrigen
        self.details = details
    }
    init() {
        self.carrier_line_id = 0
        self.company_id = 0
        self.driver_id = ""
        self.id = 0
        self.idDestine = ""
        self.idOrigen = ""
        self.details = ""
    }
}

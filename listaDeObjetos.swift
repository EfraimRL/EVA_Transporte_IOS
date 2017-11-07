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

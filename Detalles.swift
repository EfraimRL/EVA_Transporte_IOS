//
//  Detalles.swift
//  EVA_Transporte_IOS
//
//  Created by MAC 2 on 25/10/17.
//  Copyright © 2017 EVA Transporte. All rights reserved.
//

import Foundation

struct Detalles {
    /*enum Meal: String {
     case breakfast, lunch, dinner
     }*/
    var nombre: String
    var nombreId: String
    var latitud: Float
    var Longitud: Float
    var CampoNombre = [String]() //Valores que se enumeraran en la tabla
    var CampoValor = [String]()
    var estado: DetallesGeneral.Estado
    
    //var viajes = [String]()
    var detalles : DetallesGeneral
}

extension Detalles {
    
    init?(json: [String: Any], tipo: String,ide:String) {
        //Datos estaticos de prueba
        self.nombre = "Juan"
        self.nombreId = "1"
        self.latitud = 0.0
        self.Longitud = 0.0
        self.CampoNombre = []
        self.CampoValor = []
        self.estado = DetallesGeneral.Estado.Verde
        //Fin Datos estaticos *Borrar*
        
        self.nombre = json["timezone"] as! String
        self.latitud = json["latitude"] as! Float
        self.Longitud = json["longitude"] as! Float
        self.nombreId = ide
        if ide != "solar" {
            self.nombreId = "solar"
        }
        let json2 = json["currently"] as! [String:Any]
        for (key, value) in json2[self.nombreId] as! [String:AnyObject] {
            //print("\(key) - \(value) ")
            self.CampoNombre.append(key)
            if let valor = value as? String {
                self.CampoValor.append("\(valor)")
            }
            if let valor = value as? Float {
                self.CampoValor.append(valor.description)
            }
        }
        
        self.detalles = DetallesGeneral(nombre: nombre,nombreId: nombreId,longitud:Longitud,latitud:latitud,campoNombre: CampoNombre,campoValor: CampoValor,estado: estado)
    }
    func returnLista() -> DetallesGeneral {
        return detalles
    }
    
}


public class DetallesGeneral {
    enum Estado: String {
     case Verde, Amarillo, Rojo
     }
    var nombre: String
    var nombreId: String
    var latitud: Float
    var Longitud: Float
    var CampoNombre = [String]()
    var CampoValor = [String]()
    var estado: Estado
    init(nombre:String,nombreId:String,longitud:Float,latitud:Float,campoNombre:[String],campoValor:[String],estado:Estado){
        self.nombre = nombre
        self.nombreId = nombreId
        self.latitud = latitud
        self.Longitud = longitud
        self.CampoNombre = campoNombre
        self.CampoValor = campoValor
        self.estado = estado
    }
    init(){
        self.nombre = ""
        self.nombreId = ""
        self.latitud = 0
        self.Longitud = 0
        self.CampoNombre = []
        self.CampoValor = []
        self.estado = Estado.Verde
    }
}

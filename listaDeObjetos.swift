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
    var id: Int = 0
    var hoursTraveled: String=""
    var hoursPlanned:String=""
    var idOrigen: String=""
    var idDestine: String=""
    var created_at:String=""
    var details: String=""
    var company_id: Int=0
    var driver_id:String=""
    var load_id:Int=0
    var state_id:Int=0
    var truck_id:Int=0
    var kms:String=""
    var gpsReads:String=""
    var updated_at:String=""
    var mt_id:Int=0
    var gpsDate:String="01-01-2017"
    var carrier_line_id: Int=0
    var cost:Double=0
    init(id: Int,hoursTraveled: String, hoursPlanned:String,idOrigen: String,idDestine: String,created_at:String,details: String,company_id: Int,driver_id:String, load_id:Int,state_id:Int,truck_id:Int,kms:String,gpsReads:String,updated_at:String,mt_id:Int,gpsDate:String,carrier_line_id: Int,cost:Double) {
        self.id = id
        self.hoursTraveled = hoursTraveled
        self.hoursPlanned = hoursPlanned
        self.idDestine = idDestine
        self.idOrigen = idOrigen
        self.created_at = created_at
        self.details = details
        self.company_id=company_id
        self.driver_id=driver_id
        self.load_id=load_id
        self.state_id=state_id
        self.truck_id=truck_id
        self.kms = kms
        self.gpsReads=gpsReads
        self.updated_at=updated_at
        self.mt_id=mt_id
        self.gpsDate=gpsDate
        self.carrier_line_id = carrier_line_id
        self.cost = cost
    }
    
}


class DriverFull {
    var id:String
    var code:String
    var department:String
    var names:String
    var lastnames:String
    var rfc:String
    var hiredDate:String	//"2017-11-03T00:00:00.000Z"
    var created_at:String
    var updated_at:String
    var url:String
    init(id:String,code:String,department:String,names:String,lastnames:String,rfc:String,hiredDate:String,created_at:String,updated_at:String,url:String) {
        self.id = id
        self.code = code
        self.department = department
        self.names = names
        self.lastnames = lastnames
        self.rfc = rfc
        self.hiredDate = hiredDate
        self.created_at = created_at
        self.updated_at = updated_at
        self.url = url
    }
}

class ClientFull{
    var id:String
    var names:String
    var lastnames:String
    var address:String
    var city:String
    var state:String
    var country:String
    var region:String
    var cp:String
    var notes:String
    var tel:String
    var movil:String
    var schedule:String
    var active:String
    var company_id:String
    var user_id:String
    var created_at:String
    var updated_at:String
    var url:String
    init(id:String,names:String,lastnames:String,address:String,city:String,state:String,country:String,region:String,cp:String,notes:String,tel:String,movil:String,schedule:String,active:String,company_id:String,user_id:String,created_at:String,updated_at:String,url:String){
        self.id = id
        self.names = names
        self.lastnames = lastnames
        self.address = address
        self.city = city
        self.state = state
        self.country = country
        self.region = region
        self.cp = cp
        self.notes = notes
        self.tel = tel
        self.movil = movil
        self.schedule = schedule
        self.active = active
        self.company_id = company_id
        self.user_id = user_id
        self.created_at = created_at
        self.updated_at = updated_at
        self.url = url
    }
}

class Notification{
    var code:String
    var protocols:String
    var grade:String
    var description:String
    init(code:String,protocols:String,grade:String,description:String) {
        self.code = code
        self.protocols = protocols
        self.grade = grade
        self.description = description
    }
}

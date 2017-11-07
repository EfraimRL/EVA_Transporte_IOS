//
//  TraerObjJSON.swift
//  EVA_Transporte_IOS
//
//  Created by MAC 2 on 18/10/17.
//  Copyright © 2017 EVA Transporte. All rights reserved.
//

import Foundation

class TraerJSON {
    func objJSON (url1: String,tipo:String, vista:String, id:String) -> AnyObject {
        var list = Lista()
        var detalle = DetallesGeneral()
        let requestURL : NSURL = NSURL(string: "https://darksky.net/forecast/19.4342,-99.1386/si12/es.json")!
        //let url = URL(string: "https://darksky.net/forecast/19.4342,-99.1386/si12/es.json")
        if let data = try? Data(contentsOf: requestURL as URL) {
            do {
                let parsedData = try JSONSerialization.jsonObject(with: data as Data, options: .allowFragments)
                //Store response in NSDictionary for easy access
                let dict = parsedData as? AnyObject
                //print("Dictionary ",dict)
                if vista == "detalles" {
                    if let detalleJSON = Detalles.init(json: dict as! [String:Any], tipo: tipo,ide:id){
                        detalle = detalleJSON.returnLista()
                        return detalle
                    }
                }
                if vista == "lista"{
                    let myJSON = dict?["currently"] as! [String:Any]
                    
                    if let listaJson = Viajes.init(json: dict as! [String:Any], tipo: tipo){
                        list = listaJson.returnLista()
                        return list
                    }
                }
                
            }
            catch let error as NSError {
                print("Detalles del error al parsear JSON:\n \(error)")
            }
        }
        /*
        let task = URLSession.shared.dataTask(with: url!) { (data, response, error) in
            if error != nil{
                print("Error")
            }
            else{
                
                if let content = data{
                    do{
                        //Todo el archivo con los datos
                        let myJSON = try JSONSerialization.jsonObject(with: content, options: JSONSerialization.ReadingOptions.mutableContainers) as! AnyObject
                        //aqui metodo para guardar traer el dato que necesite (Chofer(s), Viajes y Clientes)
                        if let chofer = Viajes.init(json: myJSON as! [String : Any], tipo: tipo){
                            list = chofer.returnLista()
                        }
                    }
                    catch{
                    }
                }
            }
        }
        */
        
        //task.resume()
        return list
    }
    
}

struct Viajes {
    /*enum Meal: String {
        case breakfast, lunch, dinner
    }*/
    var nombre: String
    var nombreId: String
    var item = [String]() //Valores que se enumeraran en la tabla
    var itemId = [String]()
    var estado: Bool
    
    //var viajes = [String]()
    var list : Lista
}

extension Viajes {
    
    init?(json: [String: Any], tipo: String) {
        //Datos estaticos de prueba
        self.nombre = "Juan"
        self.nombreId = "1"
        self.item = []
        self.itemId = []
        self.estado = true
        //Fin Datos estaticos *Borrar*
        
        self.nombre = json["timezone"] as! String
        self.nombreId = "solar"
        for (key, value) in json["currently"] as! [String:AnyObject] {
            //print("\(key) - \(value) ")
            self.item.append(key)
            if let valor = value as? String {
                self.itemId.append(valor)
            }
            if let valor = value as? Float {
                self.itemId.append(valor.description)
            }
        }
        //Aqui hay que implementar el metodo para sacar los datos
        /*guard let chofer = json["Chofer"] as? [String:Any],
            let viajes = chofer["Viajes"] as? [String]
            else {
                return nil
            }*/
        if let estado = json["estado"] as? Bool{
            self.estado = estado
        }
        /*var i = 0
        for viaje in viajes{
            self.viajes.insert(viaje, at: i)
            i = i + 1
        }*/
        /*
         for string in mealsJSON {
            guard let meal = Meal(rawValue: string) else {
                return nil
            }
            
            meals.insert(meal)
        }
        
        self.name = name
        self.coordinates = (latitude, longitude)
        self.meals = meals
         */
        self.list = Lista(nombre: nombre,nombreId: nombreId,item: item,itemId: itemId,estado: estado)
    }
    func returnLista() -> Lista {
        return list
    }
}


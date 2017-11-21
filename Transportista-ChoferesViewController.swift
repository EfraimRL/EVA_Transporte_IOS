//
//  Transportista-ChoferesViewController.swift
//  EVA_Transporte_IOS
//
//  Created by Cesar Castro Arriaga on 27/09/17.
//  Copyright © 2017 EVA Transporte. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class Transportista_ChoferesViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    
    @IBOutlet var tvChoferesLista: UITableView!
    
    var choferId = "" //Viaje Seleccionado
    var arrayClientes = [AnyObject]()
    override func viewDidLoad() {
        super.viewDidLoad()
        /*let json = TraerJSON()
        let listaViajes = json.objJSON(url1: "http://...",tipo:"Transportista-chofer",vista:"lista",id:nombreId) as! Lista
        print("Lista ",listaViajes)
        let nombre = listaViajes.nombre
        print("Transportista ",nombre)
        self.item = listaViajes.item
        self.itemId = listaViajes.itemId
        */
        self.tvChoferesLista.delegate = self
        self.tvChoferesLista.dataSource = self
        //self.tvChoferesLista.allowsSelection = true
        Listar()
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Actualizar",style: .done, target: self, action: #selector(Transportista_ChoferesViewController.Listar) )
    }
    //Listar celda de viaje
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let celda = tableView.dequeueReusableCell(withIdentifier: "celTC", for: indexPath) as! Transportista_choferTableViewCell
        celda.configureCell(DriverFull: arrayClientes[indexPath.row] as! DriverFull)
        return celda
    }
    //Seleccionar celda y enviar a detalles
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let send = arrayClientes[indexPath.row]
        print("Selecciono el numero ",indexPath.row," Nombre ",arrayClientes[indexPath.row])
        performSegue(withIdentifier: "segTChofer-Detalles", sender: send)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destino  = segue.destination as! Transportista_DetallesDelChoferViewController
        //si hay un objeto, se envia a la vista de detalles
        if let detalleSeleccionado = sender as? DriverFull{
            print("Nombre de conductor: ",detalleSeleccionado.names)
            destino.objDetConductor = detalleSeleccionado
        }
    }
    
    //Si hay o no registros como respuesta
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if self.arrayClientes.count == 0{
            tvChoferesLista.isHidden = true
        }
        else{
            tvChoferesLista.isHidden = false
        }
        return self.arrayClientes.count
    }
    func Listar(){
        arrayClientes.removeAll()
        Alamofire.request("\(localhost)/drivers.json", headers: user_headers).responseJSON { response in
            if response.result.value != nil {
                let json = JSON(response.result.value!)
                print(json)
                if json == JSON.null {
                    let result = json["message"]
                    print("Mensaje traido de server (json)",result)
                }
                else{
                    for (_,propDeDriver):(String,JSON) in json{
                        
                        let id = propDeDriver["id"].int!
                        let code = propDeDriver["code"].string!
                        let department = propDeDriver["department"].string!
                        let names = propDeDriver["names"].string!
                        let lastnames = propDeDriver["lastnames"].string!
                        let rfc = propDeDriver["rfc"].string!
                        let hiredDate = propDeDriver["hiredDate"].string!
                        let created_at = propDeDriver["created_at"].string!
                        let updated_at = propDeDriver["updated_at"].string!
                        let url = "http://localhost:3000/drivers"//propDeDriver["url"].string!
                        let idString = "\(id)"
                        let Conductor = DriverFull(id: idString,code:code,department:department,names:names,lastnames:lastnames,rfc:rfc,hiredDate:hiredDate,created_at:created_at,updated_at:updated_at,url:url)
                        
                        self.arrayClientes.append(Conductor)
                    }
                    self.tvChoferesLista.reloadData()
                }
            }
            else{print("No hubo resultados del servidor ")}
        }
        
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

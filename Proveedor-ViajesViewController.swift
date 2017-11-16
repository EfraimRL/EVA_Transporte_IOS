//
//  Proveedor-ViajesViewController.swift
//  EVA_Transporte_IOS
//
//  Created by MAC 2 on 26/09/17.
//  Copyright © 2017 EVA Transporte. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class Proveedor_ViajesViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {

    @IBOutlet weak var tvProveedores: UITableView!
    var nombre = ""//Nombre del usuario, chofer que esta en la app actualmente
    var nombreId = ""
    var item = [""] //Son los objetos que se enlistaran
    var itemId = [""]
    var ViajeId = "" //Viaje Seleccionado
    var arrayViajes = [AnyObject]()
    var detalles:ViajesCh?
    override func viewDidLoad() {
        super.viewDidLoad()
        /*let json = TraerJSON()
        let listaViajes = json.objJSON(url1: "http://...",tipo:"Cliente",vista: "lista",id: nombreId) as! Lista
        print("Lista ",listaViajes)
        let nombre = listaViajes.nombre
        print("Cliente ",nombre)
        self.item = listaViajes.item
        self.itemId = listaViajes.itemId
        */
        self.tvProveedores.dataSource = self
        self.tvProveedores.delegate = self
        traerDatos()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let celda = tableView.dequeueReusableCell(withIdentifier: "celProve", for: indexPath) as! Proveedor_ViajeTableViewCell
        celda.configureCell(ViajesCh: arrayViajes[indexPath.row] as! ViajesCh)
        
        return celda
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let obj = arrayViajes[indexPath.row] as! ViajesCh
        detalles = obj
        ViajeId = "\(obj.id)"
        print("Selecciono el numero ",indexPath.row," Detalle ",obj.details)
        performSegue(withIdentifier: "segClienteViajes-Detalles", sender: obj)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if self.arrayViajes.count == 0{
            tvProveedores.isHidden = true
        }
        else{tvProveedores.isHidden = false}
        return self.arrayViajes.count
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destino  = segue.destination as! Proveedor_DetalleDeViajeViewController
        if let detalleSeleccionado = sender as? ViajesCh{
            destino.objDetViaje = detalleSeleccionado
        }
        destino.clienteId = nombreId
        destino.viajeId = ViajeId
        //destino.objDetViaje = detalles
    }
    //Traer los datos
    func traerDatos(){
        let driver_id = 1
        let dataSend = ["company_id": company_id, "driver_id": driver_id] as [String:Any]
        print(dataSend)
        Alamofire.request("http://localhost:3000/travels2.json",method: .post, parameters: dataSend, encoding: JSONEncoding(options: [])).responseJSON{ response in
            //print(response)
            if response.result.value != nil {
                let json = JSON(response.result.value!)
                print(json)
                if json == JSON.null {
                    let result = json["message"]
                    print(result)
                }
                else{
                    for (_,propDeViajes):(String,JSON) in json{
                        
                        let id = propDeViajes["id"].int!
                        let idDestine = "Destino"//propDeViajes["idDestine"].string!
                        let idOrigen = "Origen"//propDeViajes["idOrigen"].string!
                        let company_id = propDeViajes["company_id"].int!
                        let driver_id = "1"//propDeViajes["driver_id"].string!
                        let details = propDeViajes["details"].string!
                        let carrier_line_id = propDeViajes["carrier_line_id"].int!
                        
                        let viajeN = ViajesCh(id: id,hoursTraveled: "", hoursPlanned:"",idOrigen: idOrigen,idDestine: idDestine,created_at:"",details: details,company_id: company_id,driver_id:driver_id, load_id:0,state_id:0,truck_id:0,kms:"",gpsReads:"",updated_at:"",mt_id:0,gpsDate:"",carrier_line_id: carrier_line_id,cost:0.0)
                        
                        self.arrayViajes.append(viajeN)
                    }
                    self.tvProveedores.reloadData()
                }
            }
            else{print("otroElse ")}
        }
        
    }
}

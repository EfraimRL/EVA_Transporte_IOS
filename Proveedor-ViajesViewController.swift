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
        celda.configureCell(listaDeObjetos: arrayViajes[indexPath.row] as! listaDeObjetos)
        //let nombreCategoria = arrayCategoria[indexPath.row]["Nombre"]
        //let viaje = item[indexPath.row]
        //celda.lblPViaje?.text = viaje
        return celda
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        ViajeId = itemId[indexPath.row]
        print("Selecciono el numero ",indexPath.row," Detalle ",item[indexPath.row])
        performSegue(withIdentifier: "segClienteViajes-Detalles", sender: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if self.arrayViajes.count == 0{
            tvProveedores.isHidden = true
        }
        return self.arrayViajes.count
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destino  = segue.destination as! Proveedor_DetalleDeViajeViewController
        destino.clienteId = nombreId
        destino.viajeId = ViajeId
    }
    //Traer los datos
    func traerDatos(){
        var driver_id = 1
        let dataSend = ["company_id": company_id, "driver_id": driver_id] as [String:Any]
        print(dataSend)
        Alamofire.request("http://localhost:3000/travels2.json",method: .post, parameters: dataSend, encoding: JSONEncoding(options: [])).responseJSON{ response in
            print(response)
            var segueV:String=""
            if response.result.value != nil {
                let json = JSON(response.result.value!)
                print(json)
                if json == JSON.null {
                    let result = json["message"]
                    
                }
                else{
                    for (_,listaDeObjeto):(String,JSON) in json{
                        let viaje = listaDeObjeto["nombre"].string!
                        
                        let viajeN = listaDeObjetos(nombre:viaje)
                        self.arrayViajes.append(viajeN)
                        
                    }
                }
            }
            else{print("otroElse ")}
        }
        
    }
}

//
//  Chofer-ViajesViewController.swift
//  EVA_Transporte_IOS
//
//  Created by MAC 2 on 26/09/17.
//  Copyright © 2017 EVA Transporte. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class Chofer_ViajesViewController: UIViewController,UITableViewDataSource,UITableViewDelegate{

    @IBOutlet weak var tvChoferes: UITableView!
    var nombre = ""//Nombre del usuario, chofer que esta en la app actualmente
    var nombreId = ""
    var item = ["1"] //Son los objetos que se enlistaran
    var itemId = ["1"]
    var ViajeId = "" //Viaje Seleccionado
    var arrayViajes = [AnyObject]()
    override func viewDidLoad() {
        super.viewDidLoad()
        let json = TraerJSON()
        let listaViajes = json.objJSON(url1: "http://...",tipo:"Chofer",vista:"lista",id:nombreId) as! Lista
        print("Lista ",listaViajes)
        let nombre = listaViajes.nombre
        print("Chofer ",nombre)
        self.item = listaViajes.item
        self.itemId = listaViajes.itemId
        self.tvChoferes.dataSource = self
        self.tvChoferes.delegate = self
        print(company_id)
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let celda = tableView.dequeueReusableCell(withIdentifier: "celV", for: indexPath) as! Chofer_viajeTableViewCell
        
        //listar
        //celda.configureCell(listaDeObjetos: arrayViajes[indexPath.row] as! listaDeObjetos)
        
        let Viaje =   item[indexPath.row]
        celda.lblViaje?.text = Viaje
        return celda
    }

    //Manda a la siguiente vista
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        /*//Con esto se puede sacar el contenido de la celda seleccionada
        let celda = tableView.cellForRow(at: indexPath) as! Chofer_viajeTableViewCell
        celda.lblViaje?.text
        */
        ViajeId = item[indexPath.row]
        //print("Selecciono el numero ",indexPath.row," Detalle ",item[indexPath.row])
        performSegue(withIdentifier: "segChofer-Detalles", sender: nil)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destino  = segue.destination as! Chofer_DetalleDeViajeViewController
        destino.choferId = nombreId
        destino.ViajeId = ViajeId
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if self.arrayViajes.count == 0{
            //tvChoferes.isHidden = true
        }
        return self.item.count
    }
    @IBAction func btnSalir(_ sender: Any) {
        performSegue(withIdentifier: "segChoferViajesSalir", sender: nil)
    }
    
    //Trae datos y guardar en un array
    func traerLista(){
        Alamofire.request("http://localhost:3000/travels.json").responseJSON{ response in
            print(response)
            if response.result.value != nil {
                let json = JSON(response.result.value!)
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
            else{print("No hgubo respuesta ")}
        }
        
    }

}

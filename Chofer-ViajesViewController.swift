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
import UserNotifications

class Chofer_ViajesViewController: UIViewController,UITableViewDataSource,UITableViewDelegate,UNUserNotificationCenterDelegate{

    @IBOutlet weak var viewDeTabla: UIView!
    @IBOutlet weak var tvChoferes: UITableView!
    var aDonde = false
    var nombre = ""//Nombre del usuario, chofer que esta en la app actualmente
    var nombreId = ""
    var item = ["1"] //Son los objetos que se enlistaran
    var itemId = ["1"]
    var ViajeId = "" //Viaje Seleccionado
    var arrayViajes = [AnyObject]()
    override func viewDidLoad() {
        super.viewDidLoad()
        /*let json = TraerJSON()
        let listaViajes = json.objJSON(url1: "http://...",tipo:"Chofer",vista:"lista",id:nombreId) as! Lista
        //print("Lista ",listaViajes)
        let nombre = listaViajes.nombre
        print("Chofer ",nombre)
        self.item = listaViajes.item
        self.itemId = listaViajes.itemId
         */
        self.tvChoferes.dataSource = self
        self.tvChoferes.delegate = self
        print(company_id)
        Listar()
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Actualizar",style: .done, target: self, action: #selector(Chofer_ViajesViewController.Listar) )
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Salir",style: .done, target: self, action: #selector(salir) )
    }
    func salir(){
        aDonde = false
        performSegue(withIdentifier: "salir", sender: nil)
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let celda = tableView.dequeueReusableCell(withIdentifier: "celV", for: indexPath) as! Chofer_viajeTableViewCell
        /*
        //listar
        //celda.configureCell(listaDeObjetos: arrayViajes[indexPath.row] as! listaDeObjetos)
        
        let Viaje =   item[indexPath.row]
        celda.lblViaje?.text = Viaje
        */
        celda.configureCell(ViajesCh: arrayViajes[indexPath.row] as! ViajesCh)
        
        return celda
    }

    //Manda a la siguiente vista
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        /*//Con esto se puede sacar el contenido de la celda seleccionada
        let celda = tableView.cellForRow(at: indexPath) as! Chofer_viajeTableViewCell
        celda.lblViaje?.text
        */
        let send = arrayViajes[indexPath.row]
        aDonde = true
        //print("Selecciono el numero ",indexPath.row," Detalle ",item[indexPath.row])
        performSegue(withIdentifier: "segChofer-Detalles", sender: send)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if aDonde{
            let destino  = segue.destination as! Chofer_DetalleDeViajeViewController
            //destino.choferId = nombreId
            destino.ViajeId = "solar"
            if let detalleSeleccionado = sender as? ViajesCh{
                print(detalleSeleccionado.details)
                destino.objDetViaje = detalleSeleccionado
            }
        }
        else{
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if self.arrayViajes.count == 0{
            tvChoferes.isHidden = true
            viewDeTabla.isHidden = true
        }
        else{
            tvChoferes.isHidden = false
            viewDeTabla.isHidden = false
        }
        return self.arrayViajes.count
    }
    
    //Trae datos del WS y lo guarda en un array que muestra en lista
    func Listar(){
        arrayViajes.removeAll()
        let driver_id = 1
        let dataSend = ["company_id": company_id, "driver_id": driver_id] as [String:Any]
        print(dataSend)
        /*
         pagina = "travelsDriver.json"
         Alamofire.request("\(localhost)/\(pagina)/\(user_id)"
         */
        pagina = "travelsDriver/\(user_id).json"
        print("\(localhost)/\(pagina)")
        Alamofire.request("\(localhost)/\(pagina)", headers: user_headers).responseJSON{ response in
            //print(response)
            if response.result.value != nil {
                let json = JSON(response.result.value!)
                print(json)
                if json == JSON.null {
                    let result = json["message"]
                    print("Mensaje traido de server (json)",result)
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
                    self.tvChoferes.reloadData()
                }
            }
            else{
                alerta(titulo: "Error", mensaje: "No hubo resultados del servidor o no hay conexiòn", cantidad_Botones: 1, estilo_controller: UIAlertControllerStyle.alert, estilo_boton: UIAlertActionStyle.default,sender: self)
                print("No hubo resultados del servidor ")
            }
        }
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

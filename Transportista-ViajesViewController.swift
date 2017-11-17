//
//  Transportista-ViajesViewController.swift
//  EVA_Transporte_IOS
//
//  Created by Cesar Castro Arriaga on 27/09/17.
//  Copyright © 2017 EVA Transporte. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class Transportista_ViajesViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {
    
    
    @IBOutlet var tvTransportistaViajesLista: UITableView!
    
    var arrayViajes = [AnyObject]()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tvTransportistaViajesLista.dataSource = self
        self.tvTransportistaViajesLista.delegate = self
        Listar()
    }
    //Listar celda de viaje
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let celda = tableView.dequeueReusableCell(withIdentifier: "celTV", for: indexPath) as! Transportista_viajeTableViewCell
        celda.configureCell(ViajesCh: arrayViajes[indexPath.row] as! ViajesCh)
        return celda
    }
    //Seleccionar celda y enviar a detalles
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let send = arrayViajes[indexPath.row]
        print("Selecciono el numero ",indexPath.row," de la lista, detalle de viaje ",arrayViajes[indexPath.row])
        performSegue(withIdentifier: "segTViaje-Detalles", sender: send)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destino  = segue.destination as! Transportista_DetallesDeViajeViewController
        //si hay un objeto, se envia a la vista de detalles
        if let detalleSeleccionado = sender as? ViajesCh{
            print("Detalle: ", detalleSeleccionado.details)
            destino.objDetViaje = detalleSeleccionado
        }
    }
    
    //Si hay o no registros como respuesta muestra u oculta la Tabla (UITableView)
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if self.arrayViajes.count == 0{
            tvTransportistaViajesLista.isHidden = true
        }
        else{
            tvTransportistaViajesLista.isHidden = false
        }
        return self.arrayViajes.count
    }
    
    //Trae los datos y lo guarda en un arrayViajes [tipo ViajesCh]. Con ese array llena la tabla
    func Listar(){
        let dataSend = ["company_id": company_id, "driver_id": user_id] as [String:Any]
        print(dataSend)
        pagina = "travels2.json"
        Alamofire.request("\(localhost)\(pagina)",method: .post, parameters: dataSend, encoding: JSONEncoding(options: [])).responseJSON{ response in
            //print(response)
            if response.result.value != nil {
                let json = JSON(response.result.value!)
                print("Viajes: ",json)
                if json == JSON.null {
                    let result = json["message"]
                    alerta(titulo: "Error", mensaje: "No hay registros", cantidad_Botones: 1, estilo_controller: .alert, estilo_boton: .default, sender: self)
                    print("Mensaje traido de server (json)",result)
                }
                else{
                    for (_,propDeViajes):(String,JSON) in json{
                        
                        let id = propDeViajes["id"].int!
                        let idDestine = "Destino"//propDeViajes["idDestine"].string!
                        let idOrigen = "Origen"//propDeViajes["idOrigen"].string!
                        let company_id = propDeViajes["company_id"].int!
                        let driver_id = "1"//propDeViajes["driver_id"].string!
                        var details = propDeViajes["details"].string!
                            if details == "" {details = "Detalle no disponible"}
                        let carrier_line_id = propDeViajes["carrier_line_id"].int!
                        
                        let viajeN = ViajesCh(id: id,hoursTraveled: "", hoursPlanned:"",idOrigen: idOrigen,idDestine: idDestine,created_at:"",details: details,company_id: company_id,driver_id:driver_id, load_id:0,state_id:0,truck_id:0,kms:"",gpsReads:"",updated_at:"",mt_id:0,gpsDate:"",carrier_line_id: carrier_line_id,cost:0.0)
                        
                        self.arrayViajes.append(viajeN)
                    }
                    self.tvTransportistaViajesLista.reloadData()
                }
            }
            else{
                print("No hubo resultados del servidor ")
            }
        }
        
    }
    
    //Otros
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

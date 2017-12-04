//
//  Chofer-NotificacionesViewController.swift
//  EVA_Transporte_IOS
//
//  Created by MAC 2 on 18/10/17.
//  Copyright © 2017 EVA Transporte. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class Chofer_NotificacionesViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {

    var choferId = ""
    var descripciones = ["Desastre Natural","Falla del Vehiculo","Documentacion","Otro"]
    var imagenes = [#imageLiteral(resourceName: "DesastreNatural"),#imageLiteral(resourceName: "FallaDelVehiculo"),#imageLiteral(resourceName: "Documentacion"),#imageLiteral(resourceName: "Otro")]
    
    @IBOutlet weak var vista: UIView!
    @IBOutlet weak var tvChoferNotificaciones: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tvChoferNotificaciones.delegate = self
        self.tvChoferNotificaciones.dataSource = self
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "",style: .plain, target: nil,action: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    //Cantidad de celdas
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.descripciones.count
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return vista.frame.size.height/4
    }
    //Carga las celdasd
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let celda = tableView.dequeueReusableCell(withIdentifier: "celCDNoti", for: indexPath) as! Chofer_NotificacionesTableViewCell
        celda.frame.size.height = vista.frame.size.height/4
        let Detalle = descripciones[indexPath.row]
        celda.lblDescripcion?.text = Detalle
        celda.imgIcono.image = imagenes[indexPath.row]
        return celda
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    }

    func enviarNotificacion(){
        var dataSend = "["name":"Otro", "code":"3", "grade":"Menor","protocol":Descanso"  ]"
        Alamofire.request("\(localhost)/states.json",method: .post, parameters: dataSend, encoding: JSONEncoding(options: [])).responseJSON{ response in
            print(response)
            var segueV:String=""
            if response.result.value != nil {
                let json = JSON(response.result.value!)
                print(json)
                if json["message"] != JSON.null {
                    let result = json["message"].string!
                    print("Nulo: ",result)
                    _ = LocalNotification.Notificaciones(with: "No se pudo ingresar:", body: result, at: Date().addedBy(seconds: 0), sender: self)
                    alerta(titulo: "No se pudo ingresar:", mensaje: result, cantidad_Botones: 1, estilo_controller: .alert, estilo_boton: .default, sender: self)
                }
                else{
                    
                    
                }
            }
            else{
                alerta(titulo: "Error", mensaje: "No hubo resultados del servidor o no hay conexiòn", cantidad_Botones: 1, estilo_controller: UIAlertControllerStyle.alert, estilo_boton: UIAlertActionStyle.default, sender: self)
                print("No hay respuesta del Web Service")
            }
 
    }
}

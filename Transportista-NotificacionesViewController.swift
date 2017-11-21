//
//  Transportista-NotificacionesViewController.swift
//  EVA_Transporte_IOS
//
//  Created by MAC 2 on 11/10/17.
//  Copyright © 2017 EVA Transporte. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
class Transportista_NotificacionesViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    @IBOutlet weak var tvTNtificaciones: UITableView!
    var arrayNotificaciones = [AnyObject]()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tvTNtificaciones.dataSource = self
        self.tvTNtificaciones.delegate = self
        //var json = TraerJSON()
        Listar()
    }
//Listar celda de viaje
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let celda = tableView.dequeueReusableCell(withIdentifier: "celTN", for: indexPath) as! Transportista_NotificacionesTableViewCell
        celda.configureCell(Notification: arrayNotificaciones[indexPath.row] as! Notification)
        //celda.lblTN?.text = arrayCiudades
        return celda
    }
//Seleccion de celda

//Si hay o no registros como respuesta
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if self.arrayNotificaciones.count == 0{
            tvTNtificaciones.isHidden = true
        }
        else{
            tvTNtificaciones.isHidden = false
        }
        return self.arrayNotificaciones.count
    }
//Traer datos (notificaciones)
    func Listar(){
        let dataSend = ["company_id": company_id, "driver_id": user_id] as [String:Any]
        print(dataSend)
        Alamofire.request("http://localhost:3000/state.json",method: .post, parameters: dataSend, encoding: JSONEncoding(options: [])).responseJSON{ response in
            if response.result.value != nil {
                let json = JSON(response.result.value!)
                print(json)
                if json == JSON.null {
                    let result = json["message"]
                    print("Mensaje traido de server (json)",result)
                }
                else{
                    for (_,detDeNotificaciones):(String,JSON) in json{
                        
                        let code = detDeNotificaciones["code"].string!
                        var protocols = detDeNotificaciones["protocols"].string!
                        var grade = detDeNotificaciones["grade"].string!
                        var description = detDeNotificaciones["description"].string!

                        let Notificacion = Notification(code:code,protocols:protocols,grade:grade,description:description)
                        
                        self.arrayNotificaciones.append(Notificacion)
                    }
                    self.tvTNtificaciones.reloadData()
                }
            }
            else{print("No hubo resultados del servidor ")}
        }
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

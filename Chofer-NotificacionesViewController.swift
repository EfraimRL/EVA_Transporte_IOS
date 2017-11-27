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

}

//
//  Chofer-NotificacionesViewController.swift
//  EVA_Transporte_IOS
//
//  Created by MAC 2 on 18/10/17.
//  Copyright © 2017 EVA Transporte. All rights reserved.
//

import UIKit

class Chofer_NotificacionesViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {

    var choferId = ""
    var descripciones = ["Desastre Natural","Falla del Vehiculo","Documentacion","Otro"]
    
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
    //Carga las celdasd
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let celda = tableView.dequeueReusableCell(withIdentifier: "celCDNoti", for: indexPath) as! Chofer_NotificacionesTableViewCell
        celda.frame.size.height = vista.frame.size.height/4
        //let nombreCategoria = arrayCategoria[indexPath.row]["Nombre"]
        let Detalle = descripciones[indexPath.row]
        celda.lblDescripcion?.text = Detalle
        //celda.imgIcono.image?.imageAsset.
        //celda.imgIcono = Imagen
        return celda
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let celda = tableView.cellForRow(at: indexPath) as! Chofer_NotificacionesTableViewCell
        print("Selecciono el numero ",indexPath.row," Detalle ",celda.lblDescripcion?.text!)
    }

}

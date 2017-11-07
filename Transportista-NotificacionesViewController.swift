//
//  Transportista-NotificacionesViewController.swift
//  EVA_Transporte_IOS
//
//  Created by MAC 2 on 11/10/17.
//  Copyright © 2017 EVA Transporte. All rights reserved.
//

import UIKit

class Transportista_NotificacionesViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
   var ciudades = ["Notificacion 1","Notificacion 2","Notificacion 3","Notificacion 4"]
    @IBOutlet weak var tvTNtificaciones: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tvTNtificaciones.dataSource = self
        self.tvTNtificaciones.delegate = self
        var json = TraerJSON()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    //Seccion de Mapa
    
    //Seccion de detalles
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.ciudades.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let celda = tableView.dequeueReusableCell(withIdentifier: "celTN", for: indexPath) as! Transportista_NotificacionesTableViewCell
        let arrayCiudades =   ciudades[indexPath.row]
        celda.lblTN?.text = arrayCiudades
        return celda
    }

}

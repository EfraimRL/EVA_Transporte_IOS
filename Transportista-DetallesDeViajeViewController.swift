//
//  Transportista-DetallesDeViajeViewController.swift
//  EVA_Transporte_IOS
//
//  Created by Cesar Castro Arriaga on 28/09/17.
//  Copyright © 2017 EVA Transporte. All rights reserved.
//

import UIKit

class Transportista_DetallesDeViajeViewController: UIViewController,UITableViewDataSource,UITableViewDelegate{

    @IBOutlet var tvTViajeDetalles: UITableView!
    var ciudades = ["Detalle","Viaje","Desde Transportista"]
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tvTViajeDetalles.dataSource = self
        self.tvTViajeDetalles.delegate = self
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    //Seccion de Mapa
    
    //Seccion de detalles
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.ciudades.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let celda = tableView.dequeueReusableCell(withIdentifier: "celTVD", for: indexPath) as! Transportista_DetallesDeViajeTableViewCell
        let arrayCiudades =   ciudades[indexPath.row]
        celda.lblTVD?.text = arrayCiudades
        return celda
    }
}

//
//  Proveedor_DetalleDeViajeViewController.swift
//  EVA_Transporte_IOS
//
//  Created by MAC 2 on 26/09/17.
//  Copyright © 2017 EVA Transporte. All rights reserved.
//

import UIKit

class Proveedor_DetalleDeViajeViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {
    
    
    @IBOutlet weak var tvProveedorViajeDetalles: UITableView!

    var ciudades = ["Detalle","Destino","Origen","Telefono"]
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tvProveedorViajeDetalles.dataSource = self
        self.tvProveedorViajeDetalles.delegate = self
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
        
        let celda = tableView.dequeueReusableCell(withIdentifier: "celPVD", for: indexPath) as! Proveedor_DetalleDeViajeTableViewCell
        let arrayCiudades =   ciudades[indexPath.row]
        celda.lblPDetalle?.text = arrayCiudades
        return celda
    }

}

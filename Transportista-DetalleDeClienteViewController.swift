//
//  Transportista-DetalleDeClienteViewController.swift
//  EVA_Transporte_IOS
//
//  Created by Cesar Castro Arriaga on 28/09/17.
//  Copyright © 2017 EVA Transporte. All rights reserved.
//

import UIKit

class Transportista_DetalleDeClienteViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {

    @IBOutlet var tvTClienteDetalles: UITableView!
    var ciudades = ["Detalle","Cliente","Telefono"]
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tvTClienteDetalles.dataSource = self
        self.tvTClienteDetalles.delegate = self
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
        
        let celda = tableView.dequeueReusableCell(withIdentifier: "celTClD", for: indexPath) as! Transportista_DetallesDeClienteTableViewCell
        let arrayCiudades =   ciudades[indexPath.row]
        celda.lblTClD?.text = arrayCiudades
        return celda
    }

}

//
//  Transportista-DetallesDelChoferViewController.swift
//  EVA_Transporte_IOS
//
//  Created by Cesar Castro Arriaga on 28/09/17.
//  Copyright © 2017 EVA Transporte. All rights reserved.
//

import UIKit

class Transportista_DetallesDelChoferViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {

    @IBOutlet var tvTChoferDetalles: UITableView!
    var ciudades = ["Detalle","Chofer","Transportista"]
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tvTChoferDetalles.dataSource = self
        self.tvTChoferDetalles.delegate = self
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
        
        let celda = tableView.dequeueReusableCell(withIdentifier: "celTCD", for: indexPath) as! Transportista_DetallesDeChoferTableViewCell
        let arrayCiudades =   ciudades[indexPath.row]
        celda.lblTCD?.text = arrayCiudades
        return celda
    }

}

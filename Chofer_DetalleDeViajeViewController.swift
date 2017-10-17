//
//  Chofer_DetalleDeViajeViewController.swift
//  EVA_Transporte_IOS
//
//  Created by MAC 2 on 26/09/17.
//  Copyright © 2017 EVA Transporte. All rights reserved.
//

import UIKit

class Chofer_DetalleDeViajeViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {

    var ciudades = ["Detalle","Destino","Origen","Telefono"]
    
    @IBOutlet weak var tvChoferViajeDetalles: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tvChoferViajeDetalles.dataSource = self
        self.tvChoferViajeDetalles.delegate = self
        // Do any additional setup after loading the view.
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
        
        let celda = tableView.dequeueReusableCell(withIdentifier: "celCVD", for: indexPath) as! Chofer_DetalleDeViajeTableViewCell
        
        //let nombreCategoria = arrayCategoria[indexPath.row]["Nombre"]
        let arrayCiudades =   ciudades[indexPath.row]
        celda.lblCVDetalle?.text = arrayCiudades
        return celda
    }
}

//
//  Proveedor-ViajesViewController.swift
//  EVA_Transporte_IOS
//
//  Created by MAC 2 on 26/09/17.
//  Copyright © 2017 EVA Transporte. All rights reserved.
//

import UIKit

class Proveedor_ViajesViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {

    
    @IBOutlet weak var tvProveedores: UITableView!
    var ciudades = ["Nuevo Laredo","Monterrey","Colima","Piedras negras"]
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tvProveedores.dataSource = self
        self.tvProveedores.delegate = self
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.ciudades.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let celda = tableView.dequeueReusableCell(withIdentifier: "celProve", for: indexPath) as! Proveedor_ViajeTableViewCell
        
        //let nombreCategoria = arrayCategoria[indexPath.row]["Nombre"]
        let arrayCiudades =   ciudades[indexPath.row]
        celda.lblPViaje?.text = arrayCiudades
        return celda
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
    }

}

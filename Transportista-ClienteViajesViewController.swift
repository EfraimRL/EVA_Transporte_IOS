//
//  Transportista-ClienteViajesViewController.swift
//  EVA_Transporte_IOS
//
//  Created by MAC 2 on 11/10/17.
//  Copyright © 2017 EVA Transporte. All rights reserved.
//

import UIKit

class Transportista_ClienteViajesViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    var idDeCliente = ""
    @IBOutlet weak var tvTClientesViajesLista: UITableView!
    var ciudades = ["Viaje 1","Viaje 2","Viaje 3"]
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tvTClientesViajesLista.delegate = self
        self.tvTClientesViajesLista.dataSource = self
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
        
        let celda = tableView.dequeueReusableCell(withIdentifier: "celTCViajes", for: indexPath) as! Transportista_ClientesVajesTableViewCell
        
        //let nombreCategoria = arrayCategoria[indexPath.row]["Nombre"]
        let arrayCiudades =   ciudades[indexPath.row]
        celda.lblTClienteViajes?.text = arrayCiudades
        return celda
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
    }
}

//
//  Transportista-ViajesViewController.swift
//  EVA_Transporte_IOS
//
//  Created by Cesar Castro Arriaga on 27/09/17.
//  Copyright © 2017 EVA Transporte. All rights reserved.
//

import UIKit

class Transportista_ViajesViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {
    
    
    @IBOutlet var tvTransportistaViajesLista: UITableView!
    
    var ciudades = ["Madrid","Barcelona","Tarragona","Lleida","Valencia","Málaga","Toledo"]
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tvTransportistaViajesLista.dataSource = self
        self.tvTransportistaViajesLista.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.ciudades.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let celda = tableView.dequeueReusableCell(withIdentifier: "celTV", for: indexPath) as! Transportista_viajeTableViewCell
        
        //let nombreCategoria = arrayCategoria[indexPath.row]["Nombre"]
        let arrayCiudades =   ciudades[indexPath.row]
        celda.lblTViaje?.text = arrayCiudades
        return celda
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
    }
}

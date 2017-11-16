//
//  Transportista-ClientesViewController.swift
//  EVA_Transporte_IOS
//
//  Created by Cesar Castro Arriaga on 27/09/17.
//  Copyright © 2017 EVA Transporte. All rights reserved.
//

import UIKit

class Transportista_ClientesViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {

    @IBOutlet var tvTClientesLista: UITableView!
    var ciudades = ["Cliente 1","Cliente 2","Cliente 3","Cliente 4","Cliente 5","Cliente 6","Cliente 7"]
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tvTClientesLista.delegate = self
        self.tvTClientesLista.dataSource = self
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
        
        let celda = tableView.dequeueReusableCell(withIdentifier: "celTCl", for: indexPath) as! Transportista_clienteTableViewCell
        
        //let nombreCategoria = arrayCategoria[indexPath.row]["Nombre"]
        let arrayCiudades =   ciudades[indexPath.row]
        celda.lblTClientes?.text = arrayCiudades
        return celda
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //let destino = segue.destination as! Transportista_ClienteViajesViewController
        
        //destino.idDeCliente =
    }
}

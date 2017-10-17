//
//  Transportista-ChoferesViewController.swift
//  EVA_Transporte_IOS
//
//  Created by Cesar Castro Arriaga on 27/09/17.
//  Copyright © 2017 EVA Transporte. All rights reserved.
//

import UIKit

class Transportista_ChoferesViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    
    @IBOutlet var tvChoferesLista: UITableView!
    
    var ciudades = ["Pedro","Barcelona","Tarragona","Lleida","Valencia","Málaga","Toledo"]
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tvChoferesLista.delegate = self
        self.tvChoferesLista.dataSource = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.ciudades.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let celda = tableView.dequeueReusableCell(withIdentifier: "celTC", for: indexPath) as! Transportista_choferTableViewCell
        
        //let nombreCategoria = arrayCategoria[indexPath.row]["Nombre"]
        let arrayCiudades =   ciudades[indexPath.row]
        celda.lblTC?.text = arrayCiudades
        return celda
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
    }
}

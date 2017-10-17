//
//  Chofer-ViajesViewController.swift
//  EVA_Transporte_IOS
//
//  Created by MAC 2 on 26/09/17.
//  Copyright © 2017 EVA Transporte. All rights reserved.
//

import UIKit

class Chofer_ViajesViewController: UIViewController,UITableViewDataSource,UITableViewDelegate{

    @IBOutlet weak var tvChoferes: UITableView!
    var ciudades = ["Madrid","Barcelona","Tarragona","Lleida","Valencia","Málaga","Toledo"]
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tvChoferes.dataSource = self
        self.tvChoferes.delegate = self
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
        
        let celda = tableView.dequeueReusableCell(withIdentifier: "celV", for: indexPath) as! Chofer_viajeTableViewCell
        
        //let nombreCategoria = arrayCategoria[indexPath.row]["Nombre"]
        let arrayCiudades =   ciudades[indexPath.row]
        celda.lblViaje?.text = arrayCiudades
        return celda
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
    }


}

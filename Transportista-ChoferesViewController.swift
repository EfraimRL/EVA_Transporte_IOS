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
    var nombre = ""//Nombre del usuario, chofer que esta en la app actualmente
    var nombreId = ""
    var item = [""] //Son los objetos que se enlistaran
    var itemId = [""]
    var choferId = "" //Viaje Seleccionado
    override func viewDidLoad() {
        super.viewDidLoad()
        let json = TraerJSON()
        let listaViajes = json.objJSON(url1: "http://...",tipo:"Transportista-chofer",vista:"lista",id:nombreId) as! Lista
        print("Lista ",listaViajes)
        let nombre = listaViajes.nombre
        print("Transportista ",nombre)
        self.item = listaViajes.item
        self.itemId = listaViajes.itemId
        self.tvChoferesLista.delegate = self
        self.tvChoferesLista.dataSource = self
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let celda = tableView.dequeueReusableCell(withIdentifier: "celTC", for: indexPath) as! Transportista_choferTableViewCell
        
        //let nombreCategoria = arrayCategoria[indexPath.row]["Nombre"]
        let chofer =   item[indexPath.row]
        celda.lblTC?.text = chofer
        return celda
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        choferId = itemId[indexPath.row]
        print("Selecciono el numero ",indexPath.row," Nombre ",item[indexPath.row])
        performSegue(withIdentifier: "segTChofer-Detalles", sender: nil)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.item.count
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destino  = segue.destination as! Transportista_DetallesDelChoferViewController
        destino.transportistaId = nombreId
        destino.choferId = choferId
    }
}

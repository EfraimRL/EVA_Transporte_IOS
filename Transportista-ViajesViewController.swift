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
    var nombre = ""//Nombre del usuario, chofer que esta en la app actualmente
    var nombreId = ""
    var item = [""] //Son los objetos que se enlistaran
    var itemId = [""]
    var ViajeId = "" //Viaje Seleccionado
    override func viewDidLoad() {
        super.viewDidLoad()
        let json = TraerJSON()
        let listaViajes = json.objJSON(url1: "http://...",tipo:"Transportista-Viajes",vista:"lista",id: nombreId) as! Lista
        print("Lista ",listaViajes)
        let nombre = listaViajes.nombre
        print("Transportista ",nombre)
        self.item = listaViajes.item
        self.itemId = listaViajes.itemId
        self.tvTransportistaViajesLista.dataSource = self
        self.tvTransportistaViajesLista.delegate = self
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let celda = tableView.dequeueReusableCell(withIdentifier: "celTV", for: indexPath) as! Transportista_viajeTableViewCell
        //let nombreCategoria = arrayCategoria[indexPath.row]["Nombre"]
        let viaje = item[indexPath.row]
        celda.lblTViaje?.text = viaje
        return celda
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        ViajeId = itemId[indexPath.row]
        print("Selecciono el numero ",indexPath.row," Nombre de viaje ",item[indexPath.row])
        performSegue(withIdentifier: "segTViaje-Detalles", sender: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.item.count
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destino  = segue.destination as! Transportista_DetallesDeViajeViewController
        destino.transportistaId = nombreId
        destino.viajeId = ViajeId
    }
}

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
    var arrayViajes = [AnyObject]()
    @IBOutlet weak var tvTClientesViajesLista: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        pagina = "customers.json"
        self.tvTClientesViajesLista.delegate = self
        self.tvTClientesViajesLista.dataSource = self
        Listar()
    }
    
    //Listar celda(por celda) de viaje
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let celda = tableView.dequeueReusableCell(withIdentifier: "celTCViajes", for: indexPath) as! Transportista_ClientesVajesTableViewCell
        celda.configureCell(ViajesCh: arrayViajes[indexPath.row] as! ViajesCh)
        return celda
    }
    
    //Al seleccionar celda, enviar a detalles
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let send = arrayViajes[indexPath.row]
        print("Selecciono el numero ",indexPath.row," de la lista, detalle de viaje ",arrayViajes[indexPath.row])
        performSegue(withIdentifier: , sender: send)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destino  = segue.destination as! Transportista_DetalleDeClienteViewController
        //si hay un objeto, se envia a la vista de detalles
        if let detalleSeleccionado = sender as? ViajesCh{
            print("Cliente ID: ", detalleSeleccionado.details)
            destino.objDetClienteViaje = detalleSeleccionado
        }
    }
    
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
    }
  
    
    
    //Otros
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

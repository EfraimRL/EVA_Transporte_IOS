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
        //Listar()
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
        performSegue(withIdentifier: "segTClienteViaje-Detalle", sender: send)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destino  = segue.destination as! Transportista_DetalleDeClienteViewController
        //si hay un objeto, se envia a la vista de detalles
        if let detalleSeleccionado = sender as? ViajesCh{
            print("Cliente ID_Viaje Detalle: ", detalleSeleccionado.details)
            destino.objDetViaje = detalleSeleccionado
        }
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.arrayViajes.count
    }

    
    /*Falta Modificar
    //Si hay o no registros como respuesta, muestra u oculta la Tabla (UITableView)
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if self.arrayClientes.count == 0{
            tvTClientesLista.isHidden = true
        }
        else{
            tvTClientesLista.isHidden = false
        }
        return self.arrayClientes.count
    }
    
    //Trae los datos y lo guarda en un arrayViajes [tipo ViajesCh]. Con ese array llena la tabla
    func Listar(){
        let dataSend = ["company_id": company_id, "driver_id": user_id] as [String:Any]
        print(dataSend)
        pagina = "drivers.json"
        Alamofire.request("\(localhost)\(pagina)",method: .post, parameters: dataSend, encoding: JSONEncoding(options: [])).responseJSON{ response in
            //print(response)
            if response.result.value != nil {
                let json = JSON(response.result.value!)
                print("Clientes: ",json)
                if json == JSON.null {
                    let result = json["message"]
                    alerta(titulo: "Error", mensaje: "No hay registros", cantidad_Botones: 1, estilo_controller: .alert, estilo_boton: .default, sender: self)
                    print("Mensaje traido de server (tipo json)",result)
                }
                else{
                    for (_,propDeCliente):(String,JSON) in json{
                        
                        let id = propDeCliente["id"].int!
                        let names = propDeCliente["names"].string!
                        let lastnames = propDeCliente["names"].string!
                        let address = propDeCliente["names"].string!
                        let city = propDeCliente["names"].string!
                        let state = propDeCliente["names"].string!
                        let country = propDeCliente["names"].string!
                        let region = propDeCliente["names"].string!
                        let cp = propDeCliente["names"].string!
                        let notes = propDeCliente["names"].string!
                        let tel = propDeCliente["names"].string!
                        let movil = propDeCliente["names"].string!
                        let schedule = propDeCliente["names"].string!
                        let active = propDeCliente["names"].string!
                        let company_id = propDeCliente["names"].string!
                        let user_id = propDeCliente["names"].string!
                        let created_at = propDeCliente["names"].string!
                        let updated_at = propDeCliente["names"].string!
                        let url = propDeCliente["names"].string!
                        
                        let Cliente = ClientFull(id: "\(id)", names: names, lastnames: lastnames, address: address, city: city, state: state, country: country, region: region, cp: cp, notes: notes, tel: tel, movil: movil, schedule: schedule, active: active, company_id: company_id, user_id: user_id, created_at: created_at, updated_at: updated_at, url: url)
                        
                        self.arrayClientes.append(Cliente)
                    }
                    self.tvTClientesLista.reloadData()
                }
            }
            else{
                print("No hubo resultados del servidor ")
            }
        }
        
    }
    */

  
    
    
    //Otros
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

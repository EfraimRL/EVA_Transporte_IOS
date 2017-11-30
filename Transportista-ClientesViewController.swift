//
//  Transportista-ClientesViewController.swift
//  EVA_Transporte_IOS
//
//  Created by Cesar Castro Arriaga on 27/09/17.
//  Copyright © 2017 EVA Transporte. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class Transportista_ClientesViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {

    @IBOutlet weak var viewDeTableCLientes: UIView!
    @IBOutlet var tvTClientesLista: UITableView!
    var aDonde = false
    var arrayClientes = [AnyObject]()
    override func viewDidLoad() {
        super.viewDidLoad()
        pagina = "drivers.json"
        self.tvTClientesLista.delegate = self
        self.tvTClientesLista.dataSource = self
        Listar()
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Actualizar",style: .done, target: self, action: #selector(Transportista_ClientesViewController.Listar) )
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Salir", style: UIBarButtonItemStyle.plain,target:self, action: #selector(salir))
    }
    //Salir
    func salir(){
        aDonde = false
        performSegue(withIdentifier: "segSalir", sender: nil)
    }
//Listar celda(por celda) de cliente
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let celda = tableView.dequeueReusableCell(withIdentifier: "celTCl", for: indexPath) as! Transportista_clienteTableViewCell
        celda.configureCell(ClientFull: arrayClientes[indexPath.row] as! ClientFull)
        return celda
    }
    
//Al seleccionar celda, enviar a detalles
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        aDonde = true
        let send = arrayClientes[indexPath.row]
        print("Selecciono el numero ",indexPath.row," de la lista, detalle de viaje ",arrayClientes[indexPath.row])
        performSegue(withIdentifier: "segTCliente-TCViajes", sender: send)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if  aDonde{
            let destino  = segue.destination as! Transportista_ClienteViajesViewController
            //si hay un objeto, se envia a la vista de detalles
            if let detalleSeleccionado = sender as? ClientFull{
                print("Cliente ID: ", detalleSeleccionado.id)
                destino.idDeCliente = detalleSeleccionado.id
            }
        }
    }
    
    @IBOutlet weak var imgVacio: UIImageView!
//Si hay o no registros como respuesta, muestra u oculta la Tabla (UITableView)
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if self.arrayClientes.count == 0{
            tvTClientesLista.isHidden = true
            viewDeTableCLientes.isHidden = true
            imgVacio.isHidden = false
        }
        else{
            tvTClientesLista.isHidden = false
            viewDeTableCLientes.isHidden = false
            imgVacio.isHidden = true
        }
        return self.arrayClientes.count
    }
    
//Trae los datos y lo guarda en un arrayViajes [tipo ViajesCh]. Con ese array llena la tabla
    func Listar(){
        arrayClientes.removeAll()
        self.tvTClientesLista.reloadData()
        let dataSend = ["company_id": company_id, "driver_id": user_id] as [String:Any]
        print("Clientes: ",dataSend)
        pagina = "customers.json"
        print("\(localhost)/\(pagina)")
        Alamofire.request("\(localhost)/\(pagina)", headers: user_headers).responseJSON{ response in
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
                    print(user_headers)
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
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

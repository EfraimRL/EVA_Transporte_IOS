//
//  Transportista-NotificacionesViewController.swift
//  EVA_Transporte_IOS
//
//  Created by MAC 2 on 11/10/17.
//  Copyright © 2017 EVA Transporte. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
class Transportista_NotificacionesViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var modalView: UIView!
    @IBOutlet weak var tvTNtificaciones: UITableView!
    @IBOutlet weak var viewDeTable: UIView!
    var arrayNotificaciones = [AnyObject]()
    override func viewDidLoad() {
        super.viewDidLoad()
        scrollView.isHidden = true
        scrollView.center.x = -600
        scrollView.layer.cornerRadius = 10
        scrollView.layer.masksToBounds = true
        modalTamaño()
        self.tvTNtificaciones.dataSource = self
        self.tvTNtificaciones.delegate = self
        Listar()
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Actualizar",style: .done, target: self, action: #selector(Transportista_NotificacionesViewController.Listar) )
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Salir", style: UIBarButtonItemStyle.plain,target:self, action: #selector(salir))
    }
//Salir
    func salir(){
        performSegue(withIdentifier: "segSalir", sender: nil)
    }
//Modal
    @IBOutlet weak var txtNombre: UILabel!
    @IBOutlet weak var txtCodigo: UILabel!
    @IBOutlet weak var txtCategoria: UILabel!
    @IBOutlet weak var txtProtocolo: UILabel!
    
    func modalTamaño(){
        scrollView.frame.size.height = viewDeTable.frame.size.height - 60
        scrollView.frame.size.width = viewDeTable.frame.size.width - 60
        
    }
    @IBOutlet weak var centerPopupModalX: NSLayoutConstraint!
    @IBOutlet weak var salirModal: UIButton!
    @IBAction func salirModalPopup(_ sender: Any) {
        UIView.animate(withDuration: 0.1, animations: {
            self.salirModal.alpha = 0
            self.scrollView.center.x = -600
        })
    }
//Seleccion de celda para mostrar el modal
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        scrollView.isHidden = false
        let notificacionDet = arrayNotificaciones[indexPath.row] as! Notification
        txtNombre.text = notificacionDet.name
        txtCodigo.text = notificacionDet.code
        txtCategoria.text = notificacionDet.grade
        txtProtocolo.text = notificacionDet.protocols
        UIView.animate(withDuration: 0.2, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0, options: .curveEaseOut, animations: {
            self.view.layoutIfNeeded()
            self.scrollView.center.x = self.viewDeTable.center.x
        }, completion: nil)
        
        UIView.animate(withDuration: 0.1, animations: {
            self.salirModal.alpha = 0.5
        })
    }
//Listar celda de viaje
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let celda = tableView.dequeueReusableCell(withIdentifier: "celTN", for: indexPath) as! Transportista_NotificacionesTableViewCell
        celda.configureCell(Notification: arrayNotificaciones[indexPath.row] as! Notification)
        //celda.lblTN?.text = arrayCiudades
        return celda
    }

//Si hay o no registros como respuesta, muestra la imagen por default
    @IBOutlet weak var imgVacio: UIImageView!
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if self.arrayNotificaciones.count == 0{
            tvTNtificaciones.isHidden = true
            viewDeTable.isHidden = true
            imgVacio.isHidden = false
        }
        else{
            tvTNtificaciones.isHidden = false
            viewDeTable.isHidden = false
            imgVacio.isHidden = true
        }
        return self.arrayNotificaciones.count
    }
//Traer datos (notificaciones)
    func Listar(){
        arrayNotificaciones.removeAll()
        self.tvTNtificaciones.reloadData()
        let dataSend = ["company_id": company_id, "driver_id": user_id] as [String:Any]
        print(dataSend)
        Alamofire.request("\(localhost)/states.json", headers: user_headers).responseJSON{ response in
            if response.result.value != nil {
                let json = JSON(response.result.value!)
                print(json)
                if json == JSON.null {
                    let result = json["message"]
                    print("Mensaje traido de server (json)",result)
                }
                else{
                    for (_,detDeNotificaciones):(String,JSON) in json{
                        
                        let name = detDeNotificaciones["name"].string!
                        var code = detDeNotificaciones["code"].string!
                        var grade = detDeNotificaciones["grade"].string!
                        var protocols = detDeNotificaciones["protocol"].string!

                        let Notificacion = Notification(code:code,protocols:protocols,grade:grade,name:name)
                        
                        self.arrayNotificaciones.append(Notificacion)
                    }
                    self.tvTNtificaciones.reloadData()
                }
            }
            else{print("No hubo resultados del servidor ")}
        }
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

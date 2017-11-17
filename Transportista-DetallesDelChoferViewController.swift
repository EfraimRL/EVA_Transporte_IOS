//
//  Transportista-DetallesDelChoferViewController.swift
//  EVA_Transporte_IOS
//
//  Created by Cesar Castro Arriaga on 28/09/17.
//  Copyright © 2017 EVA Transporte. All rights reserved.
//

import UIKit
import GoogleMaps
class Transportista_DetallesDelChoferViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {
    
    @IBOutlet weak var map: UIView!
    
    @IBOutlet var tvTChoferDetalles: UITableView!
    var objDetConductor:DriverFull?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tvTChoferDetalles.dataSource = self
        self.tvTChoferDetalles.delegate = self
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "",style: .plain, target: nil,action: nil)
        self.asd = view
        sacarDetalles()
        mostrarMapa()
    }
    
    //Seccion de Mapa
    @IBAction func btnMostrarMapa(_ sender: Any) {}
    
    var asd:Any = self
    var mapa:Any = self
//Mapa
    func mostrarMapa(){
        let lat1 = 27.509180
        let long1 = -99.561880
        let lat2 = 27.3
        let long2 = -99.3
        let camera = GMSCameraPosition.camera(withLatitude: lat1, longitude: long1, zoom: 6.0)
        let mapView = GMSMapView.map(withFrame: CGRect(x: 0, y: 0, width: 300, height: 300), camera: camera)
        mapView.isMyLocationEnabled = true
        mapView.settings.myLocationButton = true
        mapa = mapView
        
        let marker = GMSMarker()
        marker.position = CLLocationCoordinate2D(latitude: -33.86, longitude: 151.20)
        marker.title = "Sydney"
        marker.snippet = "Australia"
        marker.map = mapView
        
        //self.view = self.mapa as! UIView
        self.map.addSubview(self.mapa as! UIView)
    }
    func salirDelMapa() -> Void {
        print("salir del mapa")
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "",style: .done, target: self, action: #selector(Chofer_DetalleDeViajeViewController.salirDelMapa) )
        self.view = self.asd as! UIView
    }
//Definir valores de los detalles
    var detalles = [""]          //Key o nombre clave de cada campo
    var detallesMostrar = [""]   //(key)Nombre de campo, para mostrar
    var detalle = ["":""]        //Valor para cada key
    
    func sacarDetalles(){
        detalles = ["id","code","department","names","lastnames","rfc","hiredDate","created_at","updated_at","url"]
        detallesMostrar = ["ID","Còdigo","Departamento","Nombre(s)","Apellidos","RFC","Contratado en","Creado","Actualizado","URL"]
        
        detalle = [
            "id": "",
            "code": "",
            "department": "",
            "names": "",
            "lastnames": "",
            "rfc": "",
            "hiredDate": "",
            "created_at": "",
            "updated_at": "",
            "url": ""
            ]
        
        //print(objDetViaje!.details)
        detalle["id"] = "\(objDetConductor!.id)"
        detalle["code"] = objDetConductor?.code
        detalle["department"] = objDetConductor?.department
        detalle["names"] = objDetConductor?.names
        detalle["lastnames"] = objDetConductor?.lastnames
        detalle["rfc"] = objDetConductor?.rfc
        detalle["hiredDate"] = objDetConductor?.hiredDate
        detalle["created_at"] = objDetConductor?.created_at
        detalle["updated_at"] = objDetConductor?.updated_at
        detalle["url"] = objDetConductor?.url
        
    }
//Seccion de detalles
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.detalles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let celda = tableView.dequeueReusableCell(withIdentifier: "celTCD", for: indexPath) as! Transportista_DetallesDeChoferTableViewCell
        let value = detalle[detalles[indexPath.row]]!
        let key = detallesMostrar[indexPath.row]
        celda.lblKey?.text = "\(key):"
        celda.lblTCD?.text = value
        return celda
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

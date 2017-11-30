//
//  Transportista-DetallesDeViajeViewController.swift
//  EVA_Transporte_IOS
//
//  Created by Cesar Castro Arriaga on 28/09/17.
//  Copyright © 2017 EVA Transporte. All rights reserved.
//

import UIKit
import GoogleMaps
import Alamofire
import SwiftyJSON
class Transportista_DetallesDeViajeViewController: UIViewController,UITableViewDataSource,UITableViewDelegate{

    
    @IBOutlet weak var map: UIView!
    
    var transportistaId = ""
    var viajeId = ""
    @IBOutlet var tvTViajeDetalles: UITableView!
    var objDetViaje:ViajesCh?
    var direccion = false
    var ciudades = ["Detalle","Viaje","Desde Transportista"]
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tvTViajeDetalles.dataSource = self
        self.tvTViajeDetalles.delegate = self
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "",style: .plain, target: nil,action: nil)
        self.asd = view
        sacarDetalles()
        mostrarMapa()
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Salir",style: .done, target: self, action: #selector(seg) )
    }
    func seg(){
        direccion = true
        performSegue(withIdentifier: "salir1", sender: direccion)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
//Seccion de Mapa
    @IBAction func btnMostrarMapa(_ sender: Any) {
        mostrarMapa()
    }
    var asd:Any = self
    var mapa:Any = self
    func mostrarMapa(){
        
        //Mapa
        // Create a GMSCameraPosition that tells the map to display the
        // coordinate -33.86,151.20 at zoom level 6.
        let camera = GMSCameraPosition.camera(withLatitude: 27.509180, longitude: -99.561880, zoom: 4.0)
        let mapView = GMSMapView.map(withFrame: CGRect(x: 0, y: 0, width: map.frame.size.width, height: map.frame.size.height), camera: camera)
        //mapView.isMyLocationEnabled = true
        //mapView.settings.myLocationButton = true
        //mapView.center = self.view.center
        //self.view.addSubview(mapView)
        mapa = mapView
        map.addSubview(mapView)
        
        // Creates a marker in the center of the map.
        let marker = GMSMarker()
        marker.position = CLLocationCoordinate2D(latitude: 27.509180, longitude: -99.561880)
        marker.title = "Sydney"
        marker.snippet = "Australia"
        marker.map = mapView
        //navigationItem.rightBarButtonItem = UIBarButtonItem(title: "X",style: .done, target: self, action: #selector(Chofer_DetalleDeViajeViewController.salirDelMapa) )
        
        //self.view = self.mapa as! UIView
        
    }
    func salirDelMapa() -> Void {
        print("salir del mapa")
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "",style: .done, target: self, action: #selector(Chofer_DetalleDeViajeViewController.salirDelMapa) )
        self.view = self.asd as! UIView
    }
    
//Definir valores de los detalles
    var nombres = [""]          //Key o nombre clave de cada campo
    var nombresMostrar = [""]   //(key)Nombre de campo, para mostrar
    var nombre = ["":""]        //Valor para cada key
    
    func sacarDetalles(){
        nombres = ["id","hoursTraveled","hoursPlanned","idDestine","idrigen","created_at","details","company_id","driver_id","load_id","state_id","truck_id","kms","gpsReads","updated_at","mt_id","gpsDate","carrier_line_id","cost"]
        nombresMostrar = ["ID","horas viajadas","Horas planeadas","Destino","Origen","Creado","Detalle","Id Compañia","Id Conductor","Id Carga","Id de Estado","Id Troka","kms","GPS","Actualizado","Id MT","Fecha GPS","ID de linea","Costo"]
        
        nombre = [
            "id":"",
            "hoursTraveled":"",
            "hoursPlanned":"",
            "idDestine":"",
            "idrigen":"",
            "created_at":"",
            "details":"",
            "company_id":"",
            "driver_id":"",
            "load_id":"",
            "state_id":"",
            "truck_id":"",
            "kms":"",
            "gpsReads":"",
            "updated_at":"",
            "mt_id":"",
            "gpsDate":"",
            "carrier_line_id":"",
            "cost":""]
        
        print("efra",objDetViaje!.details)
        nombre["id"] = "\(objDetViaje!.id)"
        nombre["hoursTraveled"] = objDetViaje?.hoursTraveled
        nombre["hoursPlanned"] = objDetViaje?.hoursPlanned
        nombre["idDestine"] = objDetViaje?.idDestine
        nombre["idrigen"] = objDetViaje?.idOrigen
        nombre["created_at"] = objDetViaje?.created_at
        nombre["details"] = objDetViaje?.details
        nombre["company_id"] = "\(objDetViaje!.company_id)"
        nombre["driver_id"] = "\(objDetViaje!.driver_id)"
        nombre["state_id"] = "\(objDetViaje!.state_id)"
        nombre["truck_id"] = "\(objDetViaje!.truck_id)"
        nombre["kms"] = objDetViaje?.kms
        nombre["gpsReads"] = objDetViaje?.gpsReads
        nombre["updated_at"] = objDetViaje?.updated_at
        nombre["mt_id"]  = "\(objDetViaje!.mt_id)"
        nombre["gpsDate"] = objDetViaje?.gpsDate
        nombre["carrier_line_id"] = "\(objDetViaje!.carrier_line_id)"
        nombre["cost"] = "\(objDetViaje!.cost)"
        
    }
//Seccion de detalles
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.nombre.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let celda = tableView.dequeueReusableCell(withIdentifier: "celTVD", for: indexPath) as! Transportista_DetallesDeViajeTableViewCell
        let value = nombre[nombres[indexPath.row]]!
        let key = nombresMostrar[indexPath.row]
        celda.lblkey?.text = key
        celda.lblTVD?.text = value
        return celda
    }
}

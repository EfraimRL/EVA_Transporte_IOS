//
//  Proveedor_DetalleDeViajeViewController.swift
//  EVA_Transporte_IOS
//
//  Created by MAC 2 on 26/09/17.
//  Copyright © 2017 EVA Transporte. All rights reserved.
//

import UIKit
import GoogleMaps

class Proveedor_DetalleDeViajeViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {
    
    @IBOutlet weak var map: UIView!
    var clienteId = ""
    var viajeId = ""
    var objDetViaje:ViajesCh?
    var direccion = false
    @IBOutlet weak var tvProveedorViajeDetalles: UITableView!
    var nombres = ["id","hoursTraveled","hoursPlanned","idDestine","idrigen","created_at","details","company_id","driver_id","load_id","state_id","truck_id","kms","gpsReads","updated_at","mt_id","gpsDate","carrier_line_id","cost"]
    var nombre = [
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
    var detalle = [AnyObject]()
    var ciudades = ["Detalle","Destino","Origen","Telefono"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tvProveedorViajeDetalles.dataSource = self
        self.tvProveedorViajeDetalles.delegate = self
        sacarDetalles()
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "",style: .plain, target: nil,action: nil)
        self.asd = view
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
    func sacarDetalles(){
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
        let camera = GMSCameraPosition.camera(withLatitude: 27.509180, longitude: -99.561880, zoom: 6.0)
        let mapView = GMSMapView.map(withFrame: CGRect(x: 0, y: 0, width: map.frame.size.width, height: map.frame.size.height), camera: camera)
        mapView.isMyLocationEnabled = true
        //mapView.center = self.view.center
        //self.view.addSubview(mapView)
        mapa = mapView
        
        // Creates a marker in the center of the map.
        let marker = GMSMarker()
        marker.position = CLLocationCoordinate2D(latitude: 27.509180, longitude: -99.561880)
        marker.title = "Sydney"
        marker.snippet = "Australia"
        marker.map = mapView
        //navigationItem.rightBarButtonItem = UIBarButtonItem(title: "X",style: .done, target: self, action: #selector(Chofer_DetalleDeViajeViewController.salirDelMapa) )
        
        //self.view = self.mapa as! UIView
        map.addSubview(mapView)
        
    }
    func salirDelMapa() -> Void {
        print("salir del mapa")
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "",style: .done, target: self, action: #selector(Chofer_DetalleDeViajeViewController.salirDelMapa) )
        self.view = self.asd as! UIView
    }
    
//Seccion de detalles
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.nombre.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let celda = tableView.dequeueReusableCell(withIdentifier: "celPVD", for: indexPath) as! Proveedor_DetalleDeViajeTableViewCell
        let value = nombre[nombres[indexPath.row]]!
        let key = nombres[indexPath.row]
        celda.lblKey?.text = key
        celda.lblPDetalle?.text = value
        print("key:",key," value:",value)
        return celda
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
}

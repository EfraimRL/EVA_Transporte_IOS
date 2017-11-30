//
//  Transportista-DetalleDeClienteViewController.swift
//  EVA_Transporte_IOS
//
//  Created by Cesar Castro Arriaga on 28/09/17.
//  Copyright © 2017 EVA Transporte. All rights reserved.
//

import UIKit
import GoogleMaps
class Transportista_DetalleDeClienteViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {
    @IBOutlet weak var map: UIView!
    var direccion = false
    @IBOutlet var tvTClienteDetalles: UITableView!
    var objDetViaje:ViajesCh?

    override func viewDidLoad() {
        super.viewDidLoad()
        sacarDetalles()
        self.tvTClienteDetalles.dataSource = self
        self.tvTClienteDetalles.delegate = self
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "",style: .plain, target: nil,action: nil)
        self.asd = view
        mostrarMapa()
        //let rightAddBarButtonItem:UIBarButtonItem = UIBarButtonItem(title: "Add", style: UIBarButtonItemStyle.plain, target: self, action: #selector(Transportista_DetalleDeClienteViewController.addTapped))
        // 2
        //let rightSearchBarButtonItem:UIBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.search, target: self, action: #selector(Transportista_DetalleDeClienteViewController.searchTapped))
        // 3
        //self.navigationItem.setRightBarButtonItems([rightAddBarButtonItem,rightSearchBarButtonItem], animated: true)
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Salir",style: .done, target: self, action: #selector(seg) )
    }
    func seg(){
        direccion = true
        performSegue(withIdentifier: "salir1", sender: direccion)
    }
    
    // 4
    func searchTapped(sender:UIButton) {
        print("search pressed")
    }
    // 5
    func addTapped (sender:UIButton) {
        print("add pressed")
    }
//Seccion de Mapa
    @IBAction func btnMostrarMapa(_ sender: Any) {}
    var asd:Any = self
    var mapa:Any = self
    func mostrarMapa(){
        //Mapa
        // Create a GMSCameraPosition that tells the map to display the
        // coordinate -33.86,151.20 at zoom level 6.
        let camera = GMSCameraPosition.camera(withLatitude: 27.459180, longitude: -99.511880, zoom: 8.0)
        let mapView = GMSMapView.map(withFrame: CGRect(x: 0, y: 0, width: map.frame.size.width, height: map.frame.size.height), camera: camera)
        //mapView.isMyLocationEnabled = true
        //mapView.settings.myLocationButton = true
        
        
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
//Definir valores de los detalles
    var detalles = [""]          //Key o nombre clave de cada campo
    var detallesMostrar = [""]   //(key)Nombre de campo, para mostrar
    var detalle = ["":""]        //Valor para cada key
    
    func sacarDetalles(){
         detalles = ["id","hoursTraveled","hoursPlanned","idDestine","idrigen","created_at","details","company_id","driver_id","load_id","state_id","truck_id","kms","gpsReads","updated_at","mt_id","gpsDate","carrier_line_id","cost"]
         detalle = [
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
        detallesMostrar = ["ID","Horas Viajadas","Horas Planeadas","Destino","Origen","Creado","Detalles","Compañia","Conductor","Carga","Estado","Camion","KMs","GPS1","Actualizado","MT","GPS2","Linea","Costo"]
        
        
        //print(objDetViaje!.details)
        detalle["id"] = "\(objDetViaje!.id)"
        detalle["hoursTraveled"] = objDetViaje?.hoursTraveled
        detalle["hoursPlanned"] = objDetViaje?.hoursPlanned
        detalle["idDestine"] = objDetViaje?.idDestine
        detalle["idrigen"] = objDetViaje?.idOrigen
        detalle["created_at"] = objDetViaje?.created_at
        detalle["details"] = objDetViaje?.details
        detalle["company_id"] = "\(objDetViaje!.company_id)"
        detalle["driver_id"] = "\(objDetViaje!.driver_id)"
        detalle["state_id"] = "\(objDetViaje!.state_id)"
        detalle["truck_id"] = "\(objDetViaje!.truck_id)"
        detalle["kms"] = objDetViaje?.kms
        detalle["gpsReads"] = objDetViaje?.gpsReads
        detalle["updated_at"] = objDetViaje?.updated_at
        detalle["mt_id"]  = "\(objDetViaje!.mt_id)"
        detalle["gpsDate"] = objDetViaje?.gpsDate
        detalle["carrier_line_id"] = "\(objDetViaje!.carrier_line_id)"
        detalle["cost"] = "\(objDetViaje!.cost)"
        
        print(detalle["details"])
    }
//Seccion de detalles
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("Cantidad de detalles:",detallesMostrar.count)
        return self.detallesMostrar.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let celda = tableView.dequeueReusableCell(withIdentifier: "celTClD", for: indexPath) as! Transportista_DetallesDeClienteTableViewCell
        let value = detalle[detalles[indexPath.row]]!
        let key = detallesMostrar[indexPath.row]
        celda.lblKey?.text = key
        celda.lblTClD?.text = value
        return celda
    }
//Otros
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

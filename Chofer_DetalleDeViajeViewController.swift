//
//  Chofer_DetalleDeViajeViewController.swift
//  EVA_Transporte_IOS
//
//  Created by MAC 2 on 26/09/17.
//  Copyright © 2017 EVA Transporte. All rights reserved.
//

import UIKit
import GoogleMaps
import GooglePlaces

class Chofer_DetalleDeViajeViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {

    var ViajeId = ""
    var choferId = ""
    var objDetViaje:ViajesCh?
    @IBOutlet weak var viewMap: UIView!
    @IBOutlet weak var tvChoferViajeDetalles: UITableView!
//Datos para localizacion local
    var locationManager = CLLocationManager()
    var currentLocation: CLLocation?
    var mapView: GMSMapView!
    var placesClient: GMSPlacesClient!
    var zoomLevel: Float = 15.0
    var likelyPlaces: [GMSPlace] = []
    // The currently selected place.
    var selectedPlace: GMSPlace?
    
    @IBOutlet weak var lblEstado: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        sacarDetalles()
        /*
        locationManager = CLLocationManager()
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestAlwaysAuthorization()
        locationManager.distanceFilter = 50
        locationManager.startUpdatingLocation()
        locationManager.delegate = self as! CLLocationManagerDelegate
        
        placesClient = GMSPlacesClient.shared()
        */
        self.tvChoferViajeDetalles.dataSource = self
        self.tvChoferViajeDetalles.delegate = self
        
        let json = TraerJSON()
        let detallesJSON = json.objJSON(url1: "http://...",tipo:"Chofer",vista:"detalles",id:ViajeId) as! DetallesGeneral
        self.lblEstado.text = detallesJSON.estado.rawValue
        
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "",style: .plain, target: nil,action: nil)
        vistaPantallaTotal = view
        mostrarMapa()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destino  = segue.destination as! Chofer_NotificacionesViewController
        destino.choferId = choferId
    }
    
//Seccion de Mapa
    @IBOutlet weak var map: UIView!     //instancia del view donde se muestra el mapa pequeño
    var vistaPantallaTotal:Any = self
    var mapa:Any = self
    
    func mostrarMapa(){
        print(map.frame.size.width)
        let lat1 = 27.509180
        let long1 = -99.561880
        let lat2 = 27.3
        let long2 = -99.3
        //Mapa
    // Create a GMSCameraPosition that tells the map to display the
        // coordinate -33.86,151.20 at zoom level 6.
        let camera = GMSCameraPosition.camera(withLatitude: 27.509180, longitude: -99.561880, zoom: 6.0)
         mapView = GMSMapView.map(withFrame: CGRect(x: 0, y: 0, width:	viewMap.frame.size.width, height: viewMap.frame.size.height), camera: camera)
        mapView.isMyLocationEnabled = true
        mapView.settings.myLocationButton = true
        //mapView.center = self.view.center
        //self.view.addSubview(mapView)
        mapa = mapView
    //Dos o mas posiciones
        let vancouver = CLLocationCoordinate2D(latitude: lat1, longitude: long1)
        let calgary = CLLocationCoordinate2D(latitude: lat2,longitude: long2)
        let bounds = GMSCoordinateBounds(coordinate: vancouver, coordinate: calgary)
        let camera1 = mapView.camera(for: bounds, insets: UIEdgeInsets())!

        //mapView.camera = camera1
    // Creates a marker in the center of the map.
        let marker = GMSMarker()
        marker.position = CLLocationCoordinate2D(latitude: lat1, longitude: long1)
        marker.title = "Origen"
        marker.snippet = "Australia"
        marker.map = mapView
        let marker2 = GMSMarker()
        marker2.position = CLLocationCoordinate2D(latitude: lat2, longitude: long2)
        marker2.title = "Destino"
        marker2.snippet = "Destino"
        marker2.map = mapView
        //navigationItem.rightBarButtonItem = UIBarButtonItem(title: "X",style: .done, target: self, action: #selector(Chofer_DetalleDeViajeViewController.salirDelMapa) )
        self.map.addSubview(self.mapa as! UIView)
        //self.view = self.mapa as! UIView
        
    }
    func salirDelMapa() -> Void {
        print("salir del mapa")
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "",style: .done, target: self, action: #selector(Chofer_DetalleDeViajeViewController.salirDelMapa) )
        self.view = self.vistaPantallaTotal as! UIView
    }

//Definir valores de los detalles
    var nombres = [""]
    var nombre = ["":""]
    
    func sacarDetalles(){
        nombres = ["id","hoursTraveled","hoursPlanned","idDestine","idrigen","created_at","details","company_id","driver_id","load_id","state_id","truck_id","kms","gpsReads","updated_at","mt_id","gpsDate","carrier_line_id","cost"]
        //nombres = ["ID","horas viajadas","Horas planeadas","Destino","Origen","Creado","Detalle","Id Compañia","Id Conductor","Id Carga","Id de Estado","Id Troka","kms","GPS","Actualizado","Id MT","Fecha GPS","ID de linea","Costo"]
        
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

        print(objDetViaje?.details)
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
        return self.nombres.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let celda = tableView.dequeueReusableCell(withIdentifier: "celCVD", for: indexPath) as! Chofer_DetalleDeViajeTableViewCell
        //let nombreCategoria = arrayCategoria[indexPath.row]["Nombre"]
        let value = nombre[nombres[indexPath.row]]!
        let key = nombres[indexPath.row]
        celda.lblCVCampo?.text = "\(key):"
        celda.lblCVDetalle?.text = value
        return celda
    }
}


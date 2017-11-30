//
//  Proveedor_DetalleDeViajeViewController.swift
//  EVA_Transporte_IOS
//
//  Created by MAC 2 on 26/09/17.
//  Copyright © 2017 EVA Transporte. All rights reserved.
//

import UIKit
import GoogleMaps
import Alamofire
import SwiftyJSON
class Proveedor_DetalleDeViajeViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {
    
    @IBOutlet weak var map: UIView!
    var clienteId = ""
    var viajeId = ""
    var objDetViaje:ViajesCh?
    var direccion = false
    @IBOutlet weak var tvProveedorViajeDetalles: UITableView!
    var nombres = [""]
    var nombre = ["":""]
    var detalleDeNombre = [""]
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
        nombres = ["id","hoursTraveled","hoursPlanned","idDestine","idOrigen","created_at","details","company_id","driver_id","load_id","state_id","truck_id","kms","gpsReads","updated_at","mt_id","gpsDate","carrier_line_id","cost"]
        nombre = [
            "id":"",
            "hoursTraveled":"",
            "hoursPlanned":"",
            "idDestine":"",
            "idOrigen":"",
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
        detalleDeNombre = [
            "ID",
            "Horas viajadas",
            "Horas planeadas",
            "Destino",
            "Origen",
            "Creado",
            "Detalles",
            "ID compañia",
            "ID conductor",
            "ID carga",
            "ID de estado",
            "ID de camiòn",
            "KMS",
            "GPS1",
            "Actualizado",
            "ID MT",
            "GPS2(date)",
            "Linea Transp.",
            "Costo"]
        nombre["id"] = "\(objDetViaje!.id)"
        nombre["hoursTraveled"] = objDetViaje?.hoursTraveled
        nombre["hoursPlanned"] = objDetViaje?.hoursPlanned
        nombre["idDestine"] = objDetViaje?.idDestine
        nombre["idOrigen"] = objDetViaje?.idOrigen
        nombre["created_at"] = objDetViaje?.created_at
        nombre["details"] = objDetViaje?.details
        nombre["company_id"] = "\(objDetViaje!.company_id)"
        nombre["driver_id"] = "\(objDetViaje!.driver_id)"
        nombre["load_id"] = "\(objDetViaje!.load_id)"
        nombre["state_id"] = "\(objDetViaje!.state_id)"
        nombre["truck_id"] = "\(objDetViaje!.truck_id)"
        nombre["kms"] = objDetViaje?.kms
        nombre["gpsReads"] = objDetViaje?.gpsReads
        nombre["updated_at"] = objDetViaje?.updated_at
        nombre["mt_id"]  = "\(objDetViaje!.mt_id)"
        nombre["gpsDate"] = objDetViaje?.gpsDate
        nombre["carrier_line_id"] = "\(objDetViaje!.carrier_line_id)"
        nombre["cost"] = "\(objDetViaje!.cost)"
        for dato in nombre{
            
        }
    }
//Seccion de Mapa
    @IBAction func btnMostrarMapa(_ sender: Any) {
        mostrarMapa()
    }
    var asd:Any = self
    var mapa:Any = self
    
    /*
    func mostrarMapa(){
        
        //Mapa
        // Create a GMSCameraPosition that tells the map to display the
        // coordinate -33.86,151.20 at zoom level 6.
        let camera = GMSCameraPosition.camera(withLatitude: 27.509180, longitude: -99.561880, zoom: 6.0)
        let mapView = GMSMapView.map(withFrame: CGRect(x: 0, y: 0, width: map.frame.size.width, height: map.frame.size.height), camera: camera)
        mapView.isMyLocationEnabled = true
        mapView.settings.myLocationButton = true
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
    */
    var lat1 = 27.509180
    var long1 = -99.561880
    let lat2 = 27.3
    let long2 = -99.3
    var mapView: GMSMapView!
    func mostrarMapa(){
        // Create a GMSCameraPosition that tells the map to display the
        // coordinate -33.86,151.20 at zoom level 6.
        localizacion()
        var lat = lat1
        var long = long1
        let camera = GMSCameraPosition.camera(withLatitude: lat, longitude: long, zoom: 9.0)
        mapView = GMSMapView.map(withFrame: CGRect(x: 0, y: 0, width:	map.frame.size.width, height: map.frame.size.height), camera: camera)
        //mapView.settings.myLocationButton = true
        mapView.settings.compassButton = true
        //mapView.isMyLocationEnabled = true
        /*lat  = lat1  + abs((lat1  - Double(mapView.camera.target.latitude ))/2)
        print("LATITUD:",lat1,"-",mapView.camera.target.latitude)
        long = long1 + abs((long1 - Double(mapView.camera.target.longitude))/2)
        print("LONGITUD:",long1,"-",mapView.camera.target.longitude)
        print("CAMERA:",lat,",",long)
        */
        let cameraPosition = GMSCameraPosition.camera(withLatitude: lat,longitude: long,zoom: 9)
        mapView.camera = cameraPosition
        //mapView.moveCamera(GMSCameraUpdate.setTarget(<#T##target: CLLocationCoordinate2D##CLLocationCoordinate2D#>))
        //mapView.camera. = mapView.camera.target.latitude
        //mapView.center = self.view.center
        mapa = mapView
        //navigationItem.rightBarButtonItem = UIBarButtonItem(title: "X",style: .done, target: self, action: #selector(Chofer_DetalleDeViajeViewController.salirDelMapa) )
        self.map.addSubview(self.mapa as! UIView)
        //self.view = self.mapa as! UIView
        
    }
    func mostrarPosiciones(lat1:Double,long1:Double,lat2:Double,long2:Double){
        //Dos o mas posiciones
        let vancouver = CLLocationCoordinate2D(latitude: lat1, longitude: long1)
        let calgary = CLLocationCoordinate2D(latitude: lat2,longitude: long2)
        let bounds = GMSCoordinateBounds(coordinate: vancouver, coordinate: calgary)
        let camera1 = mapView.camera(for: bounds, insets: UIEdgeInsets())!
        mapView.camera = camera1
        // Creates a marker in the center of the map.
    }
    func mostrarMarker(lat1:Double,long1:Double,title:String,snippet:String){
        let marker = GMSMarker()
        marker.position = CLLocationCoordinate2D(latitude: lat1, longitude: long1)
        marker.title = title
        marker.snippet = snippet
        marker.map = mapView
    }
    func salirDelMapa() -> Void {
        print("salir del mapa")
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "",style: .done, target: self, action: #selector(Chofer_DetalleDeViajeViewController.salirDelMapa) )
        self.view = self.asd as! UIView
    }
//Localizaciòn del mapa, trae las localizaciones desde el Web Service
    func localizacion(){
        Alamofire.request("\(localhost)/locations.json", headers: user_headers).responseJSON{ response in
            print(response)
            if response.result.value != nil {
                let json = JSON(response.result.value!)
                print(json)
                if json["message"] != JSON.null {
                    let result = json["message"].string!
                    print("Nulo: ",result)
                    _ = LocalNotification.Notificaciones(with: "Error", body: result, at: Date().addedBy(seconds: 0), sender: self)
                }
                else{
                    for (_,detDeNotificaciones):(String,JSON) in json{
                        
                        
                        let title = detDeNotificaciones["address"].string!
                        let snippet = detDeNotificaciones["name"].string!
                        let coordenadas = detDeNotificaciones["coordinates"].string!
                        print(coordenadas)
                        let arrCoordinates : [String] = coordenadas.components(separatedBy: ",")
                        
                        self.lat1 = Double(arrCoordinates[0].trimmingCharacters(in: .whitespaces))!
                        self.long1 = arrCoordinates.count > 1 ? Double(arrCoordinates[1].trimmingCharacters(in: .whitespaces))! : 0
                        //Pone el marcador en el mapa
                        self.mostrarMarker(lat1: self.lat1, long1: self.long1, title: title, snippet:  snippet)
                    }
                    
                    //Agrega localizacion
                    
                }
            }
            else{
                alerta(titulo: "Error", mensaje: "No hubo resultados del servidor o no hay conexiòn", cantidad_Botones: 1, estilo_controller: UIAlertControllerStyle.alert, estilo_boton: UIAlertActionStyle.default, sender: self)
                print("No hay respuesta del Web Service")
            }
        }
    }
//Seccion de detalles
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.nombre.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let celda = tableView.dequeueReusableCell(withIdentifier: "celPVD", for: indexPath) as! Proveedor_DetalleDeViajeTableViewCell
        let value = nombre[nombres[indexPath.row]]!
        let key = detalleDeNombre[indexPath.row]
        celda.lblKey?.text = key
        celda.lblPDetalle?.text = value
        print("key:",key," value:",value)
        return celda
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
}

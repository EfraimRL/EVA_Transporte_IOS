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
import Alamofire
import SwiftyJSON

class Chofer_DetalleDeViajeViewController: UIViewController,UITableViewDataSource,UITableViewDelegate,GMSMapViewDelegate,CLLocationManagerDelegate {

    var ViajeId = ""
    var choferId = ""
    var objDetViaje:ViajesCh?
    @IBOutlet weak var viewMap: UIView!
    @IBOutlet weak var tvChoferViajeDetalles: UITableView!
    //Localizaciones
    var arrLocalizaciones: [Mapas] = []
    var arrLocation:[CLLocation] = []
//Datos para localizacion local
    var locationManager = CLLocationManager()
    var currentLocation: CLLocation?
    var mapView: GMSMapView!
    var placesClient: GMSPlacesClient!
    var zoomLevel: Float = 15.0
    var likelyPlaces: [GMSPlace] = []
// The currently selected place.
    var selectedPlace: GMSPlace?
    var direccion = false
    
    @IBOutlet weak var lblEstado: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        sacarDetalles()
        
        locationManager = CLLocationManager()
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestAlwaysAuthorization()
        locationManager.startUpdatingLocation()
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.distanceFilter = 50
        locationManager.delegate = self as? CLLocationManagerDelegate
        locationManager.startMonitoringSignificantLocationChanges()
        
        //placesClient = GMSPlacesClient.shared()
        
        self.tvChoferViajeDetalles.dataSource = self
        self.tvChoferViajeDetalles.delegate = self
        /*
        let json = TraerJSON()
        let detallesJSON = json.objJSON(url1: "http://...",tipo:"Chofer",vista:"detalles",id:ViajeId) as! DetallesGeneral
        //self.lblEstado.text = detallesJSON.estado.rawValue*/
        switch objDetViaje!.state_id {
        case 0:
            self.lblEstado.text = "Estado: Detenido"
        case 1:
            self.lblEstado.text = "Estado: En espera"
        case 2: self.lblEstado.text = "Estado: En curso"
            default: self.lblEstado.text = "Estado: Indefinido"
        }
        //self.lblEstado.text = "\(objDetViaje!.state_id)"
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "",style: .plain, target: nil,action: nil)
        vistaPantallaTotal = view
        mostrarMapa()
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Salir",style: .done, target: self, action: #selector(seg) )
    }
    func seg(){
        direccion = true
        performSegue(withIdentifier: "salir1", sender: direccion)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if direccion {
            
        }
        else{
            let destino  = segue.destination as! Chofer_NotificacionesViewController
            destino.choferId = (objDetViaje?.driver_id)!
        }
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

        print(objDetViaje!.details)
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
        let key = nombresMostrar[indexPath.row]
        celda.lblCVCampo?.text = "\(key):"
        celda.lblCVDetalle?.text = value
        return celda
    }
//Seccion de Mapa
    var lat1 = 27.509180
    var long1 = -99.561880
    let lat2 = 27.3
    let long2 = -99.3
    @IBOutlet weak var map: UIView!     //instancia del view donde se muestra el mapa pequeño
    var vistaPantallaTotal:Any = self
    var mapa:Any = self
    
    func mostrarMapa(){
        // Create a GMSCameraPosition that tells the map to display the
        // coordinate -33.86,151.20 at zoom level 6.
        localizacion()
        var lat = lat1
        var long = long1
        let camera = GMSCameraPosition.camera(withLatitude: lat, longitude: long, zoom: 9.0)
        mapView = GMSMapView.map(withFrame: CGRect(x: 0, y: 0, width:	viewMap.frame.size.width, height: viewMap.frame.size.height), camera: camera)
        mapView.settings.myLocationButton = true
        mapView.settings.compassButton = true
        mapView.isMyLocationEnabled = true
        lat  = lat1  + abs((lat1  - Double(mapView.camera.target.latitude ))/2)
        print("LATITUD:",lat1,"-",mapView.camera.target.latitude)
        long = long1 + abs((long1 - Double(mapView.camera.target.longitude))/2)
        print("LONGITUD:",long1,"-",mapView.camera.target.longitude)
        print("CAMERA:",lat,",",long)
        let cameraPosition = GMSCameraPosition.camera(withLatitude: lat,
                                                      longitude: long,
                                                      zoom: 9)
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
    //Borrar
    func salirDelMapa() -> Void {
        print("salir del mapa")
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "",style: .done, target: self, action: #selector(Chofer_DetalleDeViajeViewController.salirDelMapa) )
        self.view = self.vistaPantallaTotal as! UIView
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
                        self.arrLocalizaciones.append(Mapas(latitude:self.lat1,longitude:self.long1,name:title,details:snippet))
                        self.arrLocation.append(CLLocation(latitude:self.lat1,longitude:self.long1))
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
    func drawPath(startLocation:CLLocation,endLocation:CLLocation) -> Void {
        let origin = "\(startLocation.coordinate.latitude),\(startLocation.coordinate.longitude)"
        let destination = "\(endLocation.coordinate.latitude),\(endLocation.coordinate.longitude)"
        
        let url = "https://maps.googleapis.com/maps/api/directions/json?origin=\(origin)&destination=\(destination)&mode=driving"
        Alamofire.request(url).responseJSON{ response in
            print(response.request as Any)
            print(response.response as Any)
            print(response.data as Any)
            print(response.result as Any)
            
            let json = JSON(data: response.data!)
            let routes = json["routes"].arrayValue
            
            for route in routes{
                let routeOverviewPolyline = route["overview_polyline"].dictionary
                let points = routeOverviewPolyline?["points"]?.stringValue
                let path = GMSPath.init(fromEncodedPath:points!)
                let polyline = GMSPolyline.init(path: path)
                polyline.strokeWidth = 4
                polyline.strokeColor = UIColor.red
                polyline.map = self.mapView
            }
        }
    }
//Locaition manager
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Error al coseguir la localizaciòn: ",error)
    }
    //Manda a dibujar la linea entre la localizaciòn actual y la de destino
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location = locations.last
        let newLocation:CLLocation
        if arrLocation.count > 0 {
            newLocation = arrLocation.last!
            if location != nil {
                drawPath(startLocation: location!, endLocation: newLocation)
            }
        }else{print(arrLocation.count)}
    }
}


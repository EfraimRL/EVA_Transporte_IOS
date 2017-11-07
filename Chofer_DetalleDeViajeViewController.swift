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

    var detalles = [""]
    var campos = [""]
    var ViajeId = ""
    var choferId = ""
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
        self.campos = detallesJSON.CampoNombre
        self.detalles = detallesJSON.CampoValor
        self.lblEstado.text = detallesJSON.estado.rawValue
        
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "",style: .plain, target: nil,action: nil)
        asd = view
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
    var asd:Any = self
    var mapa:Any = self
    @IBAction func MostrarMapa(_ sender: Any) {
        mostrarMapa()
    }
    func mostrarMapa(){
        let lat1 = 27.509180
        let long1 = -99.561880
        let lat2 = 27.3
        let long2 = -99.3
        //Mapa
        // Create a GMSCameraPosition that tells the map to display the
        // coordinate -33.86,151.20 at zoom level 6.
        let camera = GMSCameraPosition.camera(withLatitude: 27.509180, longitude: -99.561880, zoom: 6.0)
         mapView = GMSMapView.map(withFrame: CGRect(x: 0, y: 0, width: 300, height: 300), camera: camera)
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
        
    //
        
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
        
        self.view = self.mapa as! UIView
        
    }
    func salirDelMapa() -> Void {
        print("salir del mapa")
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "",style: .done, target: self, action: #selector(Chofer_DetalleDeViajeViewController.salirDelMapa) )
        self.view = self.asd as! UIView
    }
//Seccion de detalles
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.detalles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let celda = tableView.dequeueReusableCell(withIdentifier: "celCVD", for: indexPath) as! Chofer_DetalleDeViajeTableViewCell
        
        //let nombreCategoria = arrayCategoria[indexPath.row]["Nombre"]
        let detalle =   detalles[indexPath.row]
        celda.lblCVDetalle?.text = detalle
        let campo =     campos[indexPath.row]
        celda.lblCVCampo?.text = "\(campo) : "
        return celda
    }
    
}


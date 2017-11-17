//
//  Transportista-DetallesDeViajeViewController.swift
//  EVA_Transporte_IOS
//
//  Created by Cesar Castro Arriaga on 28/09/17.
//  Copyright © 2017 EVA Transporte. All rights reserved.
//

import UIKit
import GoogleMaps
class Transportista_DetallesDeViajeViewController: UIViewController,UITableViewDataSource,UITableViewDelegate{

    
    @IBOutlet weak var map: UIView!
    
    var transportistaId = ""
    var viajeId = ""
    @IBOutlet var tvTViajeDetalles: UITableView!
    var objDetViaje:ViajesCh?
    
    var ciudades = ["Detalle","Viaje","Desde Transportista"]
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tvTViajeDetalles.dataSource = self
        self.tvTViajeDetalles.delegate = self
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "",style: .plain, target: nil,action: nil)
        self.asd = view
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
        let camera = GMSCameraPosition.camera(withLatitude: 27.509180, longitude: -99.561880, zoom: 6.0)
        let mapView = GMSMapView.map(withFrame: CGRect(x: 0, y: 0, width: 300, height: 300), camera: camera)
        mapView.isMyLocationEnabled = true
        //mapView.center = self.view.center
        //self.view.addSubview(mapView)
        mapa = mapView
        
        // Creates a marker in the center of the map.
        let marker = GMSMarker()
        marker.position = CLLocationCoordinate2D(latitude: -33.86, longitude: 151.20)
        marker.title = "Sydney"
        marker.snippet = "Australia"
        marker.map = mapView
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
        return self.ciudades.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let celda = tableView.dequeueReusableCell(withIdentifier: "celTVD", for: indexPath) as! Transportista_DetallesDeViajeTableViewCell
        let arrayCiudades =   ciudades[indexPath.row]
        celda.lblTVD?.text = arrayCiudades
        return celda
    }
}

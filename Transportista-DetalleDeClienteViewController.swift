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

    @IBOutlet var tvTClienteDetalles: UITableView!
    var objDetClienteViaje:ViajesCh?

    override func viewDidLoad() {
        super.viewDidLoad()
        self.tvTClienteDetalles.dataSource = self
        self.tvTClienteDetalles.delegate = self
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "",style: .plain, target: nil,action: nil)
        self.asd = view
        sacarDetalles()
        mostrarMapa()
    }
    
//Seccion de Mapa
    @IBAction func btnMostrarMapa(_ sender: Any) {}
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
//Definir valores de los detalles
    var detalles = [""]          //Key o nombre clave de cada campo
    var detallesMostrar = [""]   //(key)Nombre de campo, para mostrar
    var detalle = ["":""]        //Valor para cada key
    
    func sacarDetalles(){
        detalles = ["id","names","lastnames","address","city","state","country","region","cp","notes","tel","movil","schedule","active","company_id","user_id","created_at","updated_at","url"]
        detallesMostrar = []
        
        detalle = [
            "id":"",
            "names":"",
            "lastnames":"",
            "address":"",
            "city":"",
            "state":"",
            "country":"",
            "region":"",
            "cp":"",
            "notes":"",
            "tel":"",
            "movil":"",
            "schedule":"",
            "active":"",
            "company_id":"",
            "user_id":"",
            "created_at":"",
            "updated_at":"",
            "url":""]
        
        //print(objDetViaje!.details)
        detalle["id"] = "\(objDetViaje!.id)"
        detalle["names"] = objDetViaje?.names.string
        detalle["lastnames"] = objDetViaje?.lastnames
        detalle["address"] = objDetViaje?.address
        detalle["city"] = objDetViaje?.city
        detalle["state"] = objDetViaje?.state
        detalle["country"] = objDetViaje?.country
        detalle["region"] = objDetViaje?.region
        detalle["cp"] = objDetViaje?.cp
        detalle["notes"] = objDetViaje?.notes
        detalle["tel"] = objDetViaje?.tel
        detalle["movil"] = objDetViaje?.movil
        detalle["schedule"] = objDetViaje?.schedule
        detalle["active"] = objDetViaje?.active
        detalle["company_id"] = objDetViaje?.company_id
        detalle["user_id"] = objDetViaje?.user_id
        detalle["created_at"] = objDetViaje?.created_at
        detalle["updated_at"] = objDetViaje?.updated_at
        detalle["url"] = objDetViaje?.url
    }
//Seccion de detalles
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.detalles.count
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

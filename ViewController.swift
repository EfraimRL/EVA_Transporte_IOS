//
//  ViewController.swift
//  EVA_Transporte_IOS
//
//  Created by MAC 2 on 26/09/17.
//  Copyright © 2017 EVA Transporte. All rights reserved.
//

import UIKit
import UserNotifications
import GoogleMaps
import Alamofire
import SwiftyJSON

class ViewController: UIViewController,UNUserNotificationCenterDelegate,UITableViewDelegate,UITableViewDataSource {

    
    func notificaciones(){
        //-*Para notificaciones
        let notification = UILocalNotification()
        notification.fireDate = NSDate(timeIntervalSinceNow: 5) as Date
        notification.alertBody = "Hey you! Yeah you! Swipe to unlock!"
        notification.alertAction = "be awesome!"
        notification.soundName = UILocalNotificationDefaultSoundName
        UIApplication.shared.scheduleLocalNotification(notification)
        
        let notification1 = UILocalNotification()
        notification1.fireDate = NSDate(timeIntervalSinceNow: 15) as Date
        notification1.alertBody = "Hey you! Yeah you! Swipe to unlock!"
        notification1.alertAction = "be awesome!"
        notification1.soundName = UILocalNotificationDefaultSoundName
        
        UIApplication.shared.scheduleLocalNotification(notification1)
        //*-
    }
    
    /*Variables temporales
    let Us1 = "Chofer"
    let Us2 = "Cliente"
    let Us3 = "Transp"
    let Ps1 = "123"
    let Ps2 = "456"
    let Ps3 = "789"
    */
    var segue = "segChofer"
    //Variables para la conexion y login
    let login_url = "http://localhost:3000/users/sign_in"
    
    @IBOutlet weak var btnsalirModal: UIButton!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var tvImagenes: UITableView!
    @IBOutlet var txtUser: UITextField!
    @IBOutlet var txtPass: UITextField!
    @IBAction func btnIngresar(_ sender: Any) {
        //login_now(email:txtUser.text!, password: txtPass.text!)
        //validarUsuario()
        //Ingresar()
        Listar()
        self.tvImagenes.delegate = self
        self.tvImagenes.dataSource = self
    }
    @available(iOS 10.0, *)
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        
        completionHandler([.alert, .sound])
    }
    var login_session:String = ""
    
    @IBAction func abrirModal(_ sender: Any) {
        UIView.animate(withDuration: 0.2, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0, options: .curveEaseOut, animations: {
            self.view.layoutIfNeeded()
            self.tvImagenes.center.x = self.scrollView.center.x
        }, completion: nil)
        
        UIView.animate(withDuration: 0.1, animations: {
            self.btnsalirModal.alpha = 0.5
        })
    }
    @IBAction func salirModal(_ sender: Any) {
        UIView.animate(withDuration: 0.1, animations: {
            self.tvImagenes.center.x = -600
            self.btnsalirModal.alpha = 0
        })
    }
    func validarUsuario(){
        var segueV = ""
        
        if txtUser.text == "" || txtPass.text == ""{
            
            _ = LocalNotification.Notificaciones(with: "Falta campo", body: "Debe contener correo y password", at: Date().addedBy(seconds: 3), sender: self)
        }
        if txtUser.text == "efraruiz94@hotmail.com"{segueV = "segTransportista"}
        else if txtUser.text == "cliente@hotmail.com"{segueV = "segCliente"}
        else if txtUser.text == "conductor@hotmail.com"{segueV = "segChofer"}
        self.performSegue(withIdentifier: segueV, sender: nil)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        let preferences = UserDefaults.standard
        if preferences.object(forKey: "session") != nil
        {
            login_session = preferences.object(forKey: "session") as! String
            //check_session()
        }
        else
        {
            //LoginToDo()
        }
        navigationItem.hidesBackButton = true
        if navigationItem.backBarButtonItem?.isEnabled == true{
            navigationItem.backBarButtonItem?.isEnabled = false
        }
    }
    override func viewDidAppear(_ animated: Bool) {
        navigationItem.hidesBackButton = true
        if navigationItem.backBarButtonItem?.isEnabled == true{
            navigationItem.backBarButtonItem?.isEnabled = false
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
    }
    /*
    //Login----------------------------------------------------------------------
     
     let checksession_url = "http://www.kaleidosblog.com/tutorial/login/api/CheckSession"
    func login_now(email:String, password:String)
    {
        let post_data: NSDictionary = NSMutableDictionary()
        
        
        post_data.setValue(email, forKey: "email")
        post_data.setValue(password, forKey: "password")
        
        let url:URL = URL(string: login_url)!
        let session = URLSession.shared
        
        let request = NSMutableURLRequest(url: url)
        request.httpMethod = "POST"
        request.cachePolicy = NSURLRequest.CachePolicy.reloadIgnoringCacheData
        
        var paramString = ""
        
        
        for (key, value) in post_data
        {
            paramString = paramString + (key as! String) + "=" + (value as! String) + "&"
        }
        
        request.httpBody = paramString.data(using: String.Encoding.utf8)
        
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let _:Data = data, let _:URLResponse = response  , error == nil else {
                
                return
            }
            
            let json: Any?
            
            do
            {
                json = try JSONSerialization.jsonObject(with: data!, options: [])
            }
            catch
            {
                return
            }
            
            guard let server_response = json as? NSDictionary else
            {
                return
            }
            
            
            //if let data_block = server_response["data"] as? NSDictionary
            //{
            //= data_block
            print(server_response["email"]!)
                if let session_data = server_response["email"] as? String
                {
                    self.login_session = session_data
                    
                    let preferences = UserDefaults.standard
                    preferences.set(session_data, forKey: "session")
                    
                    DispatchQueue.main.async(execute: self.LoginDone)
                }
            //}
        }
        task.resume()
    }
    func LoginDone()
    {
        txtUser.isEnabled = false
        txtPass.isEnabled = false
        let alertController = UIAlertController(title: NSLocalizedString("No network connection",comment:""), message: NSLocalizedString("connected to the internet to use this app.",comment:""), preferredStyle: .alert)
        let defaultAction = UIAlertAction(title:     NSLocalizedString("Ok", comment: ""), style: .default, handler: { (pAlert) in
            //Do whatever you wants here
        })
        alertController.addAction(defaultAction)
        self.present(alertController, animated: true, completion: nil)
        //login_button.isEnabled = true
        
        
        //login_button.setTitle("Logout", for: .normal)
    }
    
    func LoginToDo()
    {
        txtUser.isEnabled = true
        txtPass.isEnabled = true
        
        //login_button.isEnabled = true
        
        
        //login_button.setTitle("Login", for: .normal)
    }
    */
    /*@available(iOS 10.0, *)
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        
        completionHandler([.alert, .sound])
    }*/
    
    
    var email:String = ""
    var password:String = ""
    /*
    func Ingresar(){
        email = txtUser.text!
        password = txtPass.text!
        print("user:",email,". Pass:",password)
        //preparar datos para poner en formato json
        let dict = ["session":["email": "\(email)", "password": "\(password)"]] as [String:Any]
        //especificar la ruta de el ws
        let urlLogin = "http://localhost:3000/users/sign_in"
        
        
        //convertir los datos a formato json
        if let jsonData = try? JSONSerialization.data(withJSONObject: dict, options: []){
            
            //especificas como se va a enviar (ruta,metodo,headers)
            let url_login = NSURL(string: urlLogin)!
            let request:NSMutableURLRequest = NSMutableURLRequest(url: url_login as URL)
            request.httpMethod = "POST"
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            request.httpBody = jsonData
            print("JSON DATA",jsonData)
            print("REQUEST ",request)
            //hacer la conexion
            let task = URLSession.shared.dataTask(with: request as URLRequest){data,response,error in
                
                //verificar si no hay error en la conexion
                if error != nil{
                    print(error!.localizedDescription)
                    return
                }
                
                do {
                    let json = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers) as! [String:Any]
                    
                    
                    
                    if json["id"] == nil {
                        //si hay error que el usuario se equivoco de correo o contraseña, que tome el parametro de mensaje del json e imprimirlo
                        let result:String = json["message"] as! String
                        print(result)
                        print(json)
                    }else{
                        //se inicia sesion y tomas los parametros de json que necesites y haces las acciones que necesites (como pasar de pantalla)
                        let result:Int = json["id"] as! Int
                        print(result)
                        print(json)
                        
                        
                        
                    }
                    
                    
                    
                } catch let error as NSError{
                    //error no encontro datos(creo)
                    print(error)
                }
            }
            // ejecutas la conexion
            task.resume()
        }
    }
    */
    func Listar(){
        LocalNotification.registerForLocalNotification(on: UIApplication.shared)
        email = txtUser.text!
        password = txtPass.text!
        let dataSend = ["email": txtUser.text!, "password": txtPass.text!] as [String:Any]
        print(dataSend)
        if email == "" || password == "" {
            //LocalNotification.dispatchlocalNotification(with: "Notification Title for iOS10+", body: "This is the notification body, works on all versions", at: Date().addedBy(seconds: 2))
            _ = LocalNotification.Notificaciones(with: "Falta campo(s)", body: "Correo y contraseña no pueden faltar", at: Date().addedBy(seconds: 0), sender: self)
            
            alerta(titulo: "Falta campo(s)", mensaje: "Correo y contraseña no pueden estar vacios", cantidad_Botones: 1, estilo_controller: .alert, estilo_boton: .default, sender: self)
        }
        else{
            Alamofire.request("\(localhost)users/sign_in.json",method: .post, parameters: dataSend, encoding: JSONEncoding(options: [])).responseJSON{ response in
            print(response)
            var segueV:String=""
            if response.result.value != nil {
                let json = JSON(response.result.value!)
                print(json)
                if json["message"] != JSON.null {
                    let result = json["message"].string!
                    print("Nulo: ",result)
                    _ = LocalNotification.Notificaciones(with: "Error", body: result, at: Date().addedBy(seconds: 0), sender: self)
                }
                else{
                    
                    user_id = json["id"].int!
                    user_email = json["email"].string!
                    user_token = json["authentication_token"].string!
                    
                    user_headers = [
                        "X-User-Email":user_email,
                        "Content-Type":"application/json",
                        "X-User-Token":user_token]
                    if json["rol"] == "Transportista"{segueV = "segTransportista"}
                    else if json["rol"] == "Cliente"{segueV = "segCliente"}
                    else if json["rol"] == "Conductor"{segueV = "segChofer"}
                    print(json["company_id"])
                    company_id = json["company_id"].int!
                    self.performSegue(withIdentifier: segueV, sender: nil)
                }
            }
            else{
                alerta(titulo: "Error", mensaje: "No hubo resultados del servidor o no hay conexiòn", cantidad_Botones: 1, estilo_controller: UIAlertControllerStyle.alert, estilo_boton: UIAlertActionStyle.default, sender: self)
                print("No hay respuesta del Web Service")
            }
        }
        }
    }
    @IBAction func llenar(_ sender: Any) {
        let opcion = txtUser.text
        switch opcion {
        case "conductor@hotmail.com"?: txtUser.text = "cliente@hotmail.com"
        case "cliente@hotmail.com"?: txtUser.text = "efraruiz94@hotmail.com"
        case "efraruiz94@hotmail.com"?: txtUser.text = "conductor@hotmail.com"
        default:
            txtUser.text = "conductor@hotmail.com"
        }
        txtPass.text = "123456"
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrDerechos.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let celda = tableView.dequeueReusableCell(withIdentifier: "celV", for: indexPath)
        celda.textLabel?.text = arrDerechos[indexPath.row]
        return celda
    }
    
}


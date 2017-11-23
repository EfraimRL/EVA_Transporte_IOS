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

class ViewController: UIViewController,UNUserNotificationCenterDelegate {

    
    func notificaciones(){
        //-*Para notificaciones
        if #available(iOS 10.0, *) {
            UNUserNotificationCenter.current().delegate = self
        
            let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 1, repeats: false)
            let content = UNMutableNotificationContent()
            content.title = "Error"
            content.subtitle = "Usuario o contraseña incorrectos"
            content.body = "Trate de nuevo"
            content.sound = UNNotificationSound.default()
            let request = UNNotificationRequest(identifier: "ZeldaNotification", content: content, trigger: trigger)
        
            UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
            UNUserNotificationCenter.current().add(request) {(error) in
                if let error = error {
                    print("Se ha producido un error: \(error)")
                }
            }
        } else {
            // Fallback on earlier versions
        }
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
    
    @IBOutlet var txtUser: UITextField!
    @IBOutlet var txtPass: UITextField!
    @IBAction func btnIngresar(_ sender: Any) {
        //login_now(email:txtUser.text!, password: txtPass.text!)
        //validarUsuario()
        //Ingresar()
        otroIntento()
    }
    
    var login_session:String = ""
    
    func validarUsuario(){
        segue = ""
        if txtUser.text == "" || txtPass.text == ""{
            //Alert: No deje campos vacios
            notificaciones()
        }
        /*
        else{
            if txtUser.text == Us1 {
                if txtPass.text == Ps1 {
                    segue = "segChofer"
                    performSegue(withIdentifier: segue, sender: nil)                }else{notificaciones()}
            }
            else if txtUser.text == Us3 {
                if txtPass.text == Ps3 {
                    segue = "segTransportista"
                    performSegue(withIdentifier: segue, sender: nil)                }else{notificaciones()}
            }
            else if txtUser.text == Us2{
                if txtPass.text == Ps2 {
                    segue = "segCliente"
                    performSegue(withIdentifier: segue, sender: nil)                }else{notificaciones()}
            }
            else{notificaciones()}
        }
        */
        
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
    @available(iOS 10.0, *)
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        
        completionHandler([.alert, .sound])
    }
    
    
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
    func otroIntento(){
        validarUsuario()
        email = txtUser.text!
        password = txtPass.text!
        let dataSend = ["email": txtUser.text!, "password": txtPass.text!] as [String:Any]
        print(dataSend)
        Alamofire.request("http://localhost:3000/users/sign_in.json",method: .post, parameters: dataSend, encoding: JSONEncoding(options: [])).responseJSON{ response in
            print(response)
            var segueV:String=""
            if response.result.value != nil {
                let json = JSON(response.result.value!)
                print(json)
                if json == JSON.null {
                    let result = json["message"]
                    print("Nulo: ",result)
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
    
}


//
//  File.swift
//  EVA_Transporte_IOS
//
//  Created by MAC 2 on 07/11/17.
//  Copyright © 2017 EVA Transporte. All rights reserved.
//

import Foundation
import UserNotifications
import UIKit
import Alamofire
import SwiftyJSON
//Variables y funciones globales
var company_id = 0
var user_id = 0
var user_token = ""
var user_email = ""

var user_headers: HTTPHeaders =  [String:AnyObject]() as! HTTPHeaders
    //Variables de conexion

var localhost = "http://localhost:3000/"
var pagina = ""
@available(iOS 10.0, *)
func notificaciones(delegate:UNUserNotificationCenterDelegate){
    //-*Para notificaciones
    UNUserNotificationCenter.current().delegate = delegate
    //*-
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
    
}

func alerta(titulo:String,mensaje:String,cantidad_Botones:Int,estilo_controller:UIAlertControllerStyle,estilo_boton:UIAlertActionStyle, sender: UIViewController) {
    // create the alert
    let alert = UIAlertController(title: titulo, message: mensaje, preferredStyle: estilo_controller)
    
    // add an action (button)
    alert.addAction(UIAlertAction(title: "OK", style: estilo_boton, handler: nil))
    if cantidad_Botones == 1 {
        
    }
    else {
        alert.addAction(UIAlertAction(title: "Cancelar", style: estilo_boton, handler: nil))
    }
    // show the alert
    sender.present(alert, animated: true, completion: nil)
}

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

var localhost = "http://192.168.15.117:3000/"
var pagina = ""
func notificaciones(delegate:UIViewController){
    /*
    if #available(iOS 10.0, *) {
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
    }*/
    if #available(iOS 10.0, *) {
        //iOS 10 or above version
        UNUserNotificationCenter.current().delegate = delegate as? UNUserNotificationCenterDelegate
        let center = UNUserNotificationCenter.current()
        let content = UNMutableNotificationContent()
        content.title = "Late wake up call"
        content.body = "The early bird catches the worm, but the second mouse gets the cheese."
        content.categoryIdentifier = "alarm"
        content.userInfo = ["customData": "fizzbuzz"]
        content.sound = UNNotificationSound.default()
        
        var dateComponents = DateComponents()
        dateComponents.hour = 15
        dateComponents.minute = 49
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
        
        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
        center.add(request)
    } else {
        // ios 9
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

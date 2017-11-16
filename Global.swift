//
//  File.swift
//  EVA_Transporte_IOS
//
//  Created by MAC 2 on 07/11/17.
//  Copyright © 2017 EVA Transporte. All rights reserved.
//

import Foundation
import UserNotifications
//Variables globales
var company_id = 0

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

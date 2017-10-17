//
//  ViewController.swift
//  EVA_Transporte_IOS
//
//  Created by MAC 2 on 26/09/17.
//  Copyright © 2017 EVA Transporte. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    let Us1 = "Chofer"
    let Us2 = "Cliente"
    let Us3 = "Transp"
    let Ps1 = "123"
    let Ps2 = "456"
    let Ps3 = "789"
    var segue = "segChofer"
    @IBOutlet var txtUser: UITextField!
    @IBOutlet var txtPass: UITextField!
    @IBAction func btnIngresar(_ sender: Any) {
        //1Aqui ira un metodo, valida si usuario y pass son correctos
        segue = ""
        if txtUser.text == "" || txtPass.text == ""{
            //Alert: No deje campos vacios
        }
        else{
            if txtUser.text == Us1 {
                if txtPass.text == Ps1 {
                    segue = "segChofer"
                    performSegue(withIdentifier: segue, sender: nil)                }
            }
            if txtUser.text == Us3 {
                if txtPass.text == Ps3 {
                    segue = "segTransportista"
                    performSegue(withIdentifier: segue, sender: nil)                }
            }
            if txtUser.text == Us2{
                if txtPass.text == Ps2 {
                    segue = "segCliente"
                    performSegue(withIdentifier: segue, sender: nil)                }
            }
        }
        //1Hasta aqui
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
    }
}


//
//  ViewController_TableViewCell.swift
//  EVA_Transporte_IOS
//
//  Created by MAC 2 on 30/11/17.
//  Copyright © 2017 EVA Transporte. All rights reserved.
//

import UIKit

class ViewController_TableViewCell: UITableViewCell {

    @IBOutlet weak var txtIconoNOMBRE: UILabel!
    @IBOutlet weak var txtIconoCreador: UILabel!
    @IBOutlet weak var txtIconoLink: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    func Asignar(nombre:String,enlace:String,licencia:String){
        txtIconoNOMBRE.text = "Icono hecho por  '\(nombre)':"
        txtIconoCreador.text = enlace
        txtIconoLink.text = licencia
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

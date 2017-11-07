//
//  Chofer-viajeTableViewCell.swift
//  EVA_Transporte_IOS
//
//  Created by MAC 2 on 26/09/17.
//  Copyright © 2017 EVA Transporte. All rights reserved.
//

import UIKit

class Chofer_viajeTableViewCell: UITableViewCell {

    
    @IBOutlet weak var lblViaje: UILabel!
    func configureCell(listaDeObjetos: listaDeObjetos){
        lblViaje.text = listaDeObjetos.nombre
    }
    var choferId = "0001"
    var telefono = "1234567"
    var viajeId = "Test"
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

   
}

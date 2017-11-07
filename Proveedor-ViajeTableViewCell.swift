//
//  Proveedor-ViajeTableViewCell.swift
//  EVA_Transporte_IOS
//
//  Created by MAC 2 on 26/09/17.
//  Copyright © 2017 EVA Transporte. All rights reserved.
//

import UIKit

class Proveedor_ViajeTableViewCell: UITableViewCell {

    @IBOutlet weak var lblPViaje: UILabel!
    func configureCell(listaDeObjetos: listaDeObjetos){
        lblPViaje.text = listaDeObjetos.nombre
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

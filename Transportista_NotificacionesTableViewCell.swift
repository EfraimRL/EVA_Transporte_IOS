//
//  Transportista_NotificacionesTableViewCell.swift
//  EVA_Transporte_IOS
//
//  Created by MAC 2 on 11/10/17.
//  Copyright © 2017 EVA Transporte. All rights reserved.
//

import UIKit

class Transportista_NotificacionesTableViewCell: UITableViewCell {

    
    @IBOutlet weak var lblTNKEY1: UILabel!
    @IBOutlet weak var lblTNDetalle: UILabel!
    var ciudades = ["Detalle","Cliente","Telefono"]
    func configureCell(Notification: Notification){
        lblTNKEY1.text = Notification.code
        lblTNDetalle.text = Notification.description
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

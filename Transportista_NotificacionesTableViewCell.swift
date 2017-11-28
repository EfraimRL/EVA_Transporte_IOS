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
        lblTNKEY1.text = Notification.name
        lblTNDetalle.text = Notification.grade
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        lblTNKEY1.layer.cornerRadius = 10
        lblTNKEY1.layer.masksToBounds = true
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

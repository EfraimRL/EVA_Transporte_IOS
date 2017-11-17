//
//  Transportista-ClientesVajesTableViewCell.swift
//  EVA_Transporte_IOS
//
//  Created by MAC 2 on 11/10/17.
//  Copyright © 2017 EVA Transporte. All rights reserved.
//

import UIKit

class Transportista_ClientesVajesTableViewCell: UITableViewCell {

    @IBOutlet weak var lblTClienteViajes: UILabel!
    func configureCell(ViajesCh: ViajesCh){
        lblTClienteViajes.text = ViajesCh.details
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

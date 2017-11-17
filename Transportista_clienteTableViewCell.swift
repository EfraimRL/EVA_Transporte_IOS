//
//  Transportista_clienteTableViewCell.swift
//  EVA_Transporte_IOS
//
//  Created by Cesar Castro Arriaga on 27/09/17.
//  Copyright © 2017 EVA Transporte. All rights reserved.
//

import UIKit

class Transportista_clienteTableViewCell: UITableViewCell {

    @IBOutlet var lblTClientes: UILabel!
    
    func configureCell(ClientFull: ClientFull){
        lblTClientes.text = ClientFull.names
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

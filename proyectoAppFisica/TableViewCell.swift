//
//  TableViewCell.swift
//  proyectoAppFisica
//
//  Created by alumno on 12/11/16.
//  Copyright © 2016 ITESM. All rights reserved.
//

import UIKit

class TableViewCell: UITableViewCell {

    @IBOutlet weak var lbPosicion: UILabel!
    @IBOutlet weak var lbVelocidad: UILabel!
    @IBOutlet weak var lbAceleracion: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

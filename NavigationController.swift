//
//  NavigationController.swift
//  proyectoAppFisica
//
//  Created by alumno on 03/11/16.
//  Copyright © 2016 ITESM. All rights reserved.
//

import UIKit

class NavigationController: UINavigationController {
    // MARK: -- Variables
    var arrDiccionario : NSMutableArray!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let siguienteVista = topViewController as! TableViewControllerDatos
        
        // Se pasa el diccionario recibido de controlador inicial hacia el de celdas
        siguienteVista.arrDiccionarios = arrDiccionario
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

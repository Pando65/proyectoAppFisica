//
//  NavigationController.swift
//  proyectoAppFisica
//
//  Created by alumno on 03/11/16.
//  Copyright © 2016 ITESM. All rights reserved.
//

import UIKit

class NavigationController: UINavigationController {

    var arrDiccionario : NSMutableArray!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let siguienteVista = topViewController as! TableViewControllerDatos
        siguienteVista.arrDiccionarios = arrDiccionario
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

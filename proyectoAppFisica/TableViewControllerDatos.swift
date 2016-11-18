//
//  TableViewControllerDatos.swift
//  proyectoAppFisica
//
//  Created by Carolina Romo on 11/2/16.
//  Copyright © 2016 ITESM. All rights reserved.
//

import UIKit

class TableViewControllerDatos: UITableViewController {
    // MARK: -- Variables
    var arrDiccionarios : NSArray!

    // MARK: -- Outlets
    @IBOutlet weak var btBack: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // Las celdas se contienen dentro de sola una seccion
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // La cantidad de celdas seran la cantidad de grupos de elementos en el 
        // diccionario
        return arrDiccionarios.count
    }

    /*
     * Se hace una poblacion del contenido en las celdas segun los datos que
     * contienen almacenado el arreglo de diccionarios con un formato de dos decimales
     */
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> TableViewCell {
        let cell = tableView.dequeueReusableCell(  withIdentifier: "celda", for: indexPath) as! TableViewCell
        
        let diccionario = arrDiccionarios[indexPath.row] as! NSDictionary
        
        let pos = diccionario.value(forKey: "posicion") as! Double
        let vel = diccionario.value(forKey: "velocidad") as! Double
        let ace = diccionario.value(forKey: "aceleracion") as! Double
        
        cell.lbPosicion.text = String(format: "%.2f", pos)
        cell.lbVelocidad.text = String(format: "%.2f", vel)
        cell.lbAceleracion.text = String(format: "%.2f", ace)
        
        return cell
    }
    
    // MARK: - Navigation

    /* Al regregesar a la pantalla de inicio, si se regresa oprimiendo alguna de las
     * celdas, se hace la configuracion para enviar los nuevos valores seleccionados
     * por el usuario
     */
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Si la transicion de regreso se esta causando por presionar una celda
        if sender as? UIBarButtonItem != btBack {
            let vista = segue.destination as! ViewControllerInicial
            let indice = tableView.indexPathForSelectedRow
            
            // Se obtiene el diccionario con los datos de la celda seleccionada
            let diccionario = arrDiccionarios[((indice as NSIndexPath?)?.row)!] as! NSDictionary
            
            let pos = diccionario.value(forKey: "posicion") as! Double
            let vel = diccionario.value(forKey: "velocidad") as! Double
            let ace = diccionario.value(forKey: "aceleracion") as! Double
            
            // Se modifican los valores de los campos de texto de la pantalla inicial
            vista.tfPosicionInicial.text = String(pos)
            vista.slPosicion.value = Float(pos)
            vista.tfVelocidad.text = String(vel)
            vista.tfAceleracion.text = String(ace)
        }
    }

}

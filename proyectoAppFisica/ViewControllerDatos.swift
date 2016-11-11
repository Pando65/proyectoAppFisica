//A00815248 - Omar Manjarrez
//A01195995 - David Delgadillo
//A01036134 - Carolina Romo

import UIKit

class ViewControllerDatos: UIViewController , UITableViewDelegate , UITableViewDataSource {
    
    @IBOutlet weak var btRegresar: UIBarButtonItem!
    @IBOutlet weak var tabla: UITableView!
    
    
    var tablaVelocidad : [Float] = []
    var tablaPosicion :  [Float] = []
    var tablaAceleracion : [Float] = []
    
    var datoPosicion : Float!
    var datoVelocidad : Float!
    var datoAceleracion : Float!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        
        tablaPosicion.append(datoPosicion)
        tablaVelocidad.append(datoVelocidad)
        tablaAceleracion.append(datoAceleracion)
        
        print("imprime tabla pos")
        for _ in tablaPosicion {
            print(tablaPosicion)
        }
        print("imprime tabla vel")
        for _ in tablaVelocidad {
            print(tablaVelocidad)
        }
        print("imprime tabla acel")
        for _ in tablaAceleracion {
            print(tablaAceleracion)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: - Métodos de Data Source de Table View
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(  withIdentifier: "idCell", for: indexPath)
        print("bofo")
        print(String(tablaPosicion[(indexPath as NSIndexPath).row]))
        cell.textLabel?.text = String(tablaPosicion[(indexPath as NSIndexPath).row])
        //cell.textLabel?.text = String(tablaVelocidad[(indexPath as NSIndexPath).row])
        //cell.textLabel?.text = String(tablaAceleracion[(indexPath as NSIndexPath).row])
        //cell.detailTextLabel?.text = "\((indexPath as NSIndexPath).row)"
        return cell
    }

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }

}

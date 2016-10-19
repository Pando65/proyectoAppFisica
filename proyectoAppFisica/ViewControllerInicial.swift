//A00815248 - Omar Manjarrez
//A01195995 - David Delgadillo
//A01036134 - Carolina Romo

import UIKit

class ViewControllerInicial: UIViewController {

    @IBOutlet weak var tfPosicionInicial: UITextField!
    @IBOutlet weak var slPosicion: UISlider!
    @IBOutlet weak var tfVelocidad: UITextField!
    @IBOutlet weak var tfAceleracion: UITextField!
    @IBOutlet weak var btConfiguracion: UIButton!
    @IBOutlet weak var btDatosRecientes: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    


    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    
    @IBAction func unwindGraficas(_ sender : UIStoryboardSegue) {
    }
    
    @IBAction func unwindConfiguracionRegresar(_ sender : UIStoryboardSegue) {
    }
    
    @IBAction func unwindConfiguracionGuardar(_ sender : UIStoryboardSegue) {
    }
    
    @IBAction func unwindDatosRecientesRegresar(_ sender : UIStoryboardSegue) {
        
    }
    
    @IBAction func unwindDatosRecientesSeleccionar(_ sender : UIStoryboardSegue) {
        
    }

}

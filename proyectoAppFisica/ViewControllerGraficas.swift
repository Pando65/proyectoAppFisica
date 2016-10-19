//A00815248 - Omar Manjarrez
//A01195995 - David Delgadillo
//A01036134 - Carolina Romo

import UIKit

class ViewControllerGraficas: UIViewController {

    // MARK: - Outlets
    @IBOutlet weak var btRegresar: UIBarButtonItem!
    @IBOutlet weak var lbTiempo: UILabel!
    @IBOutlet weak var lbPosicionInicial: UILabel!
    @IBOutlet weak var lbVelocidad: UILabel!
    @IBOutlet weak var lbAceleracion: UILabel!
    @IBOutlet weak var stCambiaUbicacion: UIStepper!
    
    // MARK: - Atributos de la clase
    var posInicial = 0.0
    var velocidad = 0.0
    var aceleracion = 0.0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        lbTiempo.text = "0.0 s"
        lbPosicionInicial.text = "\(String(posInicial)) m"
        lbVelocidad.text = "\(String(velocidad)) m/s"
        lbAceleracion.text = "\(String(posInicial)) m/s2"
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



}

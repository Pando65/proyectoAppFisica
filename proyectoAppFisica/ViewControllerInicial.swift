//A00815248 - Omar Manjarrez
//A01195995 - David Delgadillo
//A01036134 - Carolina Romo

import UIKit

class ViewControllerInicial: UIViewController {

    var arrArreglos : NSArray!
    
    // MARK: - Outlets
    @IBOutlet weak var tfPosicionInicial: UITextField!
    @IBOutlet weak var slPosicion: UISlider!
    @IBOutlet weak var tfVelocidad: UITextField!
    @IBOutlet weak var tfAceleracion: UITextField!
    @IBOutlet weak var btConfiguracion: UIButton!
    @IBOutlet weak var btDatosRecientes: UIButton!
    @IBOutlet weak var imSeleccionada: UIImageView!
    
    var imagenSeleccionada : UIImage!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        tfPosicionInicial.isEnabled = false
        tfPosicionInicial.text = String(slPosicion.value)
        
        let path = Bundle.main.path(forResource: "Property List", ofType: "plist")
        arrArreglos = NSArray(contentsOfFile: path!)
        
        let objSeleccionado = arrArreglos[0] as AnyObject
        
        switch objSeleccionado[0] as! NSNumber {
        case 0:
            imSeleccionada.image = UIImage(named: "Carrito")
        case 1:
            imSeleccionada.image = UIImage(named: "perrito")
        case 2:
            imSeleccionada.image = UIImage(named: "persona")
        default:
            imSeleccionada.image = UIImage(named: "Carrito")
        }
        
        // Para esconder el teclado al tocar el fondo
        let tap = UITapGestureRecognizer(target: self, action: #selector(ViewControllerInicial.quitaTeclado))
        view.addGestureRecognizer(tap)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Actions
    @IBAction func asignarPosInicial(_ sender: UISlider) {
        slPosicion.value = round(slPosicion.value)
        tfPosicionInicial.text = String(slPosicion.value)
    }
    

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        if (Double(tfVelocidad.text!) == nil || Double(tfAceleracion.text!) == nil) && identifier == "graficar" {
            let alerta = UIAlertController(title: "Error en los datos",
                                           message: "Todos los campos deben tener valor numerico",
                                           preferredStyle: .alert)
            
            alerta.addAction(UIAlertAction(title: "OK", style: .cancel,
                                           handler: nil))
            
            present(alerta, animated: true, completion: nil)
            
            return false
        }
        
        return true
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "graficar" {
            let desteny = segue.destination as! ViewControllerGraficas
            desteny.posInicial  = Double(slPosicion.value)
            desteny.velocidadInicial = Double(tfVelocidad.text!)!
            desteny.aceleracion = Double(tfAceleracion.text!)!
            desteny.imagen = imSeleccionada.image
        }
        if segue.identifier == "datos" {
            let vistaDatos = segue.destination as! ViewControllerDatos
            vistaDatos.datoPosicion = Float(tfPosicionInicial.text!)
            vistaDatos.datoVelocidad = Float(tfVelocidad.text!)
            vistaDatos.datoAceleracion = Float(tfAceleracion.text!)
        }
        if segue.identifier == "configurar" {
            let vistaConfiguracion = segue.destination as! ViewControllerConfiguracion
            vistaConfiguracion.imagenIni = imSeleccionada.image
        }
    }
    
    @IBAction func unwindGraficas(_ sender : UIStoryboardSegue) {
    }
    
    @IBAction func unwindConfiguracionGuardar(_ sender : UIStoryboardSegue) {
        imSeleccionada.image = imagenSeleccionada
    }
    
    @IBAction func unwindDatosRecientesSeleccionar(_ sender : UIStoryboardSegue) {
        
    }
    
    //MARK: -- Funciones
    func quitaTeclado() {
        view.endEditing(true)
    }

}

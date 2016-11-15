//A00815248 - Omar Manjarrez
//A01195995 - David Delgadillo
//A01036134 - Carolina Romo

import UIKit

// Extension de string para poder verificar si una cadena de caracteres se puede castear a decimal. Se utiliza en los campos de texto para validar datos correctos
extension String {
    var doubleValue: Double? {
        return Double(self)
    }
}

class ViewControllerInicial: UIViewController, UITextFieldDelegate {

    var idImagen = 0
    var arrArreglos : NSArray!
    var arrDiccionario : NSMutableArray! = [["posicion":0.0, "velocidad":0.0, "aceleracion":0.0]]
    
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
        let app = UIApplication.shared
        
        NotificationCenter.default.addObserver(self, selector: #selector(aplicacionTerminara(notificacion:)), name: .UIApplicationDidEnterBackground, object: app)

        tfVelocidad.delegate = self
        tfAceleracion.delegate = self
        
        tfPosicionInicial.isEnabled = false
        tfPosicionInicial.text = String(slPosicion.value)
        
        // Cargar datos de archivo
        let filePath = dataFilePath()
        if FileManager.default.fileExists(atPath: filePath)
        {
            arrArreglos = NSArray(contentsOfFile: filePath)

            
            // lectura de la imagen seleccionada guardada
            let objSeleccionado = Int(arrArreglos![0] as! NSNumber)
            
            switch objSeleccionado {
                case 0:
                    imSeleccionada.image = UIImage(named: "Carrito")
                    idImagen = 0
                case 1:
                    imSeleccionada.image = UIImage(named: "perrito")
                    idImagen = 1
                case 2:
                    imSeleccionada.image = UIImage(named: "persona")
                    idImagen = 2
                default:
                    imSeleccionada.image = UIImage(named: "Carrito")
                    idImagen = 0
            }
            
            // lectura del arreglo de diccionarios con los datos recientes
            arrDiccionario = arrArreglos[1] as! NSMutableArray
       }
        else {
            imSeleccionada.image = UIImage(named: "Carrito")
            idImagen = 0
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
            let destiny = segue.destination as! ViewControllerGraficas
            destiny.posInicial  = Double(slPosicion.value)
            destiny.velocidadInicial = Double(tfVelocidad.text!)!
            destiny.aceleracion = Double(tfAceleracion.text!)!
            destiny.imagen = imSeleccionada.image
            
            // Se verifica que el grupo de datos a insertar no es repetido
            if insertarEnDiccionario(pos: destiny.posInicial, vel: destiny.velocidadInicial, ace: destiny.aceleracion) {
                let diccionario = ["posicion": destiny.posInicial, "velocidad": destiny.velocidadInicial, "aceleracion": destiny.aceleracion]
            
                arrDiccionario.insert(diccionario, at: 0)
            
                // Solo se manejan hasta 10 datos recientes
                if arrDiccionario.count > 10 {
                    arrDiccionario.removeLastObject()
                }
            }
        }
        if segue.identifier == "datos" {
            let vistaDatos = segue.destination as! NavigationController
            vistaDatos.arrDiccionario = arrDiccionario
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

    func insertarEnDiccionario(pos: Double, vel: Double, ace: Double) -> Bool {
        for i in 0...arrDiccionario.count - 1 {
            let dicc = arrDiccionario[i] as! NSDictionary
            
            if dicc["posicion"] as! Double == pos {
                if dicc["velocidad"] as! Double == vel {
                    if dicc["aceleracion"] as! Double == ace {
                        // Se repiten datos
                        return false
                    }
                }
            }
        }
        // No se repite ninguno
        return true
    }
    
    func aplicacionTerminara(notificacion: NSNotification) {
        // Lo que se hace antes de cerrar la aplicacion
        let arreglo: NSMutableArray = []
        
        if idImagen == 0 {
            arreglo.addObjects(from: [0, arrDiccionario])
        }
        else if idImagen == 1 {
            arreglo.addObjects(from: [1, arrDiccionario])
        }
        else {
            arreglo.addObjects(from: [2, arrDiccionario])
        }
        arreglo.write(toFile: dataFilePath(), atomically: true)
        
    }
    
    func dataFilePath() -> String {
        let paths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
        
        let documentsDirectory = paths[0]
        
        return documentsDirectory.appending("/archiPrueba2.plist")
    }
    
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let newString = NSString(string: textField.text!).replacingCharacters(in: range, with: string)
        
        if let value = newString.doubleValue  {
            return true
        }
        else if newString == "." || newString == "-" || newString == "-." {
            return true
        }
        else {
            return false
        }
    }
}

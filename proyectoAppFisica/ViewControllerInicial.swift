//A00815248 - Omar Manjarrez
//A01195995 - David Delgadillo
//A01036134 - Carolina Romo

import UIKit

class ViewControllerInicial: UIViewController {

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
            let desteny = segue.destination as! ViewControllerGraficas
            desteny.posInicial  = Double(slPosicion.value)
            desteny.velocidadInicial = Double(tfVelocidad.text!)!
            desteny.aceleracion = Double(tfAceleracion.text!)!
            desteny.imagen = imSeleccionada.image
            
            let diccionario = ["posicion": desteny.posInicial, "velocidad": desteny.velocidadInicial, "aceleracion": desteny.aceleracion]
            
            arrDiccionario.insert(diccionario, at: 0)
            
            // Solo se manejan hasta 10 datos recientes
            if arrDiccionario.count > 10 {
                arrDiccionario.removeLastObject()
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

    func aplicacionTerminara(notificacion: NSNotification) {
        // Lo que se hace antes de cerrar la aplicacion
        let arreglo: NSMutableArray = []
        let img = imSeleccionada.image! as UIImage
        
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
}

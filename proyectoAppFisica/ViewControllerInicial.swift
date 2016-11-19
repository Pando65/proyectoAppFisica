//A00815248 - Omar Manjarrez
//A01195995 - David Delgadillo
//A01036134 - Carolina Romo

import UIKit

// Extension de string para poder verificar si una cadena de caracteres se puede
// castear a decimal. Se utiliza en los campos de texto para validar datos correctos
extension String {
    var doubleValue: Double? {
        return Double(self)
    }
}

class ViewControllerInicial: UIViewController, UITextFieldDelegate {

    // MARK: - Variables globales
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
        
        // Se indica la funcion a ejecutar antes de cerrar la aplicacion
        NotificationCenter.default.addObserver(self, selector: #selector(aplicacionTerminara(notificacion:)), name: .UIApplicationDidEnterBackground, object: app)

        // Se relacionan los campos de texto de aceleracion y velocidad con el delegado
        tfVelocidad.delegate = self
        tfAceleracion.delegate = self
        
        // Campo de texto de posicion inicial no puede ser modificado por el usuario
        tfPosicionInicial.isEnabled = false
        tfPosicionInicial.text = String(slPosicion.value)
        
        // Cargar datos de archivo
        let filePath = dataFilePath()
        if FileManager.default.fileExists(atPath: filePath) {
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
    /*
     * Funcion que se invoca al mover el slider donde se redondea el valor a un entero para simular
     * el movimiento sobre la barra en posiciones segmentadas de valores discretos enteros.
     * Un cambio en el valor implica tambien actualizar el valor en el campo de texto.
     */
    @IBAction func asignarPosInicial(_ sender: UISlider) {
        slPosicion.value = round(slPosicion.value)
        tfPosicionInicial.text = String(slPosicion.value)
    }

    // MARK: - Navigation

    /*
     * Se verifica que, en caso de que sea una transicion hacia las pantallas de las graficas, los 
     * campos de texto de velocidad y aceleracion tenga un valor valido. De no ser asi, se cancela
     * la invocacion al segue y se despliega una alerta.
     */
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
    
    /*
     * Se identifica la pantalla a la que se va a transitar y en base a ello se realizan algunas
     * configuraciones iniciales de los atributos de la clase a la que se invoca.
     */
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "graficar" {
            // Se transita a la pantalla de graficos y se mandan los valores ingresados por el usario
            let destiny = segue.destination as! ViewControllerGraficas
            destiny.posInicial  = Double(slPosicion.value)
            destiny.velocidadInicial = Double(tfVelocidad.text!)!
            destiny.aceleracion = Double(tfAceleracion.text!)!
            destiny.imagen = imSeleccionada.image
            
            // Se verifica que el grupo de datos a insertar no es repetido en el grupo de datos recientes
            if insertarEnDiccionario(pos: destiny.posInicial, vel: destiny.velocidadInicial, ace: destiny.aceleracion) {
                let diccionario = ["posicion": destiny.posInicial, "velocidad": destiny.velocidadInicial, "aceleracion": destiny.aceleracion]
            
                arrDiccionario.insert(diccionario, at: 0)
            
                // Solo se manejan hasta 10 datos recientes
                if arrDiccionario.count > 10 {
                    arrDiccionario.removeLastObject()
                }
            }
        }
        else if segue.identifier == "datos" {
            // Se transita a la pantalla de los datos mas recientes ingresados por el usuario
            let vistaDatos = segue.destination as! NavigationController
            vistaDatos.arrDiccionario = arrDiccionario
        }
        else if segue.identifier == "configurar" {
            // Se transita a la pantalla de la seleccion de imagen para el objeto a desplegar en las graficas
            let vistaConfiguracion = segue.destination as! ViewControllerConfiguracion
            vistaConfiguracion.imagenIni = imSeleccionada.image
        }
    }

    /*
     * Metodo declarado para el retorno de la pantalla de graficas
     */
    @IBAction func unwindGraficas(_ sender : UIStoryboardSegue) {
    }
    
    /*
     * Metodo declarado para el retorno de la pantalla de creditos
     */
    @IBAction func unwindCreditos(_ sender : UIStoryboardSegue) {
    }
    
    /*
     * Metodo declarado para el retorno de la pantalla de datos recientes
     */
    @IBAction func unwindDatosRecientesSeleccionar(_ sender : UIStoryboardSegue) {
    }
    
    /*
     * Al retornar de la pantalla de configuracion, se actualiza la imagen a mostrar
     * como la seleccionada por el usuario.
     */
    @IBAction func unwindConfiguracionGuardar(_ sender : UIStoryboardSegue) {
        imSeleccionada.image = imagenSeleccionada
    }
    
    //MARK: -- Funciones
    /*
     * Funcion que quita el teclado virtual
     */
    func quitaTeclado() {
        view.endEditing(true)
    }

    /*
     * Se verifica si los grupos de datos a graficar ya se encuentran entre los 10
     * grupos de datos mas recientes checando si existen en el diccionario.
     * Se itera sobre el arreglo de diccionarios y si alguno de ellos repite los 3
     * valores se indica que se repite regresando un false.
     */
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
    
    /*
     * Si la aplicacion se esta cerrando, se sobreescribe en archivo de tipo plist el
     * valor identificador de la imagen seleccionada por el usuario y a eso se le añade
     * el arreglo de diccionarios representando la lista de los grupos de datos mas
     * recientes ingresadas por el usuario.
     */
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
    
    /*
     * Se construye la cadena de texto con la direccion hacia el archivo plist
     * donde se esta almacenando los datos a almacenar
     */
    func dataFilePath() -> String {
        let paths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
        
        let documentsDirectory = paths[0]
        
        return documentsDirectory.appending("/archiPrueba2.plist")
    }
    
    /*
     * Funcion delegada que verifica si la cadena de texto nueva ingresada dentro del 
     * campo de velocidad o aceleracion es valida para formar un numero real.
     * De no ser asi se indica retornando un falso y se mantiene en el campo de texto
     * la cadena anterior sin modificar.
     */
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        // Se obtiene la nueva cadena que incluye el caracter que el usuario quiere ingresar
        let newString = NSString(string: textField.text!).replacingCharacters(in: range, with: string)
        
        // Se verifica si la cadena de texto se puede castear a un decimal
        if let value = newString.doubleValue  {
            return true
        }
        // Si no es decimal se verifica si es alguno de los siguientes casos especiales
        // para iniciar un decimal
        else if newString == "." || newString == "-" || newString == "-." || newString == "" {
            return true
        }
        else {
            // No es una cadena valida
            return false
        }
    }
}

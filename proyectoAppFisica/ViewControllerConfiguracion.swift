//A00815248 - Omar Manjarrez
//A01195995 - David Delgadillo
//A01036134 - Carolina Romo

import UIKit

class ViewControllerConfiguracion: UIViewController {
    
    // MARK: - Variables Globales
    var imagen : UIImage!
    var imagenIni : UIImage!

    // MARK: - Outlets
    @IBOutlet weak var btGuardar: UIButton!
    @IBOutlet weak var imFondoCarrito: UIImageView!
    @IBOutlet weak var imFondoPinguino: UIImageView! //ImFondo de Perrito
    @IBOutlet weak var imFondoPersona: UIImageView!
    @IBOutlet weak var btCarrito: UIButton!
    @IBOutlet weak var btPinguino: UIButton! //Bt de Perrito
    @IBOutlet weak var btPersona: UIButton!
    @IBOutlet weak var btRegresar: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Dependiendo de cual sea la imagen que había en la pantalla inicial
        // Se selecciona la imagen
        if imagenIni.isEqual(UIImage(named: "Carrito")) {
            seleccionImagen1()
        }
        else if imagenIni.isEqual(UIImage(named: "perrito")) {
            seleccionImagen2()
        }
        else {
            seleccionImagen3()
        }
        
        //Dependiendo de cual sea el boton de la imagen que había al inicio
        // Se cambia la imagen inicial
        if btCarrito.isSelected {
            imagenIni = btCarrito.currentBackgroundImage
        }
        if btPinguino.isSelected {
            imagenIni = btPinguino.currentBackgroundImage
        }
        if btPersona.isSelected {
            imagenIni = btPersona.currentBackgroundImage
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    // MARK: - Navigation
    /*
     * Dependiendo de la imagen seleccionada y del boton sleccionado, es la
     * imagen que se manda a la pantalla inicial
     */
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let viewIni = segue.destination as! ViewControllerInicial
        
        //Se verifica si selecciona el boton de Guardar
        if sender as! UIButton == btGuardar {
            if btCarrito.isSelected {
                viewIni.imagenSeleccionada = btCarrito.currentBackgroundImage
                viewIni.idImagen = 0
            }
            if btPinguino.isSelected {
                viewIni.imagenSeleccionada = btPinguino.currentBackgroundImage
                viewIni.idImagen = 1
            }
            if btPersona.isSelected {
                viewIni.imagenSeleccionada = btPersona.currentBackgroundImage
                viewIni.idImagen = 2
            }
        }
        //Si no, se selecciona Cancelar y la imagen se queda igual
        else {
            viewIni.imagenSeleccionada = imagenIni
        }
    }
    
    // MARK: - Actions
    // Acción de cuando selecciona el primer boton
    @IBAction func coloreaCarro(_ sender: UIButton) {
        seleccionImagen1()
    }

    // Acción de cuando selecciona el segundo boton
    @IBAction func coloreaPinguino(_ sender: UIButton) {
        seleccionImagen2()
    }
    
    // Acción de cuando selecciona el tercer boton
    @IBAction func coloreaPersona(_ sender: UIButton) {
        seleccionImagen3()
    }
    
    //MARK: - Funciones
    /*
     * Función que marca la primera imagen como seleccionada
     */
    func seleccionImagen1(){
        //Esconde todos los fondos, menos el primero
        imFondoCarrito.isHidden = true
        imFondoPinguino.isHidden = false
        imFondoPersona.isHidden = false
        
        //Se marca como seleccionado solo el primer boton
        btCarrito.isSelected = true
        btPinguino.isSelected = false
        btPersona.isSelected = false
    }
    
    /*
     * Función que marca la segunda imagen como seleccionada
     */
    func seleccionImagen2(){
        //Esconde todos los fondos, menos el segundo
        imFondoCarrito.isHidden = false
        imFondoPinguino.isHidden = true
        imFondoPersona.isHidden = false
        
        //Se marca como seleccionado solo el segundo boton
        btCarrito.isSelected = false
        btPinguino.isSelected = true
        btPersona.isSelected = false
    }
    
    /*
     * Función que marca la tercera imagen como seleccionada
     */
    func seleccionImagen3(){
        //Esconde todos los fondos, menos el tercero
        imFondoCarrito.isHidden = false
        imFondoPinguino.isHidden = false
        imFondoPersona.isHidden = true
        
        //Se marca como seleccionado solo el tercero boton
        btCarrito.isSelected = false
        btPinguino.isSelected = false
        btPersona.isSelected = true
    }
}

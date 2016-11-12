//A00815248 - Omar Manjarrez
//A01195995 - David Delgadillo
//A01036134 - Carolina Romo

import UIKit

class ViewControllerConfiguracion: UIViewController {

    @IBOutlet weak var imFoto1: UIImageView!
    @IBOutlet weak var imFoto2: UIImageView!
    @IBOutlet weak var imFoto3: UIImageView!
    @IBOutlet weak var btGuardar: UIButton!
    @IBOutlet weak var imFondoCarrito: UIImageView!
    @IBOutlet weak var imFondoPinguino: UIImageView!
    @IBOutlet weak var imFondoPersona: UIImageView!
    @IBOutlet weak var btCarrito: UIButton!
    @IBOutlet weak var btPinguino: UIButton!
    @IBOutlet weak var btPersona: UIButton!
    @IBOutlet weak var btRegresar: UIButton!
    
    var imagen : UIImage!
    var imagenIni : UIImage!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        if imagenIni.isEqual(UIImage(named: "Carrito")) {
            seleccionImagen1()
        }
        else if imagenIni.isEqual(UIImage(named: "perrito")) {
            seleccionImagen2()
        }
        else {
            seleccionImagen3()
        }
        
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
        // Dispose of any resources that can be recreated.
    }
    


    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let viewIni = segue.destination as! ViewControllerInicial
        
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
       else {
            viewIni.imagenSeleccionada = imagenIni
        }
    }
    
    

    // MARK: - Action
    
    @IBAction func coloreaCarro(_ sender: UIButton) {
        seleccionImagen1()
    }

    @IBAction func coloreaPinguino(_ sender: UIButton) {
        seleccionImagen2()
    }
    
    @IBAction func coloreaPersona(_ sender: UIButton) {
        seleccionImagen3()
    }
    
    func seleccionImagen1(){
        imFondoCarrito.isHidden = true
        imFondoPinguino.isHidden = false
        imFondoPersona.isHidden = false
        
        btCarrito.isSelected = true
        btPinguino.isSelected = false
        btPersona.isSelected = false
    }
    
    func seleccionImagen2(){
        imFondoCarrito.isHidden = false
        imFondoPinguino.isHidden = true
        imFondoPersona.isHidden = false
        
        btCarrito.isSelected = false
        btPinguino.isSelected = true
        btPersona.isSelected = false
    }
    
    func seleccionImagen3(){
        imFondoCarrito.isHidden = false
        imFondoPinguino.isHidden = false
        imFondoPersona.isHidden = true
        
        btCarrito.isSelected = false
        btPinguino.isSelected = false
        btPersona.isSelected = true
    }
}

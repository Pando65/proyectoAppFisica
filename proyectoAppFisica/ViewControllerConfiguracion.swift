//A00815248 - Omar Manjarrez
//A01195995 - David Delgadillo
//A01036134 - Carolina Romo

import UIKit

class ViewControllerConfiguracion: UIViewController {

    @IBOutlet weak var imFoto1: UIImageView!
    @IBOutlet weak var btRegresar: UIBarButtonItem!
    @IBOutlet weak var imFoto2: UIImageView!
    @IBOutlet weak var imFoto3: UIImageView!
    @IBOutlet weak var btGuardar: UIButton!
    @IBOutlet weak var imFondoCarrito: UIImageView!
    @IBOutlet weak var imFondoPinguino: UIImageView!
    @IBOutlet weak var imFondoPersona: UIImageView!
    @IBOutlet weak var btCarrito: UIButton!
    @IBOutlet weak var btPinguino: UIButton!
    @IBOutlet weak var btPersona: UIButton!
    
    var imagen : UIImage!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        seleccionImagen1()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    


    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if sender as! UIButton == btGuardar {
            let viewIni = segue.destination as! ViewControllerInicial
            if btCarrito.isSelected {
                viewIni.imagenSeleccionada = btCarrito.currentBackgroundImage
            }
            if btPinguino.isSelected {
                viewIni.imagenSeleccionada = btPinguino.currentBackgroundImage
            }
            if btPersona.isSelected {
                viewIni.imagenSeleccionada = btPersona.currentBackgroundImage
            }
            if sender as! UIButton == btRegresar  {
            }
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

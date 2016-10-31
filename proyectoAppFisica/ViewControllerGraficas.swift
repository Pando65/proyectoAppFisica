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
    @IBOutlet weak var imObjetoMovimiento: UIImageView!
    @IBOutlet weak var imPlataformaMovimiento: UIImageView!
    @IBOutlet weak var imLeftWall: UIImageView!
    @IBOutlet weak var imRightWall: UIImageView!
    
    
    // MARK: - Atributos de la clase
    var posInicial = 0.0
    var velocidadInicial = 0.0
    var aceleracion = 0.0
    var tiempo = 0
    let screenSize: CGRect = UIScreen.main.bounds
    var screenWidth: CGFloat = 0.0
    var alignmentIzquierda: CGFloat = 0.0
    var longitudPlataforma: CGFloat = 0.0
    var imagen : UIImage!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        lbTiempo.text = "\(tiempo) s"
        lbPosicionInicial.text = "\(String(posInicial)) m"
        lbVelocidad.text = "\(String(velocidadInicial)) m/s"
        lbAceleracion.text = "\(String(aceleracion)) m/s2"
        
        setImagesPositionAndSize()
        
        imObjetoMovimiento.image = imagen
        
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

    // MARK: - Actions
    @IBAction func modificaTiempo(_ sender: UIStepper) {
        //Pendiente cambiar posicion segun el stepper
        let tiempoAntiguo = tiempo
        tiempo = Int(sender.value)
        
        let velocidad = velocidadInicial + aceleracion * Double(tiempo)
        let posActual = posInicial + velocidadInicial * Double(tiempo) + 0.5 * aceleracion * (Double(tiempo) * Double(tiempo))
        
        if posActual >= -20.0 && posActual <= 20.0 {
            let posRelativa = ((CGFloat(posActual) + 20.0) / 40.0) * longitudPlataforma
            imObjetoMovimiento.frame.origin.x = alignmentIzquierda + posRelativa - (imObjetoMovimiento.frame.width * 0.5)
            
            /* TODO: Formatear el numero a unos cuantos digitos */
            lbPosicionInicial.text = "\(String(posActual)) m"
            lbVelocidad.text = "\(String(velocidad)) m/s"
            lbTiempo.text = "\(tiempo) s"
        }
        else {
            let alerta = UIAlertController(title: "Ooops",
                                           message: "Si avanzas un segundo el objeto va a chocar con la pared",
                                           preferredStyle: .alert)
            
            alerta.addAction(UIAlertAction(title: "OK", style: .cancel,
                                           handler: nil))
            
            present(alerta, animated: true, completion: nil)
            tiempo = tiempoAntiguo
            sender.value = Double(tiempo)
        }
    }
    

    // MAR: - Functions
    func setImagesPositionAndSize() {
        screenWidth = screenSize.width
        
        alignmentIzquierda = screenWidth * 0.2
        longitudPlataforma = screenWidth * 0.6
        
        imLeftWall.frame.origin.x = alignmentIzquierda-imLeftWall.frame.width
        
        imPlataformaMovimiento.frame = CGRect(x: alignmentIzquierda, y: imPlataformaMovimiento.frame.origin.y, width: longitudPlataforma, height: imPlataformaMovimiento.frame.height)
        
        imRightWall.frame.origin.x = imPlataformaMovimiento.frame.origin.x + longitudPlataforma
        
        let posRelativa = ((CGFloat(posInicial) + 20.0) / 40.0) * longitudPlataforma
        imObjetoMovimiento.frame.origin.x = alignmentIzquierda + posRelativa - (imObjetoMovimiento.frame.width * 0.5)
    }

}

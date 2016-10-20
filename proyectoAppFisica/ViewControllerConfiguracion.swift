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
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        imFondoCarrito.isHidden = false
        imFondoPersona.isHidden = true
        imFondoPinguino.isHidden = true

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

    // MARK: - Action
    
    @IBAction func coloreaCarro(_ sender: UIButton) {
/*
        _ = Timer.scheduledTimer(timeInterval: 0.0, target: self, selector: Selector("highlightButtonPinguino(button: sender)"), userInfo: nil, repeats: true)
 */

    }

    @IBAction func coloreaPinguino(_ sender: UIButton) {
        btCarrito.isHighlighted = false
        btPinguino.isHighlighted = true
        btPersona.isHighlighted = false
    }
    
    @IBAction func coloreaPersona(_ sender: UIButton) {
        btCarrito.isHighlighted = false
        btPinguino.isHighlighted = false
        btPersona.isHighlighted = true
    }
    
    func highlightButtonPinguino(button: UIButton) {
        btCarrito.isHighlighted = true
        btPinguino.isHighlighted = false
        btPersona.isHighlighted = false    }
    
    
    
}

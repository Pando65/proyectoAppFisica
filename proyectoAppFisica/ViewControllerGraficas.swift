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
    var formatter = NumberFormatter()
    var posInicial = 0.0
    var velocidadInicial = 0.0
    var aceleracion = 0.0
    var tiempo = 0
    let screenSize: CGRect = UIScreen.main.bounds
    var screenWidth: CGFloat = 0.0
    var alignmentIzquierda: CGFloat = 0.0
    var longitudPlataforma: CGFloat = 0.0
    var imagen : UIImage!
    var arrPosiciones : [Double] = []
    var arrVelocidades : [Double] = []
    var graficaPosicion : ViewControllerGraficaPosicion!
    var graficaVelocidad : ViewControllerGraficaVelocidad!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Se imprimen los valores adecuados en las respectivas etiquetas
        lbTiempo.text = "\(tiempo) s"
        lbPosicionInicial.text = "\(String(format: "%.2f", posInicial)) m"
        lbVelocidad.text = "\(String(format: "%.2f", velocidadInicial)) m/s"
        lbAceleracion.text = "\(String(format: "%.2f", aceleracion)) m/s2"
        
        // Invoca funcion donde se colocan las imagenes segun los valores y
        // el ancho de la pantalla
        setImagesPositionAndSize()
        
        imObjetoMovimiento.image = imagen
        
        // Se calculan los valores de posicion y velocidad hasta que extienda del rango
        // de desplazamiento posible
        llenarArreglos()
        graficaPosicion.addPoint()
        graficaVelocidad.addPoint()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    


    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "posChart" {
            // Enlaza la vista del controlador con la grafica de posicion
            graficaPosicion = segue.destination as! ViewControllerGraficaPosicion
        }
        if segue.identifier == "velChart" {
            // Enlaza la vista del controlador con la grafica de velocidad
            graficaVelocidad = segue.destination as! ViewControllerGraficaVelocidad
        }
    }

    // MARK: - Actions
    /*
     * Se invoca cuando el usuario presiona el stepper en la pantalla. Seleccionar el 
     * ´+´ implica avanzar un segundo en el tiempo mientras que el ´-´implica
     * retroceder un segundo en el tiempo. Segun el tiempo, se obtiene los valores
     * de posicion y velocidad para desplegar el punto en la grafica y para colocar la 
     * imagen en la colocacion correcta relativa sobre la plataforma.
     */
    @IBAction func modificaTiempo(_ sender: UIStepper) {
        
        let tiempoAntiguo = tiempo
        tiempo = Int(sender.value)
        
        // Si se ubica el tiempo dentro de los valores calculados posibles
        if tiempo < arrPosiciones.count - 1 && arrPosiciones[tiempo] >= -20.0 && arrVelocidades[tiempo] <= 20.0 {
            // Se obtienen los datos precalculados segun el tiempo
            let posActual = arrPosiciones[tiempo]
            let velocidad = arrVelocidades[tiempo]
            let posRelativa = ((CGFloat(posActual) + 20.0) / 40.0) * longitudPlataforma
            
            UIView.animate(withDuration: 1, animations: {
                self.imObjetoMovimiento.frame.origin.x = self.alignmentIzquierda + posRelativa - (self.imObjetoMovimiento.frame.width * 0.5)
            })
            imObjetoMovimiento.frame.origin.x = alignmentIzquierda + posRelativa - (imObjetoMovimiento.frame.width * 0.5)
            
            // Envio el nuevo punto a la gráfica
            if tiempoAntiguo < tiempo {
                graficaPosicion.addPoint()
                graficaVelocidad.addPoint()
            }
            else {
                graficaPosicion.removeLastPoint()
                graficaVelocidad.removeLastPoint()
            }
            
            // Se actualizan los textos de las etiquetas segun los nuevos valores
            lbPosicionInicial.text = "\(String(format: "%.2f", posActual)) m"
            lbVelocidad.text = "\(String(format: "%.2f", velocidad)) m/s"
            lbTiempo.text = "\(tiempo) s"
        }
        else {
            // Se llega a un tiempo sin datos ya calculados
            var mensaje = "";
            if velocidadInicial == 0 && aceleracion == 0 {
                // Para evitar ciclo infinito, se impide avanzar en el tiempo al 
                // usuario en cierto punto
                mensaje = "El objeto nunca se movera pues tiene velocidad y aceleracion igual a 0"
            }
            else {
                // De no ser el caso anterior, significa que el objeto se salia del
                // rango de desplazamiento de -20 y 20
                mensaje = "Si avanzas un segundo el objeto va a chocar con la pared"
            }
            
            let alerta = UIAlertController(title: "Ooops",
                                           message: mensaje,
                                           preferredStyle: .alert)
            
            alerta.addAction(UIAlertAction(title: "OK", style: .cancel,
                                           handler: nil))
            
            // Se asignan los valores anteriores nuevamente
            present(alerta, animated: true, completion: nil)
            tiempo = tiempoAntiguo
            sender.value = Double(tiempo)
        }
    }
    

    // MARK: - Functions
    /*
     * Se calculan todos los valores de velocidad y posicion respecto a cada segundo
     * en el tiempo mientras no se salga del rango de desplazamiento
     */
    func llenarArreglos() {
        var velocidad = velocidadInicial
        var posicion = posInicial
        var tiempo = 0
        var max_r = 7
        repeat {
            // Formula para obtener posicion segun aceleracion, velocidad inicial y tiempo
            posicion = posInicial + velocidadInicial * Double(tiempo) + 0.5 * aceleracion * (Double(tiempo) * Double(tiempo))
            // Formula para obtener velocidad segun aceleracion, velocidad inicial y tiempo
            velocidad = velocidadInicial + aceleracion * Double(tiempo)
            arrPosiciones.append(posicion)
            arrVelocidades.append(velocidad)
            tiempo += 1
            
            // Se va almacenando la cantidad de datos calculados para cuando
            // el objeto no tenga movimiento alguna y evitar el ciclo cuando
            // llegue al limite definido
            if velocidadInicial == 0 && aceleracion == 0 {
                max_r -= 1
            }
        } while posicion >= -20 && posicion <= 20 && max_r > 0
        graficaPosicion.yValues = arrPosiciones
        graficaVelocidad.yValues = arrVelocidades
    }
    
    /*
     * Se asigna la ubicacion de los objetos plataforma, ambas paredes y el objeto
     * seleccionado por el usuario segun el ancho de la pantalla y para el objeto 
     * tambien segun la posicion inicial
     */
    func setImagesPositionAndSize() {
        screenWidth = screenSize.width
        
        // Se coloca plataforma a 20% del margen izquierdo de la pantalla
        alignmentIzquierda = screenWidth * 0.2
        // Se pinta la plataforma en ancho del 60% de la pantalla
        longitudPlataforma = screenWidth * 0.6
        
        // Se coloca la pared segun la posicion de la plataforma
        imLeftWall.frame.origin.x = alignmentIzquierda-imLeftWall.frame.width
        
        imPlataformaMovimiento.frame = CGRect(x: alignmentIzquierda, y: imPlataformaMovimiento.frame.origin.y, width: longitudPlataforma, height: imPlataformaMovimiento.frame.height)
        
        // Se coloca la pared izquierda segun la posicion de la plataforma
        imRightWall.frame.origin.x = imPlataformaMovimiento.frame.origin.x + longitudPlataforma
        
        // Se hace un calculo relativo de la posicion del objeto de acuerdo a la
        // relacion del 100% entre el rango de -20 y 20
        let posRelativa = ((CGFloat(posInicial) + 20.0) / 40.0) * longitudPlataforma
        imObjetoMovimiento.frame.origin.x = alignmentIzquierda + posRelativa - (imObjetoMovimiento.frame.width * 0.5)
    }

}

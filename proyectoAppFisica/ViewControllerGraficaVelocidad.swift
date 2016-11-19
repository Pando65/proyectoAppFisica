//
//  ViewControllerGraficaVelocidad.swift
//  proyectoAppFisica
//
//  Created by Omar Manjarrez on 10/11/16.
//  Copyright © 2016 ITESM. All rights reserved.
//

import UIKit
import Charts

class ViewControllerGraficaVelocidad: UIViewController {
    
    // Objeto tipo grafica
    @IBOutlet var lineChart: LineChartView!
    // Todos los valores de Y de la grafica
    var yValues:[Double] = []
    // Indice del ultimo punto desplegado
    var index = -1
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    /*
     * Incrementa el index para dibujar un punto más en la grafica
     */
    func addPoint() {
        index += 1
        setChart()
    }
    
    /*
     * Decrementa el index para quitar un punto de la grafica
     */
    func removeLastPoint() {
        if index > 0 {
            index -= 1
            setChart()
        }
    }
    
    /*
     * Funcion que se encarga de dibujar de dibujar la grafica con los
     * puntos actuales
     */
    func setChart() {
        // Guardara los puntos con el tipo esperado
        var dataEntries:[ChartDataEntry] = []
        
        // Llenamos la información
        for i in 0..<index + 1 {
            let dataEntry = ChartDataEntry(x: Double(i), y: yValues[i])
            dataEntries.append(dataEntry)
        }
        
        // Configuracion el DataSet
        let lChartDataSet = LineChartDataSet(values: dataEntries, label: "Velocidad")
        var dataSets: [IChartDataSet] = []
        // Agregamos estilo al data set
        lChartDataSet.highlightColor = UIColor.init(red: 144, green: 234, blue: 254, alpha: 0.7)
        
        // Añadimos el data set al arreglo de datasets
        dataSets.append(lChartDataSet)
        
        // Creamos chart data, que será el input de la grafica
        let lChartData = LineChartData(dataSets: dataSets)
        lChartData.highlightEnabled = true
        
        // Colocamos la informacion
        lineChart.data = lChartData
        
        // Maximos y minimos del eje X (tiempo)
        lineChart.xAxis.axisMaximum = Double(yValues.count - 1)
        lineChart.xAxis.axisMinimum = 0.0
        
        // Maximos y minimos del eje Y (posicion)
        lineChart.leftAxis.axisMaximum = getMaxY()
        lineChart.leftAxis.axisMinimum = getMinY()
        
        // Desactivar el eje derecho
        lineChart.rightAxis.enabled = false
        
        // Colocar el eje X abajo
        lineChart.xAxis.labelPosition = .bottom
        
        // Quitar description text
        lineChart.descriptionText = ""
        
        // Desactivar seleccion manual
        lineChart.highlightPerTapEnabled = false
        //lineChart.highlightPerDragEnabled = false
        
        // Destacamos el ultimo punto agregado
        let hl : Highlight = Highlight(x: Double(index), y: yValues[index], dataSetIndex: 0)
        lineChart.highlightValue(hl)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    /*
     * Obtiene el valor maximo de Y para ajustar los limites del eje
     */
    func getMaxY() -> Double {
        var max : Double = -10000
        for pos in yValues {
            if pos > max {
                max = pos
            }
        }
        return max + 4
    }
    
    /*
     * Obtiene el valor minimo de Y para ajustar los limites del eje
     */
    func getMinY() -> Double {
        var min : Double = 10000
        for pos in yValues {
            if pos < min {
                min = pos
            }
        }
        return min - 4
    }
    
}

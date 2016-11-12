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
    
    @IBOutlet var lineChart: LineChartView!
    var yValues:[Double] = []
    var index = -1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    func addPoint() {
        index += 1
        setChart()
    }
    
    func removeLastPoint() {
        if index > 0 {
            index -= 1
            setChart()
        }
    }
    
    func setChart() {
        var dataEntries:[ChartDataEntry] = []
        
        for i in 0..<index + 1 {
            let dataEntry = ChartDataEntry(x: Double(i), y: yValues[i])
            dataEntries.append(dataEntry)
        }
        
        let lChartDataSet = LineChartDataSet(values: dataEntries, label: "Aceleración")
        var dataSets: [IChartDataSet] = []
        
        //estilo
        // lChartDataSet.setColor(UIColor.blue) Color de la linea que une los puntos
        lChartDataSet.highlightColor = UIColor.init(red: 144, green: 234, blue: 254, alpha: 0.7)
        // lChartDataSet.lineWidth = 1.0
        // lChartDataSet.circleRadius = 5.0
        
        dataSets.append(lChartDataSet)
        let lChartData = LineChartData(dataSets: dataSets)
        lChartData.highlightEnabled = true
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
        
        let hl : Highlight = Highlight(x: Double(index), y: yValues[index], dataSetIndex: 0)
        lineChart.highlightValue(hl)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
    func getMaxY() -> Double {
        var max : Double = -21
        for pos in yValues {
            if pos > max {
                max = pos
            }
        }
        return max
    }
    
    func getMinY() -> Double {
        var min : Double = 21
        for pos in yValues {
            if pos < min {
                min = pos
            }
        }
        return min
    }
    
}
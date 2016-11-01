//
//  ViewControllerGraficaPosicion.swift
//  proyectoAppFisica
//
//  Created by Omar Manjarrez on 22/10/16.
//  Copyright © 2016 ITESM. All rights reserved.
//

import UIKit
import Charts

class ViewControllerGraficaPosicion: UIViewController {
    
    @IBOutlet var lineChart: LineChartView!
    var yValues:[Double] = []
    var index = -1
    
    override func viewDidLoad() {
        super.viewDidLoad()
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
        
        let lChartDataSet = LineChartDataSet(values: dataEntries, label: "Posición")
        var dataSets: [IChartDataSet] = []
        dataSets.append(lChartDataSet)
        let lChartData = LineChartData(dataSets: dataSets)
        lineChart.data = lChartData
        lineChart.xAxis.axisMaximum = Double(yValues.count - 1)
        lineChart.xAxis.axisMinimum = 0.0
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

}

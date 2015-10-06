//
//  BarChartViewController.swift
//  iOSChartsDemo
//
//  Created by Joyce Echessa on 6/12/15.
//  Copyright (c) 2015 Appcoda. All rights reserved.
//

import UIKit
import Charts

class BarChartViewController: UIViewController, ChartViewDelegate {

    @IBOutlet weak var barChartView1: LineChartView!
    
        var months: [String] = []
        var unitsSold: [Double] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        barChartView1.delegate = self
        // Do any additional setup after loading the view, typically from a nib.
        
        var endpoint = NSURL(string: "http://linkedfactory.iwu.fraunhofer.de/linkedfactory/profiroll/rollex_xl_hp/values?properties=gesamtscheinleistung&from=1444060241718&to=1444060257318&limit=20")
        var jsondata = NSData(contentsOfURL: endpoint!)
        var dataString = NSString(data: jsondata!, encoding:NSUTF8StringEncoding)
        
        // new way
        let jsonSwift = JSON(data: jsondata!)
        print("JSONSwift...")
        print(jsonSwift)
        
        print("Step1...")
        print(jsonSwift["http://linkedfactory.iwu.fraunhofer.de/linkedfactory/profiroll/rollex_xl_hp"])
        
        print("Step2...")
        print(jsonSwift["http://linkedfactory.iwu.fraunhofer.de/linkedfactory/profiroll/rollex_xl_hp"]["gesamtscheinleistung"])
        
        print("Step3...")
        
        let c = jsonSwift["http://linkedfactory.iwu.fraunhofer.de/linkedfactory/profiroll/rollex_xl_hp"]["gesamtscheinleistung"].count
        
        print(c)

        

        for index in 0...(c-1) {
            
            self.months.append((String)(jsonSwift["http://linkedfactory.iwu.fraunhofer.de/linkedfactory/profiroll/rollex_xl_hp"]["gesamtscheinleistung"][index]["time"]))
            
            self.unitsSold.append((Double)(jsonSwift["http://linkedfactory.iwu.fraunhofer.de/linkedfactory/profiroll/rollex_xl_hp"]["gesamtscheinleistung"][index]["value"].doubleValue))

        }
        
        print(months)
        print(unitsSold)
        
        //months = ["Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"]
        //unitsSold = [20.0, 4.0, 6.0, 3.0, 12.0, 16.0, 4.0, 18.0, 2.0, 4.0, 5.0, 4.0]
        
        setChart(months, values: unitsSold)
    }
    
    func setChart(dataPoints: [String], values: [Double]) {
        var dataEntries: [ChartDataEntry] = []
        
        for i in 0..<dataPoints.count {
            let dataEntry = ChartDataEntry(value: values[i], xIndex: i)
            dataEntries.append(dataEntry)
        }
        
        let chartDataSet = LineChartDataSet(yVals: dataEntries, label: "Units Sold")
        let chartData = LineChartData(xVals: months, dataSet: chartDataSet)
        //barChartView1.animate(xAxisDuration: 2.0, yAxisDuration: 2.0)
        barChartView1.data = chartData
        barChartView1.descriptionText = "MyChart"
    }
    
    func chartValueSelected(chartView: ChartViewBase, entry: ChartDataEntry, dataSetIndex: Int, highlight: ChartHighlight) {
        print("\(entry.value) in \(months[entry.xIndex])")
    }

}


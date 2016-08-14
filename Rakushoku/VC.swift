import UIKit
import Foundation

import Charts
import Realm
import Realm.Dynamic

class VC: UIViewController {
    var LineChartView1: LineChartView!
    var LineChartView2: LineChartView!
    var unitsSold1: [Double]!
    var unitsSold2: [Double]!
    
    var months: [String]!

    override func viewDidLoad() {
        super.viewDidLoad()
        months = ["1月", "2月", "3月","4月", "5月", "6月"]
        unitsSold1 = [62.0, 68.0, 65.0, 60.0, 58.0, 68.0]
        LineChartView1 = LineChartView()
        LineChartView1.frame = CGRectMake(0, 0, self.view.bounds.width, 140)
        LineChartView1.animate(yAxisDuration: 2.0)
        LineChartView1.pinchZoomEnabled = false
        LineChartView1.drawBordersEnabled = false
        LineChartView1.drawGridBackgroundEnabled = false
        LineChartView1.gridBackgroundColor = UIColor.whiteColor()
        LineChartView1.gridBackgroundColor = UIColor.grayColor()
        LineChartView1.borderLineWidth = 0
        LineChartView1.descriptionText = ""
        LineChartView1.xAxis.drawGridLinesEnabled = false
        LineChartView1.xAxis.drawAxisLineEnabled = true
        LineChartView1.leftAxis.drawGridLinesEnabled = false
        LineChartView1.rightAxis.drawGridLinesEnabled = false
        LineChartView1.noDataText = "表示できるデータがありません"
        LineChartView1.leftAxis.drawLabelsEnabled = false
        LineChartView1.rightAxis.drawLabelsEnabled = false
        SetChart(months, values: unitsSold1)
        
        unitsSold2 = [22.0, 21.0, 25.0, 28.0, 25.0, 23.0]
        LineChartView2 = LineChartView()
        LineChartView2.frame = CGRectMake(0, 0, self.view.bounds.width, 150)
        LineChartView2.animate(yAxisDuration: 2.0)
        LineChartView2.pinchZoomEnabled = false
        LineChartView2.drawBordersEnabled = false
        LineChartView2.drawGridBackgroundEnabled = false
        LineChartView2.gridBackgroundColor = UIColor.clearColor()
        LineChartView2.borderLineWidth = 0
        LineChartView2.descriptionText = ""
        LineChartView2.xAxis.drawGridLinesEnabled = false
        LineChartView2.xAxis.drawAxisLineEnabled = true
        LineChartView2.leftAxis.drawGridLinesEnabled = false
        LineChartView2.rightAxis.drawGridLinesEnabled = false
        LineChartView2.noDataText = "表示できるデータがありません"
        LineChartView2.leftAxis.drawLabelsEnabled = false
        LineChartView2.rightAxis.drawLabelsEnabled = false
        SetChart(months, values: unitsSold2)
    }
    func SetChart(dataPoints: [String], values: [Double]) {
        var dataEntries: [ChartDataEntry] = []
        for i in 0..<dataPoints.count {
            let dataEntry = ChartDataEntry(value: values[i], xIndex: i)
            dataEntries.append(dataEntry)
        }
        if values == unitsSold1{
            let chartDataSet1 = LineChartDataSet(yVals: dataEntries, label: "体重")
            chartDataSet1.drawCubicEnabled = false
            chartDataSet1.drawSteppedEnabled = false
            let chartData1 = LineChartData(xVals: months, dataSet: chartDataSet1)
            LineChartView1.data = chartData1
            self.view.addSubview(LineChartView1)
        }else{
            let chartDataSet2 = LineChartDataSet(yVals: dataEntries, label: "BMI")
            chartDataSet2.setCircleColor(imageColor)
            chartDataSet2.setColor(imageColor)
            chartDataSet2.drawCubicEnabled = false
            chartDataSet2.drawSteppedEnabled = false
            let chartData2 = LineChartData(xVals: months, dataSet: chartDataSet2)
            LineChartView2.data = chartData2
            self.view.addSubview(LineChartView2)
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

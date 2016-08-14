import UIKit
import Foundation
import Charts
import Realm
import Realm.Dynamic
import Parse
import HealthKit

class MyPageVC: UIViewController, UITableViewDataSource, UITableViewDelegate {
    var TableView:UITableView!
    var SectionTitle:[String] = ["今日の記録","過去記録 過去6ヶ月平均","食事記録","検索記録"]
    var RowNumber:[Int] = [1,2,3,1]
    var RowHeight:[[CGFloat]] = [[100],[100,200],[104,104,104],[104]]
    var FoodRecord:[[String]] = [["2016/06/03","1","2","3","4"],["2016/06/02","5","6","7","8"],["2016/06/01","9","10","11","12"]]
    var SearchRecord = ["13","14","15","16"]
    var LineChartView1: LineChartView!
    var LineChartView2: LineChartView!
    var unitsSold1: [Double]!
    var unitsSold2: [Double]!
    var unitsSold3: [Double]!
    var months: [String]!
    var temp:[String:String] = [:]
    var UserInfos: [[String:String]] = [[:]]
    var Today1 = ""
    var Today2 = ""
    var Today3 = ""
    var Summary1 = ""
    var Summary2 = ""
    var Summary3 = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "マイページ"
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "Notification"), style: .Plain, target: self, action: "Next1")
        var QA = UIBarButtonItem(image: UIImage(named: "QA"), style: .Plain, target: self, action: "Next2")
        var Setting = UIBarButtonItem(image: UIImage(named: "Setting"), style: .Plain, target: self, action: "Next3")
        var HealthCare = UIBarButtonItem(image: UIImage(named: "HealthCare"), style: .Plain, target: self, action: "HealthCare")
        self.navigationItem.rightBarButtonItems = [Setting,QA,HealthCare]
    }
    override func viewDidAppear(animated: Bool) {
        SetGraph()
        SetTableView()
        UserInfos = []
        Fetch()
    }
    
    //Graph作成
    func SetGraph(){
        months = ["1月", "2月", "3月", "4月", "5月", "6月"]
        unitsSold1 = [0.0, 0.0, 0.0, 0.0, 0.0, 0.0]
        unitsSold2 = [0.0, 0.0, 0.0, 0.0, 0.0, 0.0]
        unitsSold3 = [0.0, 0.0, 0.0, 0.0, 0.0, 0.0]
        LineChartView1 = LineChartView()
        LineChartView1.frame = CGRectMake(0, 0, self.view.bounds.width, 188)
        LineChartView1.animate(yAxisDuration: 2.0)
        LineChartView1.pinchZoomEnabled = false
        LineChartView1.drawBordersEnabled = false
        LineChartView1.highlightPerTapEnabled = false
        LineChartView1.drawGridBackgroundEnabled = false
        LineChartView1.gridBackgroundColor = UIColor.whiteColor()
        LineChartView1.gridBackgroundColor = UIColor.grayColor()
        LineChartView1.borderLineWidth = 0
        LineChartView1.descriptionText = ""
        LineChartView1.xAxis.drawGridLinesEnabled = false
        LineChartView1.xAxis.drawAxisLineEnabled = false
        LineChartView1.xAxis.drawLabelsEnabled = false
        LineChartView1.leftAxis.drawGridLinesEnabled = false
        LineChartView1.rightAxis.drawGridLinesEnabled = false
        LineChartView1.noDataText = ""
        LineChartView1.leftAxis.drawLabelsEnabled = false
        LineChartView1.rightAxis.drawLabelsEnabled = false
        LineChartView1.drawBordersEnabled = false
        LineChartView1.pinchZoomEnabled = false
        LineChartView1.doubleTapToZoomEnabled = false
        LineChartView1.dragEnabled = false
        LineChartView1.xAxis.axisMaxValue = 80.0

        LineChartView2 = LineChartView()
        LineChartView2.frame = CGRectMake(0, 0, self.view.bounds.width, 200)
        LineChartView2.animate(yAxisDuration: 2.0)
        LineChartView2.pinchZoomEnabled = false
        LineChartView2.drawBordersEnabled = false
        LineChartView2.highlightPerTapEnabled = false
        LineChartView2.drawGridBackgroundEnabled = false
        LineChartView2.gridBackgroundColor = UIColor.clearColor()
        LineChartView2.borderLineWidth = 0
        LineChartView2.descriptionText = ""
        LineChartView2.xAxis.drawGridLinesEnabled = false
        LineChartView2.xAxis.drawAxisLineEnabled = false
        LineChartView2.xAxis.drawLabelsEnabled = false
        LineChartView2.leftAxis.drawGridLinesEnabled = false
        LineChartView2.rightAxis.drawGridLinesEnabled = false
        LineChartView2.noDataText = "表示できるデータがありません"
        LineChartView2.leftAxis.drawLabelsEnabled = false
        LineChartView2.rightAxis.drawLabelsEnabled = false
        LineChartView2.drawBordersEnabled = false
        LineChartView2.pinchZoomEnabled = false
        LineChartView2.doubleTapToZoomEnabled = false
        LineChartView2.dragEnabled = false
        
        var i = 0
        var j = 0
        var k = 0
        if UserInfos.count != 0{
            for U in UserInfos{
                if (U["weight"] != nil) && (U["weight"] != "") && (i < 6) {
                    unitsSold1[5-i] = Double(U["weight"]!)!
                    i++
                }
                if (U["bmi"] != nil) && (U["bmi"] != "") && (j < 6) {
                    unitsSold2[5-j] = Double(U["bmi"]!)!
                    j++
                }
                if (U["height"] != nil) && (U["height"] != "") && (k < 6) {
                    unitsSold3[5-j] = Double(U["height"]!)!
                    k++
                }
            }
            SetChart(months, values: unitsSold1)
            SetChart(months, values: unitsSold2)
        
            var u3average = 0.0
            var u3count = 0.0
            for u3 in unitsSold3{
                if u3 != 0.0 {
                    u3average = u3average + u3
                    u3count = u3count + 1.0
                }
            }
            if u3count != 0.0{
                u3average = u3average / u3count
                Summary1 = "身長:" + String(Int(u3average)) + "cm"
            }else{
                Summary1 = ""
            }
            
            var u1average = 0.0
            var u1count = 0.0
            for u1 in unitsSold1{
                if u1 != 0.0 {
                    u1average = u1average + u1
                    u1count = u1count + 1.0
                }
            }
            if u1count != 0.0{
                u1average = u1average / u1count
                Summary2 = "体重:" + String(Int(u1average)) + "kg"
            }else{
                Summary2 = ""
            }
        }
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
        }else{
            let chartDataSet2 = LineChartDataSet(yVals: dataEntries, label: "BMI")
            chartDataSet2.setCircleColor(imageColor)
            chartDataSet2.setColor(imageColor)
            chartDataSet2.drawCubicEnabled = false
            chartDataSet2.drawSteppedEnabled = false
            let chartData2 = LineChartData(xVals: months, dataSet: chartDataSet2)
            LineChartView2.data = chartData2
        }
    }
    //
    //TableViewの設定
    func SetTableView(){
        TableView = UITableView()
        TableView.frame = CGRectMake(4, 0, self.view.bounds.width-8, self.view.bounds.height-32)
        TableView.registerNib(UINib(nibName: "MyPageTVC1", bundle: nil), forCellReuseIdentifier: "MyPageTVC1")
        TableView.registerNib(UINib(nibName: "MyPageTVC2", bundle: nil), forCellReuseIdentifier: "MyPageTVC2")
        TableView.registerNib(UINib(nibName: "MyPageTVC3", bundle: nil), forCellReuseIdentifier: "MyPageTVC3")
        TableView.dataSource = self
        TableView.delegate = self
        self.view.addSubview(TableView)
        self.TableView.reloadData()
    }
    //セクション
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 4
    }
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return SectionTitle[section]
    }
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let label : UILabel = UILabel()
        label.backgroundColor = UIColor.whiteColor()
        label.font = UIFont(name: "HiraginoSans-W3", size: 16)
        label.textColor = imageColor
        label.numberOfLines = 2
        label.text = SectionTitle[section]
        return label
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return RowNumber[section]
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if indexPath.section == 0{
            let cell1 = self.TableView.dequeueReusableCellWithIdentifier("MyPageTVC1")! as UITableViewCell
            cell1.textLabel?.textColor = UIColor.grayColor()
            cell1.textLabel?.textAlignment = NSTextAlignment.Left
            cell1.textLabel?.numberOfLines = 0
            cell1.imageView?.image = UIImage(named: "Human")
            cell1.selectionStyle = UITableViewCellSelectionStyle.None
            
            cell1.textLabel?.text = "今日の記録は有りません"
            RecordAlert = 1
            if UserInfos.count != 0{
                var i = UserInfos.count - 1
                if UserInfos[i]["height"]! != ""{
                    Today1 = "身長:" + UserInfos[i]["height"]! + "cm"
                }else{
                    Today1 = ""
                }
                if UserInfos[i]["weight"]! != ""{
                    Today2 = "体重:" + UserInfos[i]["weight"]! + "kg"
                }else{
                    Today2 = ""
                }
                if UserInfos[i]["condition"]! != ""{
                    Today3 = "体調:" + UserInfos[i]["condition"]!
                }else{
                    Today3 = ""
                }
                if Today1 == "" && Today2 == "" && Today3 == ""{
                    cell1.textLabel?.text = "今日の記録は有りません"
                    RecordAlert = 1
                }else{
                    cell1.textLabel?.text = Today1 + "\n" + Today2 + "\n" + Today3
                    RecordAlert = 0
                }
            }
            return cell1
        }else if indexPath.section == 1 && indexPath.row == 0{
            let cell21 = self.TableView.dequeueReusableCellWithIdentifier("MyPageTVC1")! as UITableViewCell
            cell21.textLabel?.textColor = UIColor.grayColor()
            cell21.textLabel?.textAlignment = NSTextAlignment.Left
            cell21.textLabel?.numberOfLines = 0
            cell21.imageView?.image = UIImage(named: "Human")
            cell21.selectionStyle = UITableViewCellSelectionStyle.None
            
            cell21.textLabel?.text = "過去記録が有りません"
            if UserInfos.count != 0{
                if Summary1 == "" && Summary2 == ""{
                    cell21.textLabel?.text = "過去記録が有りません"
                }else{
                    cell21.textLabel?.text = Summary1 + "\n" + Summary2
                }
            }
            return cell21
        }else if indexPath.section == 1 && indexPath.row == 1{
            let cell22 = UITableViewCell()
            cell22.addSubview(LineChartView1)
            cell22.addSubview(LineChartView2)
            cell22.selectionStyle = UITableViewCellSelectionStyle.None
            return cell22
        }else if indexPath.section == 2{
            let cell3 =  self.TableView.dequeueReusableCellWithIdentifier("MyPageTVC3")! as UITableViewCell
            var image1 = cell3.viewWithTag(1) as! UIImageView
            var image2 = cell3.viewWithTag(2) as! UIImageView
            var image3 = cell3.viewWithTag(3) as! UIImageView
            var image4 = cell3.viewWithTag(4) as! UIImageView
            var label1 = cell3.viewWithTag(5) as! UILabel
            image1.image = UIImage(named: FoodRecord[indexPath.row][1])
            image2.image = UIImage(named: FoodRecord[indexPath.row][2])
            image3.image = UIImage(named: FoodRecord[indexPath.row][3])
            image4.image = UIImage(named: FoodRecord[indexPath.row][4])
            label1.text = FoodRecord[indexPath.row][0]
            cell3.selectionStyle = UITableViewCellSelectionStyle.None
            return cell3
        }else {
            let cell4 =  self.TableView.dequeueReusableCellWithIdentifier("MyPageTVC3")! as UITableViewCell
            var image1 = cell4.viewWithTag(1) as! UIImageView
            var image2 = cell4.viewWithTag(2) as! UIImageView
            var image3 = cell4.viewWithTag(3) as! UIImageView
            var image4 = cell4.viewWithTag(4) as! UIImageView
            image1.image = UIImage(named: SearchRecord[0])
            image2.image = UIImage(named: SearchRecord[1])
            image3.image = UIImage(named: SearchRecord[2])
            image4.image = UIImage(named: SearchRecord[3])
            cell4.selectionStyle = UITableViewCellSelectionStyle.None
            return cell4
        }
    }
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return RowHeight[indexPath.section][indexPath.row]
    }
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if indexPath.section == 0{
            Next00()
        }else if indexPath.section == 2{
            FoodDetailFlag = "2"
            self.Next20()
        }else if indexPath.section == 3{
            FoodDetailFlag = "2"
            self.Next30()
        }
    }
    //
    
    
    //データ取得
    func Fetch(){
        UIApplication.sharedApplication().networkActivityIndicatorVisible = true
        temp = [:]
        let queryInfo = PFQuery(className: "UserInfo")
        queryInfo.limit = 1000
        if PFUser.currentUser() != nil {
            queryInfo.includeKey("user")
        }
        queryInfo.findObjectsInBackgroundWithBlock { (objects, error) in
            if error == nil {
                for object in objects! {
                    if PFUser.currentUser() != nil {
                        let USER = object["user"].objectId
                        let current = PFUser.currentUser()!.objectId
                        if USER == current {
                        self.temp = [
                            "username":object["username"] as! String,
                            "purpose":object["purpose"] as! String,
                            "birthday":object["birthday"] as! String,
                            "height":object["height"] as! String,
                            "weight":object["weight"] as! String,
                            "condition":object["condition"] as! String,
                            "heartrate":object["heartrate"] as! String,
                            "bloodpressure":object["bloodpressure"] as! String,
                            "energy":object["energy"] as! String,
                            "restrictionfood":object["restrictionfood"] as! String,
                            "glucoselevel":object["glucoselevel"] as! String,
                            "abdominalgia":object["abdominalgia"] as! String,
                            "bowel":object["bowel"] as! String,
                            "blood":object["blood"] as! String,
                            "bmi":object["bmi"] as! String,
                            "date":String(object.createdAt)
                        ]
                        self.UserInfos.append(self.temp)
                        }
                    }
                }
                self.SetGraph()
                self.TableView.reloadData()
                UIApplication.sharedApplication().networkActivityIndicatorVisible = false
            }
        }
    }
    //
    
    //HealthKit
    func HealthCare(){
        //HealthKit
        // データ取得
        let healthStore = HKHealthStore()
        // データ抽出クエリ
        let type1 = HKObjectType.quantityTypeForIdentifier(HKQuantityTypeIdentifierHeight)!
        let query1 = HKSampleQuery(sampleType: type1, predicate: nil, limit: 0, sortDescriptors: nil) { (query, results, error) in
            // データ抽出処理完了後の処理
            if error != nil{
                print("エラー")
            }
            if let samples = results as? [HKQuantitySample]{
                dispatch_async(dispatch_get_main_queue()){
                    if samples.first?.quantity != nil{
                        var str = String((samples.first?.quantity)!)
                        str = str.stringByReplacingOccurrencesOfString(" m", withString: "")
                        str = String(Int(Double(str)!*100))
                        height = str
                        alertMessage = height
                        alertMessage = "ヘルスケアの身長データ\n\(height) cm"
                        AlertMessage()
                        self.presentViewController(alertController, animated: false, completion: nil)
                    }
                }
            }
        }
        // HealthStoreへのアクセス権限確認
        let authorizedStatus1 = healthStore.authorizationStatusForType(type1)
        // 権限があれば、実行。権限がなければ、権限確認画面へ。
        if authorizedStatus1 == .SharingAuthorized{
            healthStore.executeQuery(query1)
        }else{
            healthStore.requestAuthorizationToShareTypes([type1], readTypes: [type1]) {
                success, error in
                
                if error != nil {
                    print(error!.description);
                    return
                }
                if success {
                    // 引数に指定されたクエリーを実行します
                    healthStore.executeQuery(query1)
                }
            }
        }
    }
    //
    //画面遷移系
    func Next00(){
        self.performSegueWithIdentifier("Next00", sender: nil)
    }
    func Next20(){
        self.performSegueWithIdentifier("Next10", sender: nil)
    }
    func Next30(){
        self.performSegueWithIdentifier("Next10", sender: nil)
    }
    func Next1(){
        let registervc = self.storyboard?.instantiateViewControllerWithIdentifier("NotificationVC")
        self.presentViewController(registervc!, animated: true, completion: nil)
    }
    func Next2(){
        let registervc = self.storyboard?.instantiateViewControllerWithIdentifier("WatsonVC")
        self.presentViewController(registervc!, animated: true, completion: nil)
    }
    func Next3(){
        let registervc = self.storyboard?.instantiateViewControllerWithIdentifier("SettingVC")
        self.presentViewController(registervc!, animated: true, completion: nil)
    }
    //
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

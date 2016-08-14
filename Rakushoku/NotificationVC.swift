import UIKit

class NotificationVC: UIViewController,UITableViewDelegate, UITableViewDataSource{
    var TableView: UITableView!
    var cell: UITableViewCell!
    var image1: UIImageView!
    var label1: UILabel!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "お知らせ"
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "戻る", style: .Plain, target: self, action: "Back")
    }
    
    override func viewDidAppear(animated: Bool) {
        EnergyAlert = 1
        LipoidAlert = 1
        RecommendAlert = 1
        SetTableView()
    }
    
    //TableView設定
    func SetTableView(){
        TableView = UITableView()
        TableView.frame = CGRectMake(0, 0, self.view.bounds.width, self.view.bounds.height)
        TableView.registerNib(UINib(nibName: "NotificationTVC", bundle: nil), forCellReuseIdentifier: "NotificationTVC")
        TableView.dataSource = self
        TableView.delegate = self
        self.view.addSubview(TableView)
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var rownumber = RecordAlert + EnergyAlert + LipoidAlert + RecommendAlert
        return rownumber
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        cell = self.TableView.dequeueReusableCellWithIdentifier("NotificationTVC")! as UITableViewCell
        image1 = cell.viewWithTag(1) as! UIImageView
        label1 = cell.viewWithTag(2) as! UILabel
        cell.selectionStyle = UITableViewCellSelectionStyle.None
        if RecordAlert == 1{
            image1.image = UIImage(named: "RecordAlert")
            label1.text = "本日の体調記録がされていません"
            RecordAlert = 0
        }else if EnergyAlert == 1{
            image1.image = UIImage(named: "Alert")
            label1.text = "摂取カロリーが制限を超えています"
            EnergyAlert = 0
        }else if LipoidAlert == 1{
            image1.image = UIImage(named: "Alert")
            label1.text = "摂取脂質が制限を超えています"
            LipoidAlert = 0
        }else if RecommendAlert == 1{
            image1.image = UIImage(named: "RecommendAlert")
            label1.text = "レコメンド内容を更新しました。\n美味しいレストランをご案内致します。"
            RecommendAlert = 0
        }
        return cell
    }
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 44
    }
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
    }
    //

    //画面遷移
    func Back(){
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    //
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

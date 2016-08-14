import UIKit
import Parse

class SettingVC: UIViewController,UIToolbarDelegate,UITextFieldDelegate,UIPickerViewDataSource, UIPickerViewDelegate{
    @IBOutlet weak var title1: UILabel!
    @IBOutlet weak var title2: UILabel!
    @IBOutlet weak var textfield: UITextField!
    @IBOutlet weak var label1: UILabel!
    @IBOutlet weak var label2: UILabel!
    @IBOutlet weak var switch1: UISwitch!
    @IBOutlet weak var switch2: UISwitch!
    var Periods = ["過去3日間","過去1週間","過去1ヶ月間","過去3ヶ月間","過去6ヶ月間","過去1年間"]
    var Setting:[String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "設定"
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "戻る", style: .Plain, target: self, action: "Back")
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "保存", style: .Plain, target: self, action: "Save")
        title1.textColor = UIColor.grayColor()
        title2.textColor = UIColor.grayColor()
        label1.textColor = UIColor.grayColor()
        label2.textColor = UIColor.grayColor()
        switch1.tintColor = imageColor
        switch1.onTintColor = imageColor
        switch1.addTarget(self, action: "SwitchChange1:", forControlEvents: .TouchUpInside)
        switch2.tintColor = imageColor
        switch2.onTintColor = imageColor
        switch2.addTarget(self, action: "SwitchChange2:", forControlEvents: .TouchUpInside)
    }
    override func viewDidAppear(animated: Bool) {
        Fetch()
    }
    //Switch設定
    func SetSwitch(){
        if Setting != []{
            if Setting[1] != ""{
                if Int(Setting[1]) == 0{
                    switch1.on = false
                    EnergyFlag = 0
                }else{
                    switch1.on = true
                    EnergyFlag = 1
                }
            }
            if Setting[2] != ""{
                if Int(Setting[2]) == 0{
                    switch2.on = false
                    RestrictionFlag = 0
                }else{
                    switch2.on = true
                    RestrictionFlag = 1
                }
            }
        }
    }
    func SwitchChange1(sender:UISwitch){
        if sender.on {
            EnergyFlag = 1
        }else{
            EnergyFlag = 0
        }
    }
    func SwitchChange2(sender:UISwitch){
        if sender.on {
            RestrictionFlag = 1
        }else{
            RestrictionFlag = 0
        }
    }
    //
    
    
    //TextField設定
    func SetTextField() {
        textfield.delegate = self
        textfield.text = Periods[0]
        
        var selfPicker = UIPickerView()
        selfPicker.delegate = self
        selfPicker.backgroundColor = UIColor.whiteColor()
        
        //UIToolBar設定
        var toolBar = UIToolbar()
        toolBar = UIToolbar(frame: CGRectMake(0, self.view.frame.size.height/6 , self.view.frame.size.width, 40.0))
        toolBar.layer.position = CGPoint(x: self.view.frame.size.width/2, y: self.view.frame.size.height-20.0)
        toolBar.barStyle = .Default
        toolBar.tintColor = imageColor
        toolBar.backgroundColor = UIColor.whiteColor()
        let toolBarBtn = UIBarButtonItem(title: "閉じる", style: .Bordered, target: self, action: "tappedToolBarBtn:")
        toolBarBtn.tintColor = imageColor
        toolBar.items = [toolBarBtn]
        textfield.inputView = selfPicker
        textfield.inputAccessoryView = toolBar
        
        if Setting != []{
            if Setting[0] != ""{
                textfield.text = Periods[Int(Setting[0])!]
            }
        }
    }
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return true
    }
        //UIPicker
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return Periods.count
    }
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String {
        return Periods[row]
    }
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        textfield.text = Periods[row]
        PeriodFlag = Periods.indexOf("\(Periods[row])")!
    }
        //UIToolBar
    func tappedToolBarBtn(sender: UIBarButtonItem) {
        textfield.resignFirstResponder()
    }
    //
    
    // 設定情報取得
    func Fetch() {
        Setting = []
        UIApplication.sharedApplication().networkActivityIndicatorVisible = true
        let queryInfo = PFQuery(className: "AppSetting")
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
                            self.Setting = [
                                object["PeriodFlag"] as! String,
                                object["EnergyFlag"] as! String,
                                object["RestrictionFlag"] as! String,
                                object.objectId!,
                                object["user"].objectId!! as String
                            ]
                            SettingID = object.objectId!
                        }
                    }
                }
            }
            self.SetSwitch()
            self.SetTextField()
            UIApplication.sharedApplication().networkActivityIndicatorVisible = false
        }
    }
    //
    
    
    //画面遷移
    func Back(){
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    //
    //Save
    func Save(){
        RegistrationSetting()
        alertMessage = "アプリ設定が\n保存されました"
        AlertMessage()
        presentViewController(alertController, animated: false, completion: nil)
    }
    //
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

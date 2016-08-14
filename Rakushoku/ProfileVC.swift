import UIKit
import Parse

class ProfileVC: UIViewController,UITextFieldDelegate,UIToolbarDelegate,UIPickerViewDataSource, UIPickerViewDelegate{
    @IBOutlet weak var title1: UILabel!
    @IBOutlet weak var label1: UILabel!
    @IBOutlet weak var title2: UILabel!
    
    @IBOutlet weak var title3: UILabel!
    @IBOutlet weak var label2: UILabel!
    @IBOutlet weak var textfield1: UITextField!
    @IBOutlet weak var textfield2: UITextField!
    
    @IBOutlet weak var textfield3: UITextField!
    @IBOutlet weak var textfield4: UITextField!
    @IBOutlet weak var button1: UIButton!
    @IBOutlet weak var button2: UIButton!
    @IBAction func button1(sender: AnyObject) {
    }
    @IBAction func button2(sender: AnyObject) {
        RegistUserInfo()
        alertMessage = "プロフィールが\n更新されました"
        AlertMessage()
        presentViewController(alertController, animated: true, completion: nil)
    }
    var TextFields: [UITextField] = []
    var temp:[String:String] = [:]
    var UserInfos: [[String:String]] = [[:]]
    var Energy = ""
    var RestrictionFood = ""
    var Elentalfrequency = ""
    var Elentalvolume = ""
    var Setting:[String] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "プロフィール変更"
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "Notification"), style: .Plain, target: self, action: "Next1")
        var QA = UIBarButtonItem(image: UIImage(named: "QA"), style: .Plain, target: self, action: "Next2")
        var Setting = UIBarButtonItem(image: UIImage(named: "Setting"), style: .Plain, target: self, action: "Next3")
        self.navigationItem.rightBarButtonItems = [Setting,QA]

    }
    override func viewDidAppear(animated: Bool) {
        SetObject()
        SetTextFields1()
        FetchUserInfo()
    }
    func SetObject(){
        title1.textColor = UIColor.grayColor()
        title2.textColor = UIColor.grayColor()
        title3.textColor = UIColor.grayColor()
        label1.textColor = UIColor.grayColor()
        label2.textColor = UIColor.grayColor()
        button2.backgroundColor = imageColor
        button2.titleLabel?.textColor = UIColor.whiteColor()
        button2.layer.cornerRadius = 8
    }
    //TextField設定
    func SetTextFields1() {
        textfield1.delegate = self
        textfield1.tag = 1
        textfield1.enabled = true
        TextFields.append(textfield1)
        SetTextField2(textfield1.tag)
        textfield2.delegate = self
        textfield2.tag = 2
        textfield2.enabled = true
        TextFields.append(textfield2)
        SetTextField2(textfield2.tag)
        textfield3.delegate = self
        textfield3.tag = 3
        TextFields.append(textfield3)
        SetTextField2(textfield3.tag)
        textfield4.delegate = self
        textfield4.tag = 4
        TextFields.append(textfield4)
        SetTextField2(textfield4.tag)
    }
    func SetTextField2(Tag:Int) {
        var Picker = UIPickerView()
        Picker.delegate = self
        Picker.backgroundColor = UIColor.whiteColor()
        Picker.tag = Tag
        
        //UIToolBar設定
        var ToolBar = UIToolbar()
        ToolBar = UIToolbar(frame: CGRectMake(0, self.view.frame.size.height/6 , self.view.frame.size.width, 40.0))
        ToolBar.layer.position = CGPoint(x: self.view.frame.size.width/2, y: self.view.frame.size.height-20.0)
        ToolBar.barStyle = .Default
        ToolBar.tintColor = imageColor
        ToolBar.backgroundColor = UIColor.whiteColor()
        let ToolBarBtn = UIBarButtonItem(title: "閉じる", style: .Bordered, target: self, action: "tappedToolBarBtn:")
        ToolBarBtn.tintColor = imageColor
        ToolBarBtn.tag = Tag
        ToolBar.items = [ToolBarBtn]
        ToolBar.tag = Tag
        
        if Tag != 2 {
            TextFields[Tag-1].inputView = Picker
            TextFields[Tag-1].inputAccessoryView = ToolBar
        }
        if UserInfos.count != 0{
            if Energy != ""{
                TextFields[0].text = Energy
                energy = TextFields[0].text!
            }
            if RestrictionFood != ""{
                TextFields[1].text = RestrictionFood
                restrictionfood = TextFields[1].text!
            }
            if Elentalfrequency != ""{
                TextFields[2].text = Elentalfrequency
                elentalfrequency = TextFields[2].text!
            }
            if Elentalvolume != ""{
                TextFields[3].text = Elentalvolume
                elentalvolume = TextFields[3].text!
            }
        }
    }
    //TextFieldDelegate
    func textFieldShouldEndEditing(textField: UITextField) -> Bool {
        if textField.tag == 1{
            energy = textField.text!
        }else if textField.tag == 2{
            restrictionfood = textField.text!
        }else if textField.tag == 3{
            elentalfrequency = textField.text!
        }else if textField.tag == 4{
            elentalvolume = textField.text!
        }
        return true
    }
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    //UIPicker
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView.tag == 1{
            return ENERGY.count
        }else if pickerView.tag == 3{
            return ELENTALFREQUENCY.count
        }else if pickerView.tag == 4{
            return ELENTALVOLUME.count
        }else{
            return 0
        }
    }
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String {
        if pickerView.tag == 1{
            return String(ENERGY[row])
        }else if pickerView.tag == 3{
            return ELENTALFREQUENCY[row]
        }else if pickerView.tag == 4{
            return String(ELENTALVOLUME[row])
        }else{
            return ""
        }
    }
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView.tag == 1{
            TextFields[pickerView.tag - 1].text = String(ENERGY[row])
        }else if pickerView.tag == 3{
            TextFields[pickerView.tag - 1].text = ELENTALFREQUENCY[row]
        }else if pickerView.tag == 4{
            TextFields[pickerView.tag - 1].text = String(ELENTALVOLUME[row])
        }
    }
    //UIToolBar
    func tappedToolBarBtn(sender: UIBarButtonItem) {
        TextFields[sender.tag - 1].resignFirstResponder()
    }
    //
    
    //ユーザー取得
    func FetchUserInfo(){
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
                                "elentalfrequency":object["elentalfrequency"] as! String,
                                "elentalvolume":object["elentalvolume"] as! String,
                                "date":String(object.createdAt)
                            ]
                            self.UserInfos.append(self.temp)
                        }
                    }
                }
                if self.UserInfos.count != 0{
                    for U in self.UserInfos{
                        if U["energy"] != nil && U["energy"] != ""{
                            self.Energy = U["energy"]!
                        }
                        if U["restrictionfood"] != nil && U["restrictionfood"] != ""{
                            self.RestrictionFood = U["restrictionfood"]!
                        }
                        if U["elentalfrequency"] != nil && U["elentalfrequency"] != ""{
                            self.Elentalfrequency = U["elentalfrequency"]!
                        }
                        if U["elentalvolume"] != nil && U["elentalvolume"] != ""{
                            self.Elentalvolume = U["elentalvolume"]!
                        }
                    }
                }
                self.SetTextFields1()
                self.FetchSetting()
                UIApplication.sharedApplication().networkActivityIndicatorVisible = false
            }
        }
    }
    // 設定情報取得
    func FetchSetting() {
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
            if self.Setting.count != 0{
                if self.Setting[1] == "0"{
                    energy = ""
                    self.textfield1.text = ""
                    self.textfield1.enabled = false
                }else if self.Setting[2] == "0"{
                    restrictionfood = ""
                    self.textfield2.text = ""
                    self.textfield2.enabled = false
                }
            }
        }
        UIApplication.sharedApplication().networkActivityIndicatorVisible = false
    }
    //
    
    //画面遷移系
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

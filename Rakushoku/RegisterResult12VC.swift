import UIKit

class RegisterResult12VC: UIViewController,UITextFieldDelegate,UIToolbarDelegate,UIPickerViewDataSource, UIPickerViewDelegate{
    var X:CGFloat!
    var Y:CGFloat!
    @IBOutlet weak var label1: UILabel!
    @IBOutlet weak var label2: UILabel!
    @IBOutlet weak var textfield1: UITextField!
    @IBOutlet weak var textfield2: UITextField!
    @IBOutlet weak var button1: UIButton!
    @IBAction func button1(sender: AnyObject) {
        if FoodCategory != "" && FoodName != ""{
            self.performSegueWithIdentifier("Next", sender: nil)
        }else{
            alertMessage = "カテゴリ・料理名は\n入力必須です"
            AlertMessage()
            presentViewController(alertController, animated: true, completion: nil)
        }
    }
    var TextFields: [UITextField] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        X = self.view.bounds.width
        Y = self.view.bounds.height
        var title = "最も適切な料理名を\n選択して下さい。"
        setLabel(X*(8/10), frameY: Y*(1/8), tag: 0, text: title, fontSize: 16, layerX: X*(1/2), layerY: Y*(1/8), view: self.view)
        label1.textColor = imageColor
        label2.textColor = imageColor
        button1.layer.cornerRadius = 4
        button1.layer.borderColor = UIColor.clearColor().CGColor
        button1.backgroundColor = imageColor
        textfield1.delegate = self
        textfield1.tag = 1
        TextFields.append(textfield1)
        SetTextField(textfield1.tag)
        textfield2.delegate = self
        textfield2.tag = 2
        TextFields.append(textfield2)
        SetTextField(textfield2.tag)
    }
    override func viewDidAppear(animated: Bool) {
        FoodCategory = ""
        FoodName = ""
    }
    //TextField設定
    func SetTextField(Tag:Int) {
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
        
        TextFields[Tag-1].inputView = Picker
        TextFields[Tag-1].inputAccessoryView = ToolBar
    }
    func textFieldShouldEndEditing(textField: UITextField) -> Bool {
        if textField.tag == 1{
            FoodCategory = textField.text!
        }else if textField.tag == 2{
            FoodName = textField.text!
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
        if pickerView.tag  == 1{
            return FOODCATEGORY.count
        }else {
            if FOODCATEGORY.indexOf(TextFields[0].text!) != nil{
            if FOODCATEGORY.indexOf(TextFields[0].text!)! == 0{
                return FOODNAME0.count
            }else if FOODCATEGORY.indexOf(TextFields[0].text!)! == 1{
                return FOODNAME1.count
            }else if FOODCATEGORY.indexOf(TextFields[0].text!)! == 2{
                return FOODNAME2.count
            }else if FOODCATEGORY.indexOf(TextFields[0].text!)! == 3{
                return FOODNAME3.count
            }else if FOODCATEGORY.indexOf(TextFields[0].text!)! == 4{
                return FOODNAME4.count
            }else if FOODCATEGORY.indexOf(TextFields[0].text!)! == 5{
                return FOODNAME5.count
            }
            }
            return 1
        }
    }
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String {
        if pickerView.tag  == 1{
            return FOODCATEGORY[row]
        }else {
            if FOODCATEGORY.indexOf(TextFields[0].text!) != nil{
            if FOODCATEGORY.indexOf(TextFields[0].text!)! == 0{
                return FOODNAME0[row]
            }else if FOODCATEGORY.indexOf(TextFields[0].text!)! == 1{
                return FOODNAME1[row]
            }else if FOODCATEGORY.indexOf(TextFields[0].text!)! == 2{
                return FOODNAME2[row]
            }else if FOODCATEGORY.indexOf(TextFields[0].text!)! == 3{
                return FOODNAME3[row]
            }else if FOODCATEGORY.indexOf(TextFields[0].text!)! == 4{
                return FOODNAME4[row]
            }else if FOODCATEGORY.indexOf(TextFields[0].text!)! == 5{
                return FOODNAME5[row]
            }
        }
            return "カテゴリを選択して下さい"
        }
    }
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView.tag  == 1{
            TextFields[pickerView.tag - 1].text = FOODCATEGORY[row]
        }else {
            if FOODCATEGORY.indexOf(TextFields[0].text!) != nil{
            if FOODCATEGORY.indexOf(TextFields[0].text!)! == 0{
                TextFields[pickerView.tag - 1].text = FOODNAME0[row]
            }else if FOODCATEGORY.indexOf(TextFields[0].text!)! == 1{
                TextFields[pickerView.tag - 1].text = FOODNAME1[row]
            }else if FOODCATEGORY.indexOf(TextFields[0].text!)! == 2{
                TextFields[pickerView.tag - 1].text = FOODNAME2[row]
            }else if FOODCATEGORY.indexOf(TextFields[0].text!)! == 3{
                TextFields[pickerView.tag - 1].text = FOODNAME3[row]
            }else if FOODCATEGORY.indexOf(TextFields[0].text!)! == 4{
                TextFields[pickerView.tag - 1].text = FOODNAME4[row]
            }else if FOODCATEGORY.indexOf(TextFields[0].text!)! == 5{
                TextFields[pickerView.tag - 1].text = FOODNAME5[row]
            }
            }
            TextFields[pickerView.tag - 1].placeholder = "カテゴリを選択して下さい"
        }
    }
    //UIToolBar
    func tappedToolBarBtn(sender: UIBarButtonItem) {
        TextFields[sender.tag - 1].resignFirstResponder()
    }
    //
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}


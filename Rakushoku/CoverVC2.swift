//
//  CoverVC.swift
//  FoodHealth2
//
//  Created by 安高慎也 on 2016/08/09.
//  Copyright © 2016年 shinya.adaka. All rights reserved.
//

import UIKit

class CoverVC2: UIViewController,UITextFieldDelegate,UIToolbarDelegate,UIPickerViewDataSource, UIPickerViewDelegate{
    @IBOutlet weak var label1: UILabel!
    @IBOutlet weak var label2: UILabel!
    @IBOutlet weak var label3: UILabel!
    @IBOutlet weak var label4: UILabel!
    @IBOutlet weak var textfield1: UITextField!
    @IBOutlet weak var textfield2: UITextField!
    @IBOutlet weak var textfield3: UITextField!
    @IBOutlet weak var textfield4: UITextField!
    @IBOutlet weak var textfield5: UITextField!
    @IBOutlet weak var button1: UIButton!
    @IBAction func button1(sender: AnyObject) {
        RegistUserInfo()
        alertMessage = "ユーザー情報が\n登録されました"
        UIAlertController.appearance().tintColor = imageColor
        alertController = UIAlertController(title: "", message: alertMessage, preferredStyle: .Alert)
        let action = UIAlertAction(title: "OK", style: .Default) { Void in
            let registervc = self.storyboard?.instantiateViewControllerWithIdentifier("FirstView")
            self.presentViewController(registervc!, animated: true, completion: nil)
        }
        alertController.addAction(action)
        presentViewController(alertController, animated: false, completion: nil)
    }
    @IBOutlet weak var button2: UIButton!
    @IBAction func button2(sender: AnyObject) {
        let registervc = self.storyboard?.instantiateViewControllerWithIdentifier("FirstView")
        self.presentViewController(registervc!, animated: true, completion: nil)
    }
    var TextFields: [UITextField] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "FoodHealthへようこそ！"
        label1.textColor = imageColor
        label2.textColor = imageColor
        label3.textColor = imageColor
        label4.textColor = imageColor
        button1.backgroundColor = imageColor
        button1.layer.cornerRadius = 4
        button1.layer.borderColor = UIColor.clearColor().CGColor
        button2.layer.cornerRadius = 4
        button2.layer.borderColor = UIColor.clearColor().CGColor
        button2.backgroundColor = UIColor.whiteColor()
        button2.setTitleColor(imageColor, forState: .Normal)
        textfield1.delegate = self
        textfield1.tag = 1
        TextFields.append(textfield1)
        SetTextField(textfield1.tag)
        textfield2.delegate = self
        textfield2.tag = 2
        TextFields.append(textfield2)
        SetTextField(textfield2.tag)
        textfield3.delegate = self
        textfield3.tag = 3
        TextFields.append(textfield3)
        SetTextField(textfield3.tag)
        textfield4.delegate = self
        textfield4.tag = 4
        TextFields.append(textfield4)
        SetTextField(textfield4.tag)
        textfield5.delegate = self
        textfield5.tag = 5
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
        
        var DatePicker = UIDatePicker()
        DatePicker.addTarget(self, action: "changedDateEvent:", forControlEvents: UIControlEvents.ValueChanged)
        DatePicker.datePickerMode = UIDatePickerMode.Date
        DatePicker.backgroundColor = UIColor.whiteColor()
        DatePicker.date = NSDate()
        DatePicker.tag = Tag
        if Tag == 1{
            TextFields[Tag-1].inputView = DatePicker
        }
    }
    func textFieldShouldEndEditing(textField: UITextField) -> Bool {
        if textField.tag == 1{
            birthday = textField.text!
        }else if textField.tag == 2{
            height = textField.text!
        }else if textField.tag == 3{
            weight = textField.text!
        }else if textField.tag == 4{
            energy = textField.text!
        }else if textField.tag == 5{
            restrictionfood = textField.text!
        }
        return true
    }
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
        //UIPicker
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        if pickerView.tag == 1{
            return 3
        }else{
            return 1
        }
    }
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView.tag == 1{
            return BIRTHDAY.count
        }else if pickerView.tag == 2{
            return HEIGHT.count
        }else if pickerView.tag == 3{
            return WEIGHT.count
        }else {
            return ENERGY.count
        }
    }
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String {
        if pickerView.tag == 1{
            return String(BIRTHDAY[row])
        }else if pickerView.tag == 2{
            return String(HEIGHT[row])
        }else if pickerView.tag == 3{
            return String(WEIGHT[row])
        }else {
            return "約 " + String(ENERGY[row]) + " kcal"
        }
    }
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView.tag == 1{
            TextFields[pickerView.tag - 1].text = String(BIRTHDAY[row])
        }else if pickerView.tag == 2{
            TextFields[pickerView.tag - 1].text = String(HEIGHT[row])
        }else if pickerView.tag == 3{
            TextFields[pickerView.tag - 1].text = String(WEIGHT[row])
        }else {
            TextFields[pickerView.tag - 1].text = "約 " + String(ENERGY[row]) + " kcal"
        }
    }
        //UIToolBar
    func tappedToolBarBtn(sender: UIBarButtonItem) {
        TextFields[sender.tag - 1].resignFirstResponder()
    }
        //DatePicker
    func changedDateEvent(sender:UIDatePicker){
        var dateSelecter: UIDatePicker = sender
        self.changeLabelDate(sender.date)
    }
    func changeLabelDate(date:NSDate) {
        TextFields[0].text = self.dateToString(date)
    }
    func dateToString(date:NSDate) ->String {
        var calender: NSCalendar = NSCalendar(calendarIdentifier: NSGregorianCalendar)!
        var comps: NSDateComponents = calender.components(NSCalendarUnit.Year,fromDate: date)
        var date_formatter: NSDateFormatter = NSDateFormatter()
        date_formatter.locale     = NSLocale(localeIdentifier: "ja")
        date_formatter.dateFormat = "yyyy"
        date_formatter.dateFormat = "MM"
        date_formatter.dateFormat = "dd"
        date_formatter.dateFormat = "yyyy年MM月dd日"
        return date_formatter.stringFromDate(date)
    }
    //
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

//
//  TodayRecordVC.swift
//  FoodHealth2
//
//  Created by 安高慎也 on 2016/08/07.
//  Copyright © 2016年 shinya.adaka. All rights reserved.
//

import UIKit

class TodayRecordVC: UIViewController,UITextFieldDelegate,UIToolbarDelegate,UIPickerViewDataSource, UIPickerViewDelegate{
    @IBOutlet weak var image1: UIImageView!
    @IBOutlet weak var image2: UIImageView!
    
    @IBOutlet weak var text11: UILabel!
    @IBOutlet weak var text12: UILabel!
    @IBOutlet weak var text21: UILabel!
    @IBOutlet weak var text22: UILabel!
    @IBOutlet weak var text31: UILabel!
    @IBOutlet weak var text41: UILabel!
    @IBOutlet weak var text51: UILabel!
    @IBOutlet weak var text61: UILabel!
    @IBOutlet weak var text62: UILabel!
    @IBOutlet weak var text71: UILabel!
    @IBOutlet weak var text72: UILabel!
    @IBOutlet weak var text81: UILabel!
    @IBOutlet weak var text82: UILabel!
    
    @IBOutlet weak var textfield1: UITextField!
    @IBOutlet weak var textfield2: UITextField!
    @IBOutlet weak var textfield3: UITextField!
    @IBOutlet weak var textfield4: UITextField!
    @IBOutlet weak var textfield5: UITextField!
    @IBOutlet weak var textfield6: UITextField!
    @IBOutlet weak var textfield7: UITextField!
    @IBOutlet weak var textfield8: UITextField!
    
    @IBOutlet weak var button1: UIButton!
    @IBAction func button1(sender: AnyObject) {
        RegistUserInfo()
        alertMessage = "今日の記録が\n登録されました"
        AlertMessage()
        presentViewController(alertController, animated: true, completion: nil)
    }
    var Labels:[UILabel] = []
    var TextFields:[UITextField] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        SetObject()
    }
    override func viewDidAppear(animated: Bool) {
    }
    
    func SetObject(){
        self.navigationItem.title = "今日の記録"
        Labels.append(text11)
        Labels.append(text12)
        Labels.append(text21)
        Labels.append(text22)
        Labels.append(text31)
        Labels.append(text41)
        Labels.append(text51)
        Labels.append(text61)
        Labels.append(text62)
        Labels.append(text71)
        Labels.append(text72)
        Labels.append(text81)
        Labels.append(text82)
        for L in Labels{
            L.textColor = UIColor.grayColor()
        }
        
        button1.backgroundColor = imageColor
        button1.titleLabel?.textColor = UIColor.whiteColor()
        button1.layer.cornerRadius = 8
        
        TextFields.append(textfield1)
        TextFields.append(textfield2)
        TextFields.append(textfield3)
        TextFields.append(textfield4)
        TextFields.append(textfield5)
        TextFields.append(textfield6)
        TextFields.append(textfield7)
        TextFields.append(textfield8)
        var i = 1
        for T in TextFields{
            T.delegate = self
            T.tag = i
            SetTextField(i)
            i++
        }
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
            height = textField.text!
        }else if textField.tag == 2{
            weight = textField.text!
        }else if textField.tag == 3{
            condition = textField.text!
        }else if textField.tag == 4{
            abdominalgia = textField.text!
        }else if textField.tag == 5{
            bowel = textField.text!
        }else if textField.tag == 6{
            heartrate = textField.text!
        }else if textField.tag == 7{
            bloodpressure = textField.text!
        }else if textField.tag == 8{
            glucoselevel = textField.text!
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
            return HEIGHT.count
        }else if pickerView.tag == 2{
            return WEIGHT.count
        }else if pickerView.tag == 3{
            return CONDITION.count
        }else if pickerView.tag == 4{
            return ABDOMINALGIA.count
        }else if pickerView.tag == 5{
            return BOWEL.count
        }else if pickerView.tag == 6{
            return HEARTRATE.count
        }else if pickerView.tag == 7{
            return BLOODPRESSURE.count
        }else {
            return GLUCOSELEVEL.count
        }
    }
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String {
        if pickerView.tag == 1{
            return String(HEIGHT[row])
        }else if pickerView.tag == 2{
            return String(WEIGHT[row])
        }else if pickerView.tag == 3{
            return String(CONDITION[row])
        }else if pickerView.tag == 4{
            return String(ABDOMINALGIA[row])
        }else if pickerView.tag == 5{
            return String(BOWEL[row])
        }else if pickerView.tag == 6{
            return String(HEARTRATE[row])
        }else if pickerView.tag == 7{
            return String(BLOODPRESSURE[row])
        }else {
            return String(GLUCOSELEVEL[row])
        }
    }
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView.tag == 1{
            TextFields[pickerView.tag - 1].text = String(HEIGHT[row])
        }else if pickerView.tag == 2{
            TextFields[pickerView.tag - 1].text = String(WEIGHT[row])
        }else if pickerView.tag == 3{
            TextFields[pickerView.tag - 1].text = String(CONDITION[row])
        }else if pickerView.tag == 4{
            TextFields[pickerView.tag - 1].text = String(ABDOMINALGIA[row])
        }else if pickerView.tag == 5{
            TextFields[pickerView.tag - 1].text = String(BOWEL[row])
        }else if pickerView.tag == 6{
            TextFields[pickerView.tag - 1].text = String(HEARTRATE[row])
        }else if pickerView.tag == 7{
            TextFields[pickerView.tag - 1].text = String(BLOODPRESSURE[row])
        }else {
            TextFields[pickerView.tag - 1].text = String(GLUCOSELEVEL[row])
        }
    }
    //UIToolBar
    func tappedToolBarBtn(sender: UIBarButtonItem) {
        TextFields[sender.tag - 1].resignFirstResponder()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}



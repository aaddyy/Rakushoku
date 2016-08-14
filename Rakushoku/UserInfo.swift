import UIKit
import Parse

class UserInfo: NSObject {
    
    var username:String
    var purpose:String
    var birthday:String
    var height:String
    var weight:String
    var condition:String
    var heartrate:String
    var bloodpressure:String
    var energy:String
    var restrictionfood:String
    var glucoselevel:String
    var abdominalgia:String
    var bowel:String
    var blood:String
    var bmi:String
    var elentalfrequency:String
    var elentalvolume:String
    
    init(username:String, purpose:String, birthday:String, height:String, weight:String, condition:String, heartrate:String, bloodpressure:String, energy:String, restrictionfood:String, glucoselevel:String, abdominalgia:String, bowel:String, blood:String, bmi:String, elentalfrequency:String, elentalvolume:String){
        self.username = username
        self.purpose = purpose
        self.birthday = birthday
        self.height = height
        self.weight = weight
        self.condition = condition
        self.heartrate = heartrate
        self.bloodpressure = bloodpressure
        self.energy = energy
        self.restrictionfood = restrictionfood
        self.glucoselevel = glucoselevel
        self.abdominalgia = abdominalgia
        self.bowel = bowel
        self.blood = blood
        self.bmi = bmi
        self.elentalfrequency = elentalfrequency
        self.elentalvolume = elentalvolume
    }
    
    //Parseへ保存
    func save(){
        let Obj = PFObject(className: "UserInfo")
        Obj["username"] = username
        Obj["purpose"] = purpose
        Obj["birthday"] = birthday
        Obj["height"] = height
        Obj["weight"] = weight
        Obj["condition"] = condition
        Obj["heartrate"] = heartrate
        Obj["bloodpressure"] = bloodpressure
        Obj["energy"] = energy
        Obj["restrictionfood"] = restrictionfood
        Obj["glucoselevel"] = glucoselevel
        Obj["abdominalgia"] = abdominalgia
        Obj["bowel"] = bowel
        Obj["blood"] = blood
        Obj["bmi"] = bmi
        Obj["elentalfrequency"] = elentalfrequency
        Obj["elentalvolume"] = elentalvolume
        Obj["user"] = PFUser.currentUser()
        Obj.saveInBackgroundWithBlock { (success, error) in
            if success{
                print("保存成功")
            }
        }
    }
}
import UIKit
import Parse
import AVFoundation
import Alamofire
import SwiftyJSON
import CoreData

//保存
func RegistrationSetting(){
    if SettingID != ""{
        let queryInfo = PFQuery(className: "AppSetting")
        queryInfo.getObjectInBackgroundWithId(SettingID, block: { (object, error) -> Void in
            object!["PeriodFlag"] = String(PeriodFlag)
            object!["EnergyFlag"] = String(EnergyFlag)
            object!["RestrictionFlag"] = String(RestrictionFlag)
            object?.saveInBackground()
        })
    }else{
        let mySetting = AppSetting(PeriodFlag: String(PeriodFlag), EnergyFlag: String(EnergyFlag), RestrictionFlag: String(RestrictionFlag))
        mySetting.save()
    }
}

func RegistrationRecord(){
    let Record = TodayRecord(height: height, weight: weight, condition: condition, heartrate: heartrate, bloodpressure: bloodpressure)
    Record.save()
}

func RegistrationProfile(){
    let Profile = ProfileRecord(energy: energy, restrictionfood:restrictionfood)
    Profile.save()
}

func RegistUserInfo(){
    if height !=  "" && weight != ""{
        var resultbmi = Double(weight)! / ((Double(height)!/100) * (Double(height)!/100))
        bmi = String(Int(round(resultbmi)))
    }
    let userinfo = UserInfo(username: username, purpose: purpose, birthday: birthday, height: height, weight: weight, condition: condition, heartrate: heartrate, bloodpressure: bloodpressure, energy: energy, restrictionfood: restrictionfood, glucoselevel: glucoselevel, abdominalgia: abdominalgia, bowel: bowel, blood: blood, bmi:bmi, elentalfrequency:elentalfrequency,elentalvolume: elentalvolume)
    userinfo.save()
}
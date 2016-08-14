import UIKit
import Parse

class AppSetting: NSObject {
    var user: User?
    var PeriodFlag:String
    var EnergyFlag:String
    var RestrictionFlag:String
    
    init(PeriodFlag: String, EnergyFlag: String, RestrictionFlag: String){
        self.PeriodFlag = PeriodFlag
        self.EnergyFlag = EnergyFlag
        self.RestrictionFlag = RestrictionFlag
    }
    
    func save(){
        let AppSettingObj = PFObject(className: "AppSetting")
        AppSettingObj["PeriodFlag"] = PeriodFlag
        AppSettingObj["EnergyFlag"] = EnergyFlag
        AppSettingObj["RestrictionFlag"] = RestrictionFlag
        AppSettingObj["user"] = PFUser.currentUser()
        AppSettingObj.saveInBackgroundWithBlock { (success, error) in
            if success{
            }
        }
    }
}
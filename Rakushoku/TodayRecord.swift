import UIKit
import Parse

class TodayRecord: NSObject {
    
    var height: String
    var weight: String
    var condition: String
    var heartrate: String
    var bloodpressure: String
    
    init(height: String, weight: String, condition: String, heartrate:String, bloodpressure:String) {
        self.height = height
        self.weight = weight
        self.condition = condition
        self.heartrate = heartrate
        self.bloodpressure = bloodpressure
    }
    
    //Parseへ保存
    func save(){
        let RecordObj = PFObject(className: "TodayRecord")
        RecordObj["height"] = height
        RecordObj["weight"] = weight
        RecordObj["condition"] = condition
        RecordObj["heartrate"] = heartrate
        RecordObj["bloodpressure"] = bloodpressure
        RecordObj.saveInBackgroundWithBlock { (success, error) in
            if success{
            }
        }
    }
}
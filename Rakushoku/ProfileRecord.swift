import UIKit
import Parse

class ProfileRecord: NSObject {
    
    var energy: String
    var restrictionfood: String
    
    init(energy: String, restrictionfood: String) {
        self.energy = energy
        self.restrictionfood = restrictionfood
    }
    
    //Parseへ保存
    func save(){
        let ProfileObj = PFObject(className: "Profile")
        ProfileObj["energy"] = energy
        ProfileObj["restrictionfood"] = restrictionfood
        ProfileObj.saveInBackgroundWithBlock { (success, error) in
            if success{
            }
        }
    }
}
import UIKit
import SwiftyJSON
import Alamofire
import AlamofireImage
import Parse

class VC2: UIViewController{
    var URL = "https://app.rakuten.co.jp/services/api/Recipe/CategoryList/20121121?applicationId=1023537473467057383&categoryType=small"
    var menus:[[String:String]] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getMenus()
    }
    override func viewDidAppear(animated: Bool) {
    }
    @IBAction func regist(sender: AnyObject) {
        for(var i = 0; i < menus.count; i++){
        let category = Category(categoryId: menus[i]["categoryId"]!, categoryName: menus[i]["categoryName"]!, categoryUrl: menus[i]["categoryUrl"]!)
        category.save()
        }
    }
    
    //APIから情報取得
    func getMenus(){
        UIApplication.sharedApplication().networkActivityIndicatorVisible = true
        Alamofire.request(.GET, URL)
            .responseJSON{ response in
                guard let object = response.result.value else{
                    return
                }
                let json = JSON(object)
                json["result"]["small"].forEach{(i, json) in
                    let menu: [String: String] = [
                        "categoryId": String(json["categoryId"]),
                        "categoryName": json["categoryName"].string!,
                        "categoryUrl": json["categoryUrl"].string!
                    ]
                    self.menus.append(menu)
                }
                UIApplication.sharedApplication().networkActivityIndicatorVisible = false
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}



import UIKit
import SwiftyJSON
import Alamofire
import AlamofireImage
import Parse

class RecipeDetailVC: UIViewController, UITableViewDataSource, UITableViewDelegate {
    var menus: [[String: String]] = []
    var DetailTableview: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "レシピ一覧"
    }
    override func viewDidAppear(animated: Bool) {
        getMenus()
        DetailTableview = UITableView()
        DetailTableview.frame = CGRectMake(0, 16, self.view.bounds.width, self.view.bounds.height - 16)
        DetailTableview.registerNib(UINib(nibName: "RecipeTVC", bundle: nil), forCellReuseIdentifier: "RecipeTVC")
        DetailTableview.dataSource = self
        DetailTableview.delegate = self
        self.view.addSubview(DetailTableview)
        self.DetailTableview.reloadData()
    }
    
    //APIから情報取得
    func getMenus(){
        UIApplication.sharedApplication().networkActivityIndicatorVisible = true
        Alamofire.request(.GET, currentUrl)
            .responseJSON{ response in
                guard let object = response.result.value else{
                    return
                }
                let json = JSON(object)
                json["result"].forEach{(i, json) in
                    let menu: [String: String] = [
                        "title": json["recipeTitle"].string!,
                        "recipeUrl": json["recipeUrl"].string!,
                        "foodimageurl": json["foodImageUrl"].string!,
                        "description": json["recipeDescription"].string!,
                        "time": json["recipeIndication"].string!,
                        "cost": json["recipeCost"].string!,
                        "rank": json["rank"].string!
                    ]
                    self.menus.append(menu)
                }
                UIApplication.sharedApplication().networkActivityIndicatorVisible = false
                self.DetailTableview.reloadData()
        }
    }
    
    //TableViewの設定
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = self.DetailTableview.dequeueReusableCellWithIdentifier("RecipeTVC")! as UITableViewCell
        //画像の処理
        if menus.count != 0{
            let menuImage = cell.viewWithTag(1) as! UIImageView
            let url = NSURL(string: menus[indexPath.row]["foodimageurl"]!)
            menuImage.af_setImageWithURL(url!)

            let menuLabel = cell.viewWithTag(2) as! UILabel
            menuLabel.text = menus[indexPath.row]["title"]!
        }
        return cell
    }
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 128
    }
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        CurrentURL = self.menus[indexPath.row]["recipeUrl"]!
        self.performSegueWithIdentifier("Next", sender: nil)
    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}



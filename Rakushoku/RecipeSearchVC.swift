import UIKit
import SwiftyJSON
import Alamofire
import AlamofireImage
import Parse

class RecipeSearchVC: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate, UISearchControllerDelegate {
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    var menus: [[String: String]] = []
    var Category: [[String: String]] = []
    var filteredSearch = [Search]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "レシピ検索"
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "Notification"), style: .Plain, target: self, action: "Next1")
        var QA = UIBarButtonItem(image: UIImage(named: "QA"), style: .Plain, target: self, action: "Next2")
        var Setting = UIBarButtonItem(image: UIImage(named: "Setting"), style: .Plain, target: self, action: "Next3")
        self.navigationItem.rightBarButtonItems = [Setting,QA]
    }
    
    override func viewDidAppear(animated: Bool) {
        // サーチコントローラ設定
        self.searchBar.delegate = self
        searchBar.searchBarStyle = UISearchBarStyle.Default
        searchBar.layer.borderColor = UIColor.clearColor().CGColor
        searchBar.backgroundColor = UIColor.whiteColor()
        searchBar.layer.borderColor = UIColor.whiteColor().CGColor
        searchBar.layer.borderWidth = 1.0
        searchBar.barTintColor = imageColor
        searchBar.tintColor = imageColor
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.registerNib(UINib(nibName: "RecipeTVC", bundle: nil), forCellReuseIdentifier: "RecipeTVC")
        self.tableView.reloadData()
        
        //let tap = UITapGestureRecognizer(target: self, action: Selector("handleTap:"))
        //self.view.addGestureRecognizer(tap)
    }
    
    //Parse上のカテゴリ情報取得
    func fetchCategory(){
        UIApplication.sharedApplication().networkActivityIndicatorVisible = true
        //検索文字列のスペースを判別
        var tempArray:[String] = []
        let tempText = self.searchBar.text!
        if (tempText.rangeOfString(" ") != nil){
            tempArray = tempText.componentsSeparatedByString(" ")
        }else if (tempText.rangeOfString("　") != nil){
            tempArray = tempText.componentsSeparatedByString("　")
        }else{
            tempArray.append(tempText)
        }
        let count = tempArray.count
        //
        
        let limit = 3
        for(var j=0; j < limit+1; j++){
            let queryInfo = PFQuery(className: "Category")
            queryInfo.limit = 1000
            queryInfo.skip = 1000*j
            queryInfo.findObjectsInBackgroundWithBlock { (objects, error) in
                if error == nil {
                    for object in objects! {
                        UIApplication.sharedApplication().networkActivityIndicatorVisible = true
                        let exist = object["categoryName"] as! String
                        var check = 0
                        
                        for (var i=0; i < count; i++){
                            if (exist.rangeOfString(tempArray[i] ) != nil){
                                check++
                            }
                        }
                        if (check == count){
                            let temp: [String: String] = [
                                "name": (object["categoryName"]! as? String)!,
                                "url": (object["categoryUrl"]! as? String)!
                            ]
                            self.Category.append(temp)
                            self.tableView.reloadData()
                            UIApplication.sharedApplication().networkActivityIndicatorVisible = false
                        }
                    }
                    UIApplication.sharedApplication().networkActivityIndicatorVisible = false
                }
            }
        }
    }
    
    //searchbarのdelegate系
    func searchBarSearchButtonClicked(searchBar: UISearchBar) {
        Category = []
        fetchCategory()
        self.view.endEditing(true)
    }
    //GestureRecognizerが載っているので、cellタップが認識されるように記載
//    func handleTap(sender : UITapGestureRecognizer) {
//        self.view.endEditing(true)
//        let touch = sender.locationInView(tableView)
//        if let indexPath = tableView.indexPathForRowAtPoint(touch) {
//            let temp = (self.Category[indexPath.row]["url"]! as NSString).substringFromIndex(37) as String
//            let endPoint = temp.characters.count - 1
//            let str = (temp as NSString).substringToIndex(endPoint)
//            let ForAddUrl = "https://app.rakuten.co.jp/services/api/Recipe/CategoryList/20121121?format=json&applicationId=1059767517344748188&categoryId=" + str
//            currentUrl = ForAddUrl
//            self.performSegueWithIdentifier("Next", sender: nil)
//        }
//    }
    //
    
    //tableview設定
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Category.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCellWithIdentifier("RecipeTVC")! as UITableViewCell
        if Category.count != 0 {
            cell.textLabel!.text = Category[indexPath.row]["name"]!
        }else{
            cell.textLabel!.text = ""
        }
        //画像の処理
        if menus.count != 0{
            let url = NSURL(string: menus[indexPath.row]["foodimageurl"]!)
            cell.imageView?.af_setImageWithURL(url!)
        }
        cell.selectionStyle = UITableViewCellSelectionStyle.None
        return cell
    }
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 32
    }
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let temp = (self.Category[indexPath.row]["url"]! as NSString).substringFromIndex(37) as String
        let endPoint = temp.characters.count - 1
        let str = (temp as NSString).substringToIndex(endPoint)
        let ForAddUrl = "https://app.rakuten.co.jp/services/api/Recipe/CategoryRanking/20121121?format=json&applicationId=1023537473467057383&categoryId=" + str
        currentUrl = ForAddUrl
        self.performSegueWithIdentifier("Next", sender: nil)
    }
    //
    
    //画面遷移系
    func Next1(){
        let registervc = self.storyboard?.instantiateViewControllerWithIdentifier("NotificationVC")
        self.presentViewController(registervc!, animated: true, completion: nil)
    }
    func Next2(){
        let registervc = self.storyboard?.instantiateViewControllerWithIdentifier("WatsonVC")
        self.presentViewController(registervc!, animated: true, completion: nil)
    }
    func Next3(){
        let registervc = self.storyboard?.instantiateViewControllerWithIdentifier("SettingVC")
        self.presentViewController(registervc!, animated: true, completion: nil)
    }
    //
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
}




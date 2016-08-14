import UIKit
import SwiftyJSON
import Alamofire
import AlamofireImage
import Parse
import CoreLocation
import MapKit

class RestaurantVC: UIViewController,CLLocationManagerDelegate,UITableViewDelegate, UITableViewDataSource,UISearchBarDelegate,MKMapViewDelegate{
    var Restaurants: [[String: String?]] = []
    var myLocationManager:CLLocationManager!
    var CurrentLocation: CLLocationCoordinate2D!
    var Url = ""
    var CurrentLongitude:CLLocationDegrees!
    var CurrentLatitude:CLLocationDegrees!
    var ToLongitude:CLLocationDegrees!
    var ToLatitude:CLLocationDegrees!
    var FromLocation: CLLocation!
    var ToLocation:CLLocation!
    var Distance:CLLocationDistance!
    var DistanceInt:Int!
    var DistanceStr:String!
    var TableView: UITableView!
    var DataFlag = 0
    var FetchTimeFlag = 0
    var MapImageFrag = 0
    var mapView: MKMapView!
    var cell:UITableViewCell!
    var image1:UIImageView!
    var label1:UILabel!
    var label2:UILabel!
    var label3:UILabel!
    var scrollView:UIScrollView!
    var width:CGFloat!
    var height:CGFloat!
    var pageControl1:UIPageControl!
    var pageControl2:UIPageControl!
    var ForTag = 0
    var myAnnotationView: MKAnnotationView!
    var Annotations:[MKPointAnnotation] = []
    var myPin: MKPointAnnotation!
    var tempNumber = 0
    var kakunin = 0

    @IBOutlet weak var searchBar: UISearchBar!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "店検索"
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "Notification"), style: .Plain, target: self, action: "Next1")
        var QA = UIBarButtonItem(image: UIImage(named: "QA"), style: .Plain, target: self, action: "Next2")
        var Setting = UIBarButtonItem(image: UIImage(named: "Setting"), style: .Plain, target: self, action: "Next3")
        self.navigationItem.rightBarButtonItems = [Setting,QA]
    }
    override func viewDidAppear(animated: Bool) {
        SetSearch()
        SetLocation()
        getResults()
    }
    
    //ScrollView設定
    func SetScroll(){
        width = self.view.bounds.width
        scrollView = UIScrollView()
        scrollView.frame = CGRectMake(0, 44, self.view.bounds.width, self.view.bounds.height - 44)
        scrollView.showsHorizontalScrollIndicator = false;
        scrollView.showsVerticalScrollIndicator = false
        scrollView.pagingEnabled = true
        scrollView.delegate = self
        scrollView.contentSize = CGSizeMake(2 * width, 0)
        self.view.addSubview(scrollView)
        
        // PageControlを作成する.
        pageControl1 = UIPageControl()
        pageControl1.transform = CGAffineTransformMakeScale(2, 2)
        pageControl1.backgroundColor = UIColor.whiteColor()
        pageControl1.pageIndicatorTintColor = imageColor1
        pageControl1.currentPageIndicatorTintColor = imageColor
        // PageControlするページ数を設定する.
        pageControl1.numberOfPages = 2
        // 現在ページを設定する.
        pageControl1.currentPage = 0
        pageControl1.userInteractionEnabled = false
        
        // PageControlを作成する.
        pageControl2 = UIPageControl()
        pageControl2.transform = CGAffineTransformMakeScale(2, 2)
        pageControl2.backgroundColor = UIColor.whiteColor()
        pageControl2.pageIndicatorTintColor = imageColor1
        pageControl2.currentPageIndicatorTintColor = imageColor
        // PageControlするページ数を設定する.
        pageControl2.numberOfPages = 2
        // 現在ページを設定する.
        pageControl2.currentPage = 0
        pageControl2.userInteractionEnabled = false
    }
    //ページコンテンツ設定
    func SetPageContent(){
        for (var i = 0; i < 2; i++) {
            if i == 0{
                scrollView.addSubview(TableView)
                pageControl1.frame = CGRectMake(0, 0, self.view.bounds.width, 40)
                scrollView.addSubview(pageControl1)
            }else{
                scrollView.addSubview(mapView)
                pageControl2.frame = CGRectMake(self.view.bounds.width, 0, self.view.bounds.width, 40)
                scrollView.addSubview(pageControl2)
            }
        }
    }
    func scrollViewDidEndDecelerating(scrollView: UIScrollView) {
        // スクロール数が1ページ分になったら時.
        if fmod(scrollView.contentOffset.x, width) == 0 {
            // ページの場所を切り替える.
            pageControl1.currentPage = Int(scrollView.contentOffset.x / width)
            pageControl2.currentPage = Int(scrollView.contentOffset.x / width)
        }
    }
    //
    
    //サーチコントローラ設定
    func SetSearch(){
        self.searchBar.delegate = self
        searchBar.searchBarStyle = UISearchBarStyle.Default
        searchBar.layer.borderColor = UIColor.clearColor().CGColor
        searchBar.backgroundColor = UIColor.whiteColor()
        searchBar.layer.borderColor = UIColor.whiteColor().CGColor
        searchBar.layer.borderWidth = 1.0
        searchBar.barTintColor = imageColor
        searchBar.tintColor = imageColor
    }
    func searchBarSearchButtonClicked(searchBar: UISearchBar) {
        getResults()
        self.view.endEditing(true)
    }
    //
    
    //tableview設定
    func SetBody1(){
        TableView = UITableView()
        TableView.frame = CGRectMake(0, 40, self.view.bounds.width, self.view.bounds.height-40)
        TableView.registerNib(UINib(nibName: "RestaurantTVC", bundle: nil), forCellReuseIdentifier: "RestaurantTVC")
        TableView.dataSource = self
        TableView.delegate = self
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if Restaurants.count < 3{
            return Restaurants.count
        }else{
            return 3
        }
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        cell = self.TableView.dequeueReusableCellWithIdentifier("RestaurantTVC")! as UITableViewCell
        image1 = cell.viewWithTag(1) as! UIImageView
        label1 = cell.viewWithTag(2) as! UILabel
        label2 = cell.viewWithTag(3) as! UILabel
        label3 = cell.viewWithTag(4) as! UILabel
        if DataFlag == 1{
            if indexPath.row == 0{
                label3.text = "現在地との\n距離"
                label3.backgroundColor = imageColor1
            }
            if Restaurants[indexPath.row]["image_url"]! != nil{
                //画像の処理
                UIApplication.sharedApplication().networkActivityIndicatorVisible = true
                let url = NSURL(string: Restaurants[indexPath.row]["image_url"]!!)
                image1.af_setImageWithURL(url!)
                UIApplication.sharedApplication().networkActivityIndicatorVisible = false
            } else{
                image1.image = UIImage(named: "food.png")
            }
            cell.selectionStyle = UITableViewCellSelectionStyle.None
            label1.text = Restaurants[indexPath.row]["distance"]!!
            label2.text = Restaurants[indexPath.row]["name"]!! + "\n" + Restaurants[indexPath.row]["category"]!!
        }
        
        return cell
    }
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 140
    }
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        CurrentURL = Restaurants[indexPath.row]["url"]!!
        self.performSegueWithIdentifier("Next", sender: nil)
    }
    //
    
    //mapview設定
    func SetBody2(){
        MapImageFrag = 0
        mapView = MKMapView()
        mapView.frame = CGRectMake(self.view.bounds.width, 40, self.view.bounds.width, self.view.bounds.height-40)
        mapView.setCenterCoordinate(CurrentLocation, animated: true)
        mapView.showsUserLocation = true
        mapView.userTrackingMode = MKUserTrackingMode.Follow
        mapView.delegate = self
        // 縮尺.
        let myLatDist : CLLocationDistance = 500
        let myLonDist : CLLocationDistance = 500
        // Regionを作成.
        let myRegion: MKCoordinateRegion = MKCoordinateRegionMakeWithDistance(CurrentLocation, myLatDist, myLonDist);
        // MapViewに反映.
        mapView.setRegion(myRegion, animated: true)
        self.view.addSubview(mapView)
    }
    func mapView(mapView: MKMapView!, viewForAnnotation annotation: MKAnnotation!) -> MKAnnotationView! {
        var myIdentifier = "myPin"
        myAnnotationView = MKAnnotationView(annotation: annotation, reuseIdentifier: myIdentifier)
        myAnnotationView.annotation = annotation
        myAnnotationView.tag = kakunin
        myAnnotationView.image = UIImage(named: "pin")
        kakunin++
        return myAnnotationView
    }
    func mapView(mapView: MKMapView, didSelectAnnotationView view: MKAnnotationView) {
        if ((view.annotation?.subtitle)!) != Optional(nil)!{
        CurrentURL = Restaurants[Int(((view.annotation?.subtitle)!)!)!]["url"]!!
        self.performSegueWithIdentifier("Next", sender: nil)
        }
    }
    func mapView(mapView: MKMapView!, regionDidChangeAnimated animated: Bool) {
        mapView.removeAnnotations(Annotations)
        Annotations = []
        ForTag = 0
        CurrentLatitude = mapView.centerCoordinate.latitude
        CurrentLongitude = mapView.centerCoordinate.longitude
        CurrentLocation = CLLocationCoordinate2DMake(CurrentLatitude,CurrentLongitude)
        Url = "http://api.gnavi.co.jp/RestSearchAPI/20150630/?keyid=1d2528ceff8cf6fc72b571923844ac38&format=json&latitude=\(String(CurrentLatitude!))&longitude=\(String(CurrentLongitude!))&range=5"
        getResults()
    }
    func SetLocation(){
        //位置情報取得
        myLocationManager = CLLocationManager()
        myLocationManager.delegate = self
        // セキュリティ認証のステータスを取得.
        let status = CLLocationManager.authorizationStatus()
        // まだ認証が得られていない場合は、認証ダイアログを表示.
        if(status == CLAuthorizationStatus.NotDetermined) {
            print("didChangeAuthorizationStatus:\(status)");
            // まだ承認が得られていない場合は、認証ダイアログを表示.
            self.myLocationManager.requestAlwaysAuthorization()
        }
        // 取得精度の設定.
        myLocationManager.desiredAccuracy = kCLLocationAccuracyBest
        myLocationManager.distanceFilter = 100
        myLocationManager.startUpdatingLocation()
    }
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        //CurrentLongitude = 139.640542
        //CurrentLatitude = 35.581730
        //実機の時は実際のGPS使える
        CurrentLongitude = manager.location?.coordinate.longitude
        CurrentLatitude = manager.location?.coordinate.latitude
        
        CurrentLocation = CLLocationCoordinate2DMake(CurrentLatitude,CurrentLongitude)
        Url = "http://api.gnavi.co.jp/RestSearchAPI/20150630/?keyid=c922472db5dabff36a35f14a031b5177&format=json&latitude=\(String(CurrentLatitude!))&longitude=\(String(CurrentLongitude!))&range=5"
        getResults()
    }
    func locationManager(manager: CLLocationManager!, didFailWithError error: NSError!){
        print("error")
    }
    func distance(){
        FromLocation = CLLocation(latitude: CurrentLatitude, longitude: CurrentLongitude)
        ToLocation = CLLocation(latitude: ToLatitude, longitude: ToLongitude)
        Distance = round(Double(ToLocation.distanceFromLocation(FromLocation)))
        DistanceInt = Int(Distance)
        if DistanceInt >= 1000{
            DistanceStr = String(round(Double(DistanceInt)/100)/10) + "\nkm"
        }else {
            DistanceStr = String(DistanceInt) + "\nm"
        }
        
    }
    //

    //APIから情報取得
    func getResults(){
        Restaurants = []
        self.DataFlag = 0
        UIApplication.sharedApplication().networkActivityIndicatorVisible = true
        Alamofire.request(.GET, Url)
            .responseJSON{ response in
                guard let object = response.result.value else{
                    return
                }
                let json = JSON(object)
                json["rest"].forEach{(i, json) in
                    self.ToLatitude = CLLocationDegrees(json["latitude"].string!)
                    self.ToLongitude = CLLocationDegrees(json["longitude"].string!)
                    self.distance()
                    let Restaurant: [String: String?] = [
                        "name": json["name"].string!,
                        "name_kana": json["name_kana"].string!,
                        "category": json["category"].string!,
                        "distance": String(self.DistanceStr),
                        "latitude": json["latitude"].string!,
                        "longitude": json["longitude"].string!,
                        "image_url": json["image_url"]["shop_image1"].string,
                        "url": json["url"].string
                     ]
                    if self.searchBar.text == ""{
                            self.Restaurants.append(Restaurant)
                            self.DataFlag = 1
                    }else{
                        if String(json["category"]).containsString(self.searchBar.text!) {
                            self.Restaurants.append(Restaurant)
                            self.DataFlag = 1
                        }
                    }
                }
                if self.FetchTimeFlag == 0{
                    self.SetBody1()
                    self.SetBody2()
                    self.SetScroll()
                    self.SetPageContent()
                }else{
                    self.TableView.reloadData()
                }
                if self.Restaurants.count != 0{
                    var tempNumber = self.Restaurants.count
                    if tempNumber > 10 {
                        tempNumber = 10
                    }
                    for(var i = 0; i < tempNumber; i++){
                        var myPin: MKPointAnnotation = MKPointAnnotation()
                        var lat0 = Double(self.Restaurants[i]["latitude"]!!)
                        var lon0 = Double(self.Restaurants[i]["longitude"]!!)
                        var lat = lat0! - lat0! * 0.00010695 + lon0! * 0.000017464 + 0.0046017
                        var lon = lon0! - lat0! * 0.000046038 - lon0! * 0.000083043 + 0.010040
                        myPin.coordinate = CLLocationCoordinate2DMake(CLLocationDegrees(lat),CLLocationDegrees(lon))
                        myPin.subtitle = String(i)
                        self.mapView.addAnnotation(myPin)
                        self.Annotations.append(myPin)
                    }
                }
                self.FetchTimeFlag = 1
                UIApplication.sharedApplication().networkActivityIndicatorVisible = false
        }
    }
    
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
        // Dispose of any resources that can be recreated.
    }
}

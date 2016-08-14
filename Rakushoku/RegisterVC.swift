import UIKit
import ESTabBarController
import Parse
import Alamofire
import SwiftyJSON
import Photos
import CoreLocation

class RegisterVC: UIViewController,UIImagePickerControllerDelegate,UINavigationControllerDelegate,CLLocationManagerDelegate{
    var X:CGFloat!
    var Y:CGFloat!
    var dismissFrom:Int!
    var dismissTo:Int!
    var firstLayer = UIView()
    var secondLayer:UIView!
    var tempCategory:String!
    var tempRecognizing = [:]
    var myLocationManager:CLLocationManager!
    var back1: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "戻る", style: .Plain, target: self, action: "Back")
        X = self.view.bounds.width
        Y = self.view.bounds.height
        Register()
    }
    override func viewDidAppear(animated: Bool) {
    }
    
    func Register(){
        back1 = UIView()
        back1.backgroundColor = UIColor.grayColor()
        back1.frame = CGRectMake(0, 0, self.view.bounds.width, self.view.bounds.height)
        back1.alpha = 0.8
        self.view.addSubview(back1)
        setButton(120, frameY: 120, layerX: X*(1/2), layerY: Y*(1/8), text: "", fontSize: 12, imageName: "List", imageEdgeTop: 0, imageEdgeLeft: 0, titleEdgeTop: 0, titleEdgeLeft: 0, cornerRadius: 4, target: self, action: "ToList", tag: 100, view: back1)
        setButton(120, frameY: 120, layerX: X*(1/2), layerY: Y*(3/8), text: "", fontSize: 12, imageName: "Album", imageEdgeTop: 0, imageEdgeLeft: 0, titleEdgeTop: 0, titleEdgeLeft: 0, cornerRadius: 4, target: self, action: "pickFromAlbum", tag: 100, view: back1)
        setButton(120, frameY: 120, layerX: X*(1/2), layerY: Y*(5/8), text: "", fontSize: 12, imageName: "Camera", imageEdgeTop: 0, imageEdgeLeft: 0, titleEdgeTop: 0, titleEdgeLeft: 0, cornerRadius: 4, target: self, action: "pickFromCamera", tag: 100, view: back1)
    }
    
    //カメラ接続の設定
    func pickFromCamera() {
        RegistrarionViewFlag = "Reload"
        fromFlag = "Camera"
        let ipc = UIImagePickerController()
        ipc.delegate = self
        ipc.sourceType = UIImagePickerControllerSourceType.Camera
        ipc.allowsEditing = false
        ipc.navigationBar.tintColor = imageColor
        ipc.navigationBar.backgroundColor = UIColor.whiteColor()
        ipc.navigationBar.translucent = false
        ipc.navigationBar.titleTextAttributes = [NSFontAttributeName: UIFont(name: "HiraginoSans-W3", size: 16)!,NSForegroundColorAttributeName:imageColor]
        self.presentViewController(ipc, animated: true, completion: nil)
    }
    //
    
    //アルバム接続の設定
    func pickFromAlbum(){
        RegistrarionViewFlag = "Reload"
        fromFlag = "Album"
        let ipc:UIImagePickerController = UIImagePickerController()
        ipc.delegate = self
        ipc.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
        ipc.navigationBar.tintColor = imageColor
        ipc.navigationBar.backgroundColor = UIColor.whiteColor()
        ipc.navigationBar.translucent = false
        ipc.navigationBar.titleTextAttributes = [NSFontAttributeName: UIFont(name: "HiraginoSans-W3", size: 16)!,NSForegroundColorAttributeName:imageColor]
        self.presentViewController(ipc, animated:true, completion:nil)
    }
    //
    
    //写真を取得
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]){
        RegistrarionViewFlag = ""
        let image: UIImage = info[UIImagePickerControllerOriginalImage] as! UIImage
        globalImage = image
        
        //対象の画像のパスを取得
        if fromFlag == "Camera"{
            //from camaera
            if (info.indexForKey(UIImagePickerControllerOriginalImage) != nil) {
                var imagePath = NSHomeDirectory()
                imagePath = imagePath.stringByAppendingFormat("Documents/sample.png")
                let imageData: NSData = UIImagePNGRepresentation(image)!
                imageData.writeToFile (imagePath, atomically: true)
                let fileUrl: NSURL = NSURL(fileURLWithPath: imagePath)
                
                //撮影日時取得
                let now = NSDate()
                let dateFormatter = NSDateFormatter()
                dateFormatter.locale = NSLocale(localeIdentifier: "jp_JP") // ロケールの設定
                dateFormatter.dateFormat = "yyyy/MM/dd HH:mm"
                PhotoDate = dateFormatter.stringFromDate(now)
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
                // 取得頻度の設定.
                myLocationManager.distanceFilter = 100
                myLocationManager.startUpdatingLocation()
                
                //URL取得
                let Title = String(fileUrl).componentsSeparatedByString("/")
                let i = Title.count
                for(var j=0; j<i; j++) {
                    if Title[j].lowercaseString.containsString(".jpg") || Title[j].lowercaseString.containsString(".png") || Title[j].lowercaseString.containsString(".jpeg") {
                        RecognitionName = Title[j]
                    }
                }
            }
        }else if fromFlag == "Album"{
            //from album
            let pickedURL: NSURL = info[UIImagePickerControllerReferenceURL] as! NSURL
            let fetchResult: PHFetchResult = PHAsset.fetchAssetsWithALAssetURLs([pickedURL], options: nil)
            let asset: PHAsset = fetchResult.firstObject as! PHAsset
            
            //撮影日時取得
            let photodate = asset.creationDate
            let formatter = NSDateFormatter()
            formatter.dateFormat = "yyyy/MM/dd hh:mm"
            if formatter.stringFromDate(photodate!) != ""{
                PhotoDate = formatter.stringFromDate(photodate!)
            }
            //
            //位置情報取得
            let Location = asset.location
            if Location != nil{
                PhotoLongitude = Location!.coordinate.longitude
                PhotoLatitude = Location!.coordinate.latitude
            }
            
            //URL取得
            PHImageManager.defaultManager().requestImageDataForAsset(asset, options: nil, resultHandler:
                {(imageData: NSData?, dataUTI: String?, orientation: UIImageOrientation, info: [NSObject : AnyObject]?) in
                    let fileUrl: NSURL = info!["PHImageFileURLKey"] as! NSURL
                    let Title = String(fileUrl).componentsSeparatedByString("/")
                    let i = Title.count
                    for(var j=0; j<i; j++) {
                        if Title[j].lowercaseString.containsString(".jpg") || Title[j].lowercaseString.containsString(".png") || Title[j].lowercaseString.containsString(".jpeg") {
                            RecognitionName = Title[j]
                        }
                    }
            })
        }
        
        //解析用に画像リサイズ
        let Ratio = (image.size.height)/(image.size.width)
        var newHeight: CGFloat!
        var newWidth: CGFloat!
        if (image.size.height * image.size.width) > 310000 {
            if (image.size.height) > (image.size.width) {
                newHeight = 640
                newWidth = newHeight / Ratio
            } else {
                newWidth = 640
                newHeight = newWidth * Ratio
            }
        } else {
            newHeight = image.size.height
            newWidth = image.size.width
        }
        
        let newSize = CGRectMake(0, 0, newWidth, newHeight)
        UIGraphicsBeginImageContext(newSize.size)
        image.drawInRect(newSize)
        let newImage:UIImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        RecognitionImage = newImage
        
        //画像の確認
        secondLayer = UIView()
        secondLayer.frame = CGRect(x: 0, y: 0, width: self.view.bounds.width, height: self.view.bounds.height)
        secondLayer.backgroundColor = UIColor.whiteColor()
        self.view.addSubview(secondLayer)
        let checkImage = UIImageView(frame: CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height))
        checkImage.contentMode = UIViewContentMode.ScaleAspectFit
        checkImage.image = image
        checkImage.tag = 6
        secondLayer.addSubview(checkImage)
        Buttons = []
        setButton(X*(1/3), frameY: Y*(1/12), layerX: X*(1/4), layerY: Y*(1/8), text: "やり直す", fontSize:16, imageName: "1.jpg", imageEdgeTop: 0, imageEdgeLeft: 0,titleEdgeTop:0,titleEdgeLeft: 0, cornerRadius: 10,target: self, action: "dismissFunc", tag:8, view: secondLayer)
        setButton(X*(1/3), frameY: Y*(1/12), layerX: X*(3/4), layerY: Y*(1/8), text: "この画像で\n決定", fontSize:16, imageName: "1.jpg", imageEdgeTop: 0, imageEdgeLeft: 0,titleEdgeTop:0,titleEdgeLeft:0,  cornerRadius: 10,target: self, action: "getImageTag", tag:7, view: secondLayer)
        for B in Buttons{
            B.setTitleColor(UIColor.whiteColor(), forState: .Normal)
            B.layer.borderColor = UIColor.whiteColor().CGColor
            B.layer.borderWidth = 0
            B.backgroundColor = imageColor
        }
        picker.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    //
    
    //DocomoAPIで画像認識
    func getImageTag(){
        self.tabBarController?.tabBar.hidden = true
        analyzing("分析中...", view:self.view)
        self.GetImageTag()
    }
    
    func GetImageTag(){
        let imageData = UIImagePNGRepresentation(RecognitionImage)!
        let Header = ["Content-Type":"multipart/form-data"]
        let key = "68454439556e7743706738334c6362494c3474576970694f6f464331305564515130474b6d396349576c31"
        
        Alamofire.upload(.POST,
                         "https://api.apigw.smt.docomo.ne.jp/imageRecognition/v1/concept/classify/?" + "APIKEY=" + key,
                         headers: Header,
                         multipartFormData:{ multipartFormData in
                            // 文字列データはUTF8エンコードでNSData型に
                            multipartFormData.appendBodyPart(data: modelName.dataUsingEncoding(NSUTF8StringEncoding)!, name: "modelName")
                            // バイナリデータ
                            // サーバによってはファイル名や適切なMIMEタイプを指定しないとちゃんと処理してくれないかも
                            multipartFormData.appendBodyPart(data: imageData, name: "image", fileName: RecognitionName, mimeType: "image/png")
            },
                         // リクエストボディ生成のエンコード処理が完了したら呼ばれる
            encodingCompletion: { encodingResult in
                switch encodingResult {
                // エンコード成功時
                case .Success(let upload, _, _):
                    // 実際にAPIリクエストする
                    upload.response { request, response, data, error in
                        if let error = error {
                        }
                        var answer = JSON.parse(NSString(data: data!, encoding: NSUTF8StringEncoding)! as String)
                        var Recognizing = [
                            "tag1" : answer["candidates"][0]["tag"].string!,
                            "tag2" : answer["candidates"][1]["tag"].string!,
                            "tag3" : answer["candidates"][2]["tag"].string!
                        ]
                        self.dispatch_async_main {
                            // UIの更新などメインスレッドで同期させたい処理
                            tempActivityIndicator.removeFromSuperview()
                            tempLabel.removeFromSuperview()
                            Recognized = [ String(Recognizing["tag1"]!),String(Recognizing["tag2"]!),String(Recognizing["tag3"]!)]
                            self.Next()
                        }
                    }
                // エンコード失敗時
                case .Failure(let encodingError): break
                }
            }
        )
    }
    
    //dismiss
    func dismissFunc(){
        firstLayer.removeFromSuperview()
        secondLayer.removeFromSuperview()
        RegistrarionViewFlag = "Reload"
        self.viewDidAppear(true)
    }
    //
    //画面遷移
    func ToList(){
        self.performSegueWithIdentifier("ToList", sender: nil)
//        self.viewDidLoad()
    }
    func Next(){
        self.performSegueWithIdentifier("Next", sender: nil)
//        self.viewDidLoad()
    }
    func Back(){
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    //
    
    // 位置情報取得に成功したときに呼び出されるデリゲート.
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        PhotoLongitude = manager.location?.coordinate.longitude
        PhotoLatitude = manager.location?.coordinate.latitude
    }
    //
    
    func dispatch_async_main(block: () -> ()) {
        dispatch_async(dispatch_get_main_queue(), block)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
import UIKit
import Parse
import Alamofire
import SwiftyJSON
import CoreData
import HealthKit

//基本の変数
var EnergyLimit = ""
var ProteinLimit = ""
var LipoidLimit = ""
var CarbohydrateLimit = ""
var EnergyDegree = ""
var ProteinDegree = ""
var LipoidDegree = ""
var CarbohydrateDegree = ""
var GraphText1 = "総エネルギーと３大栄養素"
var GraphText2 = "食事時の制限目安"
var GraphText3 = ["エネルギー","タンパク質","脂質","炭水化物"]
var GraphText4 = ["\(EnergyDegree)kcal","\(ProteinDegree)g","\(LipoidDegree)g","\(CarbohydrateDegree)g"]
var GraphText5 = ["\(EnergyLimit)kcal","\(ProteinLimit)g","\(LipoidLimit)g","\(CarbohydrateLimit)g"]
var currentUrl: String = ""
var height = ""
var weight = ""
var condition = ""
var heartrate = ""
var bloodpressure = ""
var energy = ""
var restrictionfood = ""
var username = ""
var purpose = ""
var birthday = ""
var glucoselevel = ""
var abdominalgia = ""
var bowel = ""
var blood = ""
var PURPOSE:[String] = ["ダイエット","健康管理","疾病"]
var BIRTHDAY = [([Int])(1900...2016),([Int])(1...12),([Int])(1...31)]
var HEIGHT = ([Int])(100...200)
var WEIGHT = ([Int])(10...200)
var ENERGY = [10,50,100,300,500,800,1000,1500,2000,2500,3000,3500,4000,4500,5000]
var CONDITION:[String] = ["良い","普通","悪い"]
var ABDOMINALGIA:[String] = ["強","中","弱","無"]
var BOWEL:[String] = ["無し","1-2回","3-5回","6回以上"]
var HEARTRATE = ([Int])(50...200)
var BLOODPRESSURE = ([Int])(50...200)
var GLUCOSELEVEL = ([Int])(50...200)
var bmi = ""
var CurrentURL = ""
var FoodAmount = ""
var FoodTiming = ""
var FOODAMOUNT:[String] = ["1/4人前", "1/2人前", "1人前", "2人前"]
var FOODTIMING:[String] = ["朝食", "昼食", "夕食", "間食"]
var FoodCategory = ""
var FoodName = ""
var elentalfrequency = ""
var elentalvolume = ""
var ELENTALFREQUENCY:[String] = ["毎朝", "毎昼", "毎晩", "毎朝昼", "毎昼晩", "毎朝晩", "毎朝昼晩"]
var ELENTALVOLUME = ([Int])(1...20)

//色の設定
var imageColor = UIColor(red: 249/255, green: 145/255, blue: 4/255, alpha: 1.0)
var imageColor1 = UIColor(red: 228/255, green: 231/255, blue: 235/255, alpha: 1.0)
var imageColor2 = UIColor(red: 140/255, green: 234/255, blue: 255/255, alpha:1.0)
var GraphColor1 = UIColor(red: 74/255, green: 144/255, blue: 226/255, alpha: 1.0)
var GraphColor2 = UIColor(red: 248/255, green: 231/255, blue: 28/255, alpha: 1.0)
var GraphColor3 = UIColor(red: 208/255, green: 2/255, blue: 27/255, alpha: 1.0)

//フラグ系
var RegistrarionViewFlag = ""
var fromFlag = ""
var FoodDetailFlag = ""
var RecordAlert = 0
var EnergyAlert = 0
var LipoidAlert = 0
var RecommendAlert = 0
var PeriodFlag = 0
var EnergyFlag = 0
var RestrictionFlag = 0
var SettingID = ""
var TodayRegisterFlag = 0

//解析系
var globalImage:UIImage!
var RecognitionName = ""
var RecognitionImage:UIImage!
var modelName = "food"
var Recognized: [String] = ["","",""]
var AnswerTitle = ""
var AnswerBody = ""
var PhotoDate = ""
var PhotoLatitude:CLLocationDegrees!
var PhotoLongitude:CLLocationDegrees!

//setImage
var imageViews:Array<UIImageView>=[]
var imageView:UIImageView!
func setImageView(frameX:CGFloat, frameY:CGFloat, layerX:CGFloat, layerY:CGFloat, image:UIImage, tag:Int,view:UIView){
    imageView = UIImageView()
    imageView.frame = CGRectMake(0, 0, frameX, frameY)
    imageView.layer.position = CGPoint(x: layerX, y: layerY)
    imageView.contentMode = UIViewContentMode.ScaleAspectFit
    imageView.image = image
    imageView.tag = tag
    view.addSubview(imageView)
    imageViews.append(imageView)
}
//setLabel
var labelFlag = ""
var label:UILabel!
var labels:Array<UILabel> = []
func setLabel(frameX:CGFloat,frameY:CGFloat, tag:Int, text:String, fontSize: CGFloat, layerX: CGFloat, layerY: CGFloat,view:UIView){
    label = UILabel()
    label.frame = CGRectMake(0, 0, frameX, frameY)
    label.backgroundColor = UIColor.clearColor()
    label.layer.masksToBounds = true
    label.tag = tag
    label.text = text
    label.textColor = imageColor
    label.font = UIFont(name: "HiraKakuProN-W3", size: fontSize)
    label.textAlignment = NSTextAlignment.Center
    label.layer.position = CGPoint(x: layerX, y: layerY)
    label.layer.borderColor = UIColor.whiteColor().CGColor
    label.numberOfLines = 3
    if labelFlag == "SettingView"{
        label.layer.borderColor = imageColor.CGColor
        label.layer.borderWidth = 1.0
        label.layer.cornerRadius = 5.0
    }
    labelFlag = ""
    view.addSubview(label)
    labels.append(label)
}
//setTextFields
var textFields:Array<UITextField> = []
func setTextField(frameX:CGFloat,frameY:CGFloat, tag:Int, text:String,placeholder:String, fontSize: CGFloat, layerX: CGFloat, layerY: CGFloat,view:UIView){
    let textField = UITextField()
    textField.frame = CGRectMake(0, 0, frameX, frameY)
    textField.backgroundColor = UIColor.clearColor()
    textField.layer.masksToBounds = true
    textField.tag = tag
    textField.text = text
    textField.placeholder = placeholder
    textField.textColor = imageColor
    textField.tintColor = imageColor
    textField.font = UIFont(name: "HiraKakuProN-W3", size: fontSize)
    textField.layer.position = CGPoint(x: layerX, y: layerY)
    textField.layer.borderColor = UIColor.grayColor().CGColor
    textField.layer.borderWidth = 0.5
    textField.layer.cornerRadius = 5.0
    view.addSubview(textField)
    textFields.append(textField)
}
//setButton
var Buttons:Array<UIButton> = []
var button:UIButton!
func setButton(frameX:CGFloat, frameY:CGFloat, layerX:CGFloat, layerY:CGFloat, text: String,fontSize:CGFloat, imageName:String,imageEdgeTop: CGFloat, imageEdgeLeft:CGFloat,  titleEdgeTop: CGFloat, titleEdgeLeft:CGFloat, cornerRadius:CGFloat, target:AnyObject, action: Selector, tag: Int, view: UIView ){
    button = UIButton()
    button.frame = CGRectMake(0,0,frameX,frameY)
    button.backgroundColor = UIColor.whiteColor()
    button.layer.masksToBounds = true
    button.setTitle(text, forState: .Normal)
    button.setTitleColor(imageColor, forState: .Normal)
    button.titleLabel!.font = UIFont(name: "HiraKakuProN-W3", size: fontSize)
    button.titleLabel?.numberOfLines = 2
    if imageName != "1.jpg"{
        let backImage = UIImage(named: imageName)!.imageWithRenderingMode(UIImageRenderingMode.AlwaysTemplate)
        button.setImage(backImage, forState: .Normal)
        button.contentMode = UIViewContentMode.ScaleAspectFit
        button.imageEdgeInsets = UIEdgeInsetsMake(imageEdgeTop, imageEdgeLeft, 0, 0)
        button.titleEdgeInsets = UIEdgeInsetsMake(titleEdgeTop, titleEdgeLeft, 0, 0)
        button.layer.borderColor = UIColor.whiteColor().CGColor
    }else{
        button.titleLabel?.textAlignment = NSTextAlignment.Center
        button.layer.borderColor = imageColor.CGColor
    }
    if imageName == "box.png"{
        button.setTitle(text, forState: .Selected)
        button.setTitleColor(imageColor, forState: .Selected)
        button.setImage(UIImage(named: "checkedbox.png"), forState: .Selected)
    }
    button.layer.cornerRadius = cornerRadius
    button.layer.position = CGPoint(x: layerX, y: layerY)
    button.layer.borderWidth = 2
    button.tintColor = imageColor
    button.addTarget(target, action: action, forControlEvents: .TouchUpInside)
    button.tag = tag
    view.addSubview(button)
    Buttons.append(button)
}

//画像解析
//解析中画面
//ActivityIndicator
var analyzingView = UIView()
var tempActivityIndicator = UIActivityIndicatorView()
var tempLabel = UILabel()
func analyzing(text:String,view:UIView){
    analyzingView.frame = CGRectMake(0, 0, view.bounds.width, view.bounds.height+100)
    analyzingView.backgroundColor = UIColor.whiteColor()
    view.addSubview(analyzingView)
    tempActivityIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.WhiteLarge
    tempActivityIndicator.frame = CGRectMake(0, 0, 100, 100)
    tempActivityIndicator.center = CGPoint(x: view.bounds.width/2, y: view.bounds.height/2)
    tempActivityIndicator.color = imageColor
    tempActivityIndicator.startAnimating()
    analyzingView.addSubview(tempActivityIndicator)
    //Label
    tempLabel.frame = CGRectMake(0, 0, 150, 50)
    tempLabel.backgroundColor = UIColor.whiteColor()
    tempLabel.text = text
    tempLabel.numberOfLines = 3
    tempLabel.textAlignment = NSTextAlignment.Center
    tempLabel.textColor = imageColor
    tempLabel.layer.position = CGPoint(x: view.bounds.width/2, y: view.bounds.height*(3/5))
    analyzingView.addSubview(tempLabel)
}

//説明表示画面
var backGround:UIView!
var middle:UIView!
var top:UIImageView!
var guideButton:UIButton!
func Expression(view:UIView, guideImage:String){
    backGround = UIView()
    backGround.frame = CGRectMake(0, 0, view.frame.width, view.frame.height)
    backGround.backgroundColor = UIColor.grayColor()
    view.addSubview(backGround)
    middle = UIView()
    middle.frame = CGRectMake(0, view.frame.height*(1/7), view.frame.width, view.frame.height*(5/7))
    middle.backgroundColor = UIColor.whiteColor()
    view.addSubview(middle)
    top = UIImageView()
    top.frame = CGRectMake(0, view.frame.height*(1/5), view.frame.width, view.frame.height*(3/5))
    top.backgroundColor = UIColor.whiteColor()
    top.contentMode = UIViewContentMode.ScaleAspectFit
    top.image = UIImage(named: guideImage)
    view.addSubview(top)
    guideButton = UIButton()
    guideButton.frame = CGRectMake(view.frame.width*(1/2), view.frame.height*(7/8), view.frame.width*(1/8), view.frame.height*(1/12))
    guideButton.backgroundColor = UIColor.whiteColor()
    guideButton.layer.masksToBounds = true
    guideButton.setTitle("OK", forState: .Normal)
    guideButton.setTitleColor(imageColor, forState: .Normal)
    guideButton.titleLabel!.font = UIFont(name: "HiraKakuProN-W3", size: 15)
    guideButton.layer.borderColor = UIColor.whiteColor().CGColor
    guideButton.tintColor = imageColor
    guideButton.tag = 0
    view.addSubview(guideButton)
}

//alert系
var alertTitle:String!
var alertMessage:String!
var alertController: UIAlertController!
func AlertTitle() {
    UIAlertController.appearance().tintColor = imageColor
    alertController = UIAlertController(title: alertTitle, message: "", preferredStyle: .Alert)
    let action = UIAlertAction(title: "OK", style: .Default, handler: nil)
    alertController.addAction(action)
}
func AlertMessage(){
    UIAlertController.appearance().tintColor = imageColor
    alertController = UIAlertController(title: "", message: alertMessage, preferredStyle: .Alert)
    let action = UIAlertAction(title: "OK", style: .Default, handler: nil)
    alertController.addAction(action)
}
func AlertMessage2(){
    UIAlertController.appearance().tintColor = imageColor
    alertController = UIAlertController(title: "", message: alertMessage, preferredStyle: .Alert)
}

//coredataへの追加、読込
var coredata = [NSManagedObject]()
var results = [AnyObject]()
var appDelegate:AppDelegate!
//

var FOODCATEGORY:[String] = ["アジア・エスニック","イタリアン","中華","肉料理","洋食","和食"]
var FOODNAME0:[String] = ["ナン","生春巻き","フォー","ドライカレー","キーマカレー","スープカレー","インドカレー"]
var FOODNAME1:[String] = ["ピザ","リゾット","バーニャカウダ","チーズフォンデュ","クリーム系","トマト系パスタ","ペペロンチーノ","バジル系パスタ","たらこパスタ・明太子パスタ","カルパッチョ"]
var FOODNAME2:[String] = ["チャーハン","ピラフ","酢豚","チンジャオロース","八宝菜","マーボー豆腐(麻婆豆腐）","エビチリ","エビマヨ","回鍋肉","バンバンジー","油淋鶏","ビーフン","中華まん","焼売","春巻き","杏仁豆腐","中華ちまき","チゲ","水餃子","焼き餃子"]
var FOODNAME3:[String] = ["焼肉","チキン南蛮","スペアリブ","豚の生姜焼き","チャーシュー(焼き豚)","ステーキ","ベーコン","ソーセージ・ウインナー","焼き鳥","照り焼きチキン","鶏そぼろ"]
var FOODNAME4:[String] = ["ローストビーフ","オムライス","クリーム系スープ","コーンスープ・ポタージュ","トマト系スープ","ポトフ","オニオンスープ","サンドイッチ","食パン","フレンチトースト","蒸しパン","パン","ハンバーグ","グラタン","ドリア","クリームシチュー","ビーフシチュー","ハンバーガー","ホットドック"]
var FOODNAME5:[String] = ["フライドポテト",
                          "唐揚げ",
                          "コロッケ",
                          "カツ",
                          "海老フライ",
                          "揚げ出し豆腐",
                          "冷汁",
                          "豚の角煮・煮豚",
                          "ピーマンの肉詰め",
                          "ロールキャベツ",
                          "もつ煮込み",
                          "牛すじ煮込み",
                          "焼き魚",
                          "煮つけ",
                          "さばの味噌煮",
                          "うなぎ",
                          "生ガキ",
                          "焼き牡蠣",
                          "焼きホタテ",
                          "卵焼き",
                          "ゆで卵",
                          "目玉焼き",
                          "茶碗蒸し",
                          "タコライス",
                          "握り寿司",
                          "ちらしずし",
                          "いなり寿司",
                          "手巻きずし",
                          "巻きずし",
                          "天津丼",
                          "中華丼",
                          "カツ丼",
                          "天丼",
                          "海鮮丼",
                          "牛丼",
                          "親子丼",
                          "炊き込みご飯",
                          "おかゆ",
                          "おにぎり",
                          "お茶漬け",
                          "そうめん",
                          "ソース焼きそば",
                          "塩焼きそば",
                          "お好み焼き",
                          "たこ焼き",
                          "味噌汁",
                          "お吸い物",
                          "おでん",
                          "すき焼き",
                          "しゃぶしゃぶ",
                          "湯豆腐",
                          "鍋",
                          "サラダ",
                          "おせち料理",
                          "かぼちゃの煮物",
                          "タコス",
                          "ゴーヤチャンプル",
                          "ソーキそば・沖縄そば",
                          "海ぶどう",
                          "そうめんチャンプルー",
                          "サーターアンダーギー",
                          "キムチ",
                          "漬物",
                          "肉じゃが",
                          "かぼちゃのグラタン",
                          "なすの煮びたし",
                          "ひじきの煮物",
                          "きんぴらごぼう",
                          "たけのこの煮物",
                          "里芋の煮物",
                          "厚揚げの煮物",
                          "筑前煮",
                          "白和え",
                          "おひたし",
                          "胡麻和え",
                          "酢の物",
                          "カレーライス",
                          "野菜炒め",
                          "なすの味噌炒め",
                          "豚キムチ",
                          "天ぷら",
                          "ざるうどん",
                          "うどん",
                          "焼きうどん",
                          "ざるそば",
                          "蕎麦",
                          "豚骨ラーメン",
                          "味噌らーめん",
                          "塩ラーメン",
                          "坦々麺",
                          "醤油ラーメン",
                          "もんじゃ焼き",
                          "パエリア",
                          "チキンライス",
                          "ハヤシライス・ハッシュドビーフ",
                          "ロコモコ"]

class Setting: NSObject {
    
}

import UIKit

class RegisterResultDetailVC: UIViewController {
    var X:CGFloat!
    var Y:CGFloat!

    override func viewDidLoad() {
        super.viewDidLoad()
        X = self.view.bounds.width
        Y = self.view.bounds.height
        //サンプルとしてロールキャベツ(脂質低め)のデータ入れる
        if FoodDetailFlag == "1"{
            AnswerTitle = "牛ロースカットステーキ"
            AnswerBody = "デニーズ　六本木店\nカロリー：273kcal"
            globalImage = UIImage(named: "sample2")
            GraphText4 = ["273","24","14.1","12.8"]
            GraphText5 = ["400","40","15","15"]
            FoodDetailFlag = ""
        }else if FoodDetailFlag == "2"{
            AnswerTitle = "レンコンメンチカツ"
            AnswerBody = "日時：　　2016/07/27 21:00\nカロリー：237kcal"
            globalImage = UIImage(named: "sample3")
            GraphText4 = ["237","16.4","8","15"]
            GraphText5 = ["400","40","15","15"]
            FoodDetailFlag = ""
        }else{
            if PhotoDate == ""{
                let now = NSDate()
                let dateFormatter = NSDateFormatter()
                dateFormatter.locale = NSLocale(localeIdentifier: "jp_JP") // ロケールの設定
                dateFormatter.dateFormat = "yyyy/MM/dd HH:mm"
                PhotoDate = dateFormatter.stringFromDate(now)
            }
            globalImage = UIImage(named: "sample1")
            AnswerTitle = "ロールキャベツ"
            AnswerBody = "日時：　　\(PhotoDate) \(FoodTiming)\nカロリー：69kcal \(FoodAmount)"
            GraphText4 = ["69","7.8","0.6","8.6"]
            GraphText5 = ["400","12","4","10"]
        }
        setBody()
        setGraph()
    }
    override func viewDidAppear(animated: Bool) {
    }

    func setBody(){
        setImageView(X, frameY: Y*(1/3), layerX: X*(1/2), layerY: Y*(1/6), image: globalImage, tag: 1, view: self.view)
        labels = []
        setLabel(X*(9/10), frameY: Y*(1/10), tag: 1, text: AnswerTitle, fontSize: 16, layerX: X/2, layerY: Y*(3.5/10), view: self.view)
        setLabel(X*(9/10), frameY: Y*(2/10), tag: 1, text: AnswerBody, fontSize: 16, layerX: X/2, layerY: Y*(4/10), view: self.view)
        var i = 0
        for l in labels{
            if i == 0{
                l.textColor = imageColor
            }else{
                l.textColor = UIColor.grayColor()
            }
            l.textAlignment = NSTextAlignment.Left
            ++i
        }
    }
    
    func setGraph(){
        let base1 = UIView()
        base1.frame = CGRectMake(16, Y*(4.5/10), X-32, Y*(3.5/10))
        base1.backgroundColor = UIColor.whiteColor()
        self.view.addSubview(base1)
        
        //ラベル設定
        labels = []
        setLabel(base1.bounds.width, frameY:base1.bounds.height*(1/12), tag: 0, text: GraphText1, fontSize: 14, layerX: base1.bounds.width*(1/2), layerY: base1.bounds.height*(1/24), view: base1)
        setLabel(base1.bounds.width, frameY:base1.bounds.height*(1/12), tag: 1, text: GraphText2, fontSize: 10, layerX: base1.bounds.width*(1/2), layerY: base1.bounds.height*(1/24), view: base1)
        setLabel(base1.bounds.width, frameY:base1.bounds.height*(1/12), tag: 0, text: GraphText3[0], fontSize: 10, layerX: base1.bounds.width*(1/2), layerY: base1.bounds.height*(1.5/12), view: base1)
        setLabel(base1.bounds.width, frameY:base1.bounds.height*(1/12), tag: 0, text: GraphText4[0], fontSize: 10, layerX: base1.bounds.width*(1.7/2), layerY: base1.bounds.height*(1.5/12), view: base1)
        setLabel(base1.bounds.width, frameY:base1.bounds.height*(1/12), tag: 1, text: GraphText5[0], fontSize: 10, layerX: base1.bounds.width*(1/2), layerY: base1.bounds.height*(1.5/12), view: base1)
        setLabel(base1.bounds.width, frameY:base1.bounds.height*(1/12), tag: 0, text: GraphText3[1], fontSize: 10, layerX: base1.bounds.width*(1/2), layerY: base1.bounds.height*(4/12), view: base1)
        setLabel(base1.bounds.width, frameY:base1.bounds.height*(1/12), tag: 0, text: GraphText4[1], fontSize: 10, layerX: base1.bounds.width*(1.7/2), layerY: base1.bounds.height*(4/12), view: base1)
        setLabel(base1.bounds.width, frameY:base1.bounds.height*(1/12), tag: 1, text: GraphText5[1], fontSize: 10, layerX: base1.bounds.width*(1/2), layerY: base1.bounds.height*(4/12), view: base1)
        setLabel(base1.bounds.width, frameY:base1.bounds.height*(1/12), tag: 0, text: GraphText3[2], fontSize: 10, layerX: base1.bounds.width*(1/2), layerY: base1.bounds.height*(6.5/12), view: base1)
        setLabel(base1.bounds.width, frameY:base1.bounds.height*(1/12), tag: 0, text: GraphText4[2], fontSize: 10, layerX: base1.bounds.width*(1.7/2), layerY: base1.bounds.height*(6.5/12), view: base1)
        setLabel(base1.bounds.width, frameY:base1.bounds.height*(1/12), tag: 1, text: GraphText5[2], fontSize: 10, layerX: base1.bounds.width*(1/2), layerY: base1.bounds.height*(6.5/12), view: base1)
        setLabel(base1.bounds.width, frameY:base1.bounds.height*(1/12), tag: 0, text: GraphText3[3], fontSize: 10, layerX: base1.bounds.width*(1/2), layerY: base1.bounds.height*(9/12), view: base1)
        setLabel(base1.bounds.width, frameY:base1.bounds.height*(1/12), tag: 0, text: GraphText4[3], fontSize: 10, layerX: base1.bounds.width*(1.7/2), layerY: base1.bounds.height*(9/12), view: base1)
        setLabel(base1.bounds.width, frameY:base1.bounds.height*(1/12), tag: 1, text: GraphText5[3], fontSize: 10, layerX: base1.bounds.width*(1/2), layerY: base1.bounds.height*(9/12), view: base1)
        for l in labels{
            l.backgroundColor = UIColor.clearColor()
            l.textColor = UIColor.grayColor()
            if l.tag == 0{
                l.textAlignment = NSTextAlignment.Left
            }else{
                l.textAlignment = NSTextAlignment.Right
            }
        }
        labels[0].textColor = imageColor
        labels[1].textColor = imageColor
        labels[4].textColor = imageColor
        labels[7].textColor = imageColor
        labels[10].textColor = imageColor
        labels[13].textColor = imageColor
        
        //バー設定
        //外枠設定
        labels = []
        setLabel(base1.bounds.width, frameY: base1.bounds.height*(1/8), tag: 0, text: "", fontSize: 14, layerX: base1.bounds.width/2, layerY: base1.bounds.height*(2.6/12), view: base1)
        setLabel(base1.bounds.width, frameY: base1.bounds.height*(1/8), tag: 0, text: "", fontSize: 14, layerX: base1.bounds.width/2, layerY: base1.bounds.height*(5.1/12), view: base1)
        setLabel(base1.bounds.width, frameY: base1.bounds.height*(1/8), tag: 0, text: "", fontSize: 14, layerX: base1.bounds.width/2, layerY: base1.bounds.height*(7.6/12), view: base1)
        setLabel(base1.bounds.width, frameY: base1.bounds.height*(1/8), tag: 0, text: "", fontSize: 14, layerX: base1.bounds.width/2, layerY: base1.bounds.height*(10.2/12), view: base1)
        for l in labels{
            l.backgroundColor = UIColor.whiteColor()
            l.layer.borderColor = imageColor1.CGColor
            l.layer.borderWidth = 2
        }
        
        //内枠設定
        labels = []
        var setX = base1.bounds.width
        var setX1 = CGFloat(Double(GraphText4[0])! / Double(GraphText5[0])!)
        var setX2 = CGFloat(Double(GraphText4[1])! / Double(GraphText5[1])!)
        var setX3 = CGFloat(Double(GraphText4[2])! / Double(GraphText5[2])!)
        var setX4 = CGFloat(Double(GraphText4[3])! / Double(GraphText5[3])!)
        var setXArray = [setX1,setX2,setX3,setX4]
        setLabel(setX * setX1, frameY: base1.bounds.height*(1/8), tag: 0, text: "", fontSize: 14, layerX: (setX * setX1)/2, layerY: base1.bounds.height*(2.6/12), view: base1)
        setLabel(setX * setX2, frameY: base1.bounds.height*(1/8), tag: 0, text: "", fontSize: 14, layerX: (setX * setX2)/2, layerY: base1.bounds.height*(5.1/12), view: base1)
        setLabel(setX * setX3, frameY: base1.bounds.height*(1/8), tag: 0, text: "", fontSize: 14, layerX: (setX * setX3)/2, layerY: base1.bounds.height*(7.6/12), view: base1)
        setLabel(setX * setX4, frameY: base1.bounds.height*(1/8), tag: 0, text: "", fontSize: 14, layerX: (setX * setX4)/2, layerY: base1.bounds.height*(10.2/12), view: base1)
        for l in labels{
            l.layer.borderColor = imageColor1.CGColor
            l.layer.borderWidth = 2
        }
        var i = 0
        for s in setXArray{
            if s >= 0.6 && s < 0.8{
                labels[i].backgroundColor = GraphColor2
            }else if s >= 0.8{
                labels[i].backgroundColor = GraphColor3
            }else{
                labels[i].backgroundColor = GraphColor1
            }
            ++i
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

import UIKit

class RegisterResult1VC: UIViewController {
    var X:CGFloat!
    var Y:CGFloat!

    override func viewDidLoad() {
        super.viewDidLoad()
        X = self.view.bounds.width
        Y = self.view.bounds.height
        SetTop()
        SetBody()
    }
    override func viewDidAppear(animated: Bool) {
    }
    func SetTop(){
        var title = "検索結果の3候補です。\n最も適切な料理名を\nタップして下さい。"
        setLabel(X*(8/10), frameY: Y*(1/8), tag: 0, text: title, fontSize: 16, layerX: X*(1/2), layerY: Y*(1/8), view: self.view)
    }
    func SetBody(){
        Buttons = []
        setButton(X*(1/2), frameY: Y*(1/12), layerX: X*(1/2), layerY: Y*(2/6), text: Recognized[0], fontSize:16, imageName: "1.jpg", imageEdgeTop: 0, imageEdgeLeft: 0,titleEdgeTop:0,titleEdgeLeft:0,  cornerRadius: 10,target: self, action: "Next:", tag:0, view: self.view)
        setButton(X*(1/2), frameY: Y*(1/12), layerX: X*(1/2), layerY: Y*(3/6), text: Recognized[1], fontSize:16, imageName: "1.jpg", imageEdgeTop: 0, imageEdgeLeft: 0,titleEdgeTop:0,titleEdgeLeft:0,  cornerRadius: 10,target: self, action: "Next:", tag:7, view: self.view)
        setButton(X*(1/2), frameY: Y*(1/12), layerX: X*(1/2), layerY: Y*(4/6), text: Recognized[2], fontSize:16, imageName: "1.jpg", imageEdgeTop: 0, imageEdgeLeft: 0,titleEdgeTop:0,titleEdgeLeft:0,  cornerRadius: 10,target: self, action: "Next:", tag:7, view: self.view)
        for B in Buttons{
            B.setTitleColor(UIColor.whiteColor(), forState: .Normal)
            B.layer.borderColor = UIColor.whiteColor().CGColor
            B.layer.borderWidth = 0
            B.backgroundColor = imageColor
        }
    }
    
    //画面遷移
    func Next(sender: UIButton){
        self.performSegueWithIdentifier("Next", sender: nil)
    }
    //
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

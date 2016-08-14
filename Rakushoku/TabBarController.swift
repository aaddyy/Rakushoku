import UIKit
import Parse

@objc protocol register{
    func Register()
}
class TabBarController: UITabBarController,UITabBarControllerDelegate{
    var Tab = UITabBarItem()
    var X:CGFloat!
    var Y:CGFloat!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate = self
        // アイコン色
        UITabBar.appearance().tintColor = imageColor
        UITabBar.appearance().translucent  = false
        UITabBar.appearance().backgroundColor = UIColor.whiteColor()
        UITabBar.appearance().layer.borderColor = UIColor.grayColor().CGColor
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        X = self.view.bounds.width
        Y = self.view.bounds.height
        setImageView(50, frameY: 50, layerX: X*(1/2), layerY: Y*(9.2/10), image: UIImage(named: "Register")!, tag: 1, view: self.view)
        Buttons = []
        setButton(50, frameY: 50, layerX: X*(1/2), layerY: Y*(9.2/10), text: "", fontSize: 12, imageName: "1.jpg", imageEdgeTop: 0, imageEdgeLeft: 0, titleEdgeTop: 0, titleEdgeLeft: 0, cornerRadius: 0, target: self, action: "Register", tag: 1, view: self.view)
        Buttons[0].tintColor = UIColor.clearColor()
        Buttons[0].backgroundColor = UIColor.clearColor()
        Buttons[0].layer.borderWidth = 0
    }
    
    func Register(){
        let registervc = self.storyboard?.instantiateViewControllerWithIdentifier("RegisterVC")
        self.presentViewController(registervc!, animated: true, completion: nil)
    }
    
    override func viewWillAppear(animated: Bool) {
            self.selectedIndex = 0
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func tabBar(tabBar: UITabBar, didSelectItem item: UITabBarItem) {
//        if item.tag == 2{
//            if PFUser.currentUser() == nil {
//                self.selectedIndex = 0
//            }
//        }
    }
}

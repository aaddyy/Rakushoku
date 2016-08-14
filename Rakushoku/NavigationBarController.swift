import UIKit

class NavigationBarController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationBar.translucent = false
        self.navigationBar.backgroundColor = UIColor.whiteColor()
        self.navigationBar.layer.borderColor = UIColor.grayColor().CGColor
        self.navigationBar.tintColor = imageColor
        
        // フォント設定
        self.navigationBar.titleTextAttributes = [NSFontAttributeName: UIFont(name: "HiraginoSans-W3", size: 18)!,NSForegroundColorAttributeName:imageColor]
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
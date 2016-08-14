import UIKit
import WebKit
import Parse

class WebVC: UIViewController,WKNavigationDelegate{
    var wkWebView:WKWebView!

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(animated: Bool) {
        SetWebView()
    }
    //WebView設定
    func SetWebView(){
        wkWebView = WKWebView()
        wkWebView.frame = CGRectMake(0, 0, self.view.bounds.width, self.view.bounds.height)
        self.view.addSubview(wkWebView)
        wkWebView.autoresizingMask = [.FlexibleWidth, .FlexibleHeight]
        
        let URL = NSURL(string: CurrentURL)
        let URLReq = NSURLRequest(URL:URL!)
        wkWebView.navigationDelegate = self
        self.wkWebView.loadRequest(URLReq)
    }
    
    //タイトル表示
    func webView(webView: WKWebView, didFinishNavigation navigation: WKNavigation!) {
        var label = UILabel()
        label.backgroundColor = UIColor.whiteColor()
        label.font = UIFont(name: "HiraginoSans-W3", size: 12)
        label.textColor = imageColor
        label.textAlignment = NSTextAlignment.Center
        label.numberOfLines = 0
        label.text = wkWebView.title
        label.sizeToFit()
        //label.adjustsFontSizeToFitWidth = true
        self.navigationItem.titleView = label
    }
    //
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

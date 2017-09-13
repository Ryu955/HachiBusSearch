//
//  ViewController.swift
//  HachiBusTimeTable
//
//  Created by Ryuta Ishikawa on 2017/08/22.
//  Copyright © 2017年 Ryuta Ishikawa. All rights reserved.
//

import UIKit
import WebKit

class WebViewController: UIViewController ,WKNavigationDelegate{
    
   // @IBOutlet weak var webview: UIWebView!
    
    

    @IBOutlet weak var contentView: UIView!
    
    private var webView: WKWebView!
    var selectedURL: URL?
    var selectedTitle:String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let url = selectedURL{
            let request = URLRequest(url: url)
            
            
            //WkWebView 生成
            self.webView = WKWebView(frame: CGRect.zero)
            
            //デリケート設定
            self.webView.navigationDelegate = self
            
            //フリップでの戻る・進むを有効にする
            self.webView.allowsBackForwardNavigationGestures = true
            self.contentView.addSubview(self.webView)
            
            //ページ読み込み
            //            let url = NSURL(string: "https://www.google.co.jp/")
            //            let urlRequest = URLRequest(url: url as! URL)
            self.webView.load(request)
        }
    }
    
    override func viewDidLayoutSubviews() {
        //WKWebView リサイズ
        self.webView.frame = CGRect(origin: CGPoint.zero, size: self.contentView.frame.size)

    }

    
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        // ネットワークインジケータを表示
        UIApplication.shared.isNetworkActivityIndicatorVisible = true;
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        // ネットワークインジケータを非表示
        UIApplication.shared.isNetworkActivityIndicatorVisible = false;
    }

    @IBAction func onClickBackBarButton(_ sender: Any) {
        // 前のページ
        self.webView.goBack()
    }

    
    @IBAction func onClickForwardBarButton(_ sender: Any) {
        // 次のページ
        self.webView.goForward()
    }
    
    @IBAction func reloadPage(_ sender: Any) {
        self.webView.reload()
    }
    
    @IBAction func shareUrl(_ sender: Any) {
        let text = "\(selectedTitle!) - \(selectedURL!)"
        let items = [text]
        
        // UIActivityViewControllerをインスタンス化
        let activityVc = UIActivityViewController(activityItems: items, applicationActivities: nil)
        
        // UIAcitivityViewControllerを表示
        self.present(activityVc, animated: true, completion: nil)
    }
}


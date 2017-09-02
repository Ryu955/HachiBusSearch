//
//  ViewController.swift
//  HachiBusTimeTable
//
//  Created by Ryuta Ishikawa on 2017/08/22.
//  Copyright © 2017年 Ryuta Ishikawa. All rights reserved.
//

import UIKit

class WebViewController: UIViewController {
    
    @IBOutlet weak var webview: UIWebView!

    @IBAction func prevBtn(_ sender: Any) {
        // 戻る
        self.webview.goBack()
    }

    @IBAction func nextBtn(_ sender: Any) {
        // 進む
        self.webview.goForward()
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        // Do any additional setup after loading the view, typically from a nib.
        // urlとかをセットして　表示するだけ
        if let url = URL(string: "http://www.teu.ac.jp/campus/access/006644.html"){
            let request = URLRequest(url: url)
            webview.loadRequest(request)
        }
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}


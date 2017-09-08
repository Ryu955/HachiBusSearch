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
    
    

    
    var selectedURL: URL?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // urlとかをセットして　表示するだけ
        if let url = selectedURL{
            let request = URLRequest(url: url)
            webview.loadRequest(request)
        }
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
  
    

}


//
//  WebViewController.swift
//  YLDataSDKDemoOC
//
//  Created by yanpei on 2019/1/16.
//  Copyright © 2019 yilan. All rights reserved.
//

import UIKit
import WebKit
import YLDataSDK

class WebViewController: UIViewController
{
    @objc var urlStr: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var top: CGFloat = 20
        if UIScreen.main.bounds.height > 811 {
            top = 44
        }
        
        let topBarView = UIView.init()
        topBarView.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: top + 40)
        topBarView.backgroundColor = .lightGray
        self.view.addSubview(topBarView)
        
        let backBtn = UIButton()
        backBtn.frame = CGRect(x: 0, y: top, width: 100, height: 40)
        backBtn.setTitle("返回", for: .normal)
        backBtn.addTarget(self, action: #selector(cancel), for: .touchUpInside)
        topBarView.addSubview(backBtn)
        
        let webViewFrame =  CGRect(x: 0, y: topBarView.frame.maxY, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height - topBarView.frame.maxY)
        let config = WKWebViewConfiguration.init()
        config.allowsInlineMediaPlayback = true
        config.requiresUserActionForMediaPlayback = false
        let webView = WKWebView.init(frame: webViewFrame, configuration: config)
        
        self.view.addSubview(webView)
        if let url = URL.init(string: urlStr) {
            webView.load(URLRequest.init(url: url))
        }
    }
    
    @objc func cancel()
    {
        self.dismiss(animated: true, completion: nil)
    }
    
}

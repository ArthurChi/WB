//
//  OAuthViewController.swift
//  WeiBo
//
//  Created by Cjfire on 15/11/17.
//  Copyright © 2015年 Cjfire. All rights reserved.
//

import UIKit
import SVProgressHUD

class OAuthViewController: UIViewController, UIWebViewDelegate {

    private lazy var webView = UIWebView()
    
    override func loadView() {
        
        view = webView
        
        webView.delegate = self
        
        title = "登录新浪微博"
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "取消", style: .Plain, target: self, action: "close")
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "自动填充", style: .Plain, target: self, action: "autoFill")
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.webView.loadRequest(NSURLRequest(URL: UserAccountViewModel.shareUserAccountViewModel.oauthUrl))
    }
    
    // MARK: - Event Response
    @objc private func close() {
        
        dismissViewControllerAnimated(true) { () -> Void in
            SVProgressHUD.dismiss()
        }
    }
    
    /// 自动填充用户名和密码 － web 注入（以代码的方式向web页面添加内容）
    @objc private func autoFill() {
        
        let js = "document.getElementById('userId').value = 'cjfire@sina.cn';"
        
        // 让 webView 执行 js
        webView.stringByEvaluatingJavaScriptFromString(js)
    }

    // MARK:- UIWebViewDelegate
    func webView(webView: UIWebView, shouldStartLoadWithRequest request: NSURLRequest, navigationType: UIWebViewNavigationType) -> Bool {
        
        guard let url = request.URL where url.host == "www.baidu.com" else {
            return true
        }
        
        guard let query = url.query where query.hasPrefix("code=") else {
            close()
            return false
        }
        
        let code = query.substringFromIndex("code=".endIndex)
        
        UserAccountViewModel.shareUserAccountViewModel.loadAccessToken(code) { (success) -> () in
            
            if !success { // 失败了
                
                SVProgressHUD.showInfoWithStatus("您的网络不给力")
                
                delay(1.0, callFunc: { () -> () in
                    self.close()
                })
                
            } else { // 成功
                
                SVProgressHUD.dismiss()
                
                NSNotificationCenter.defaultCenter().postNotificationName(SwitchRootViewControllerNotification, object: nil, userInfo: ["fromClass" : NSStringFromClass(OAuthViewController.self)])
            }
        }
        
        return false
    }
    
    func webViewDidStartLoad(webView: UIWebView) {
        SVProgressHUD.show()
    }
    
    func webViewDidFinishLoad(webView: UIWebView) {
        SVProgressHUD.dismiss()
    }
}

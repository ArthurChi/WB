//
//  EmotionManager.swift
//  WeiBo
//
//  Created by jie Chi on 15/11/30.
//  Copyright © 2015年 Cjfire. All rights reserved.
//

import Foundation

class EmotionManager {
    
    static let shareEmotionManager = EmotionManager()
    
    lazy var emotionPackages: [EmotionPackage] = {
        
        let emotionPackageLastest = EmotionPackage(dict: ["group_name_cn":"最近", "emoticons":[[String:AnyObject]]()])
        
        var emotionPackages = [emotionPackageLastest]
        
        return emotionPackages
        
        }()
    
    private init() {
        
        loadPlist()
    }
    
    private func loadPlist() {
        
        let path = NSBundle.mainBundle().pathForResource("emoticons", ofType: "plist", inDirectory: "Emoticons.bundle")
        
        let dictArray = (NSDictionary(contentsOfFile: path!)!["packages"] as! NSArray).valueForKey("id") as! [String]
        
        for idPath in dictArray {
            loadPlist(idPath)
        }
    }
    
    private func loadPlist(path: String) {
        
        let packagePath = NSBundle.mainBundle().pathForResource("info", ofType: "plist", inDirectory:  "Emoticons.bundle/" + path)
        
        var package = NSDictionary(contentsOfFile: packagePath!) as! [String:AnyObject]
        package["packagePath"] = "Emoticons.bundle/" + path
        
        emotionPackages.append(EmotionPackage(dict: package))
    }
}
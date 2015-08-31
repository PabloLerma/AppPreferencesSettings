//
//  ViewController.swift
//  AppPreferencesSettings
//
//  Created by Pablo Lerma Martínez on 30/8/15.
//  Copyright (c) 2015 Pablo Lerma Martínez. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var versionNumber: UILabel!
    @IBOutlet weak var sliderValue: UILabel!
    @IBOutlet weak var githubURL: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let backgroundColor = (NSUserDefaults.standardUserDefaults().objectForKey("backgroundColor") as? String) {
            self.view.backgroundColor = UIColor(rgba: backgroundColor)
        }
        
        if let currentVersionNumber = (NSUserDefaults.standardUserDefaults().objectForKey("version_preference") as? String) {
            versionNumber.text = versionNumber.text! + currentVersionNumber
        }
        
        if let sliderValue = (NSUserDefaults.standardUserDefaults().objectForKey("sliderKey") as? Int) {
            self.sliderValue.text = self.sliderValue.text! + String(sliderValue)
        }
        
        if let url = (NSUserDefaults.standardUserDefaults().objectForKey("url") as? String) {
            githubURL.text = githubURL.text! + url
        }
    }
}

// MARK: - UIColor from hex value helper
extension UIColor {
    public convenience init(rgba: String) {
        var red:   CGFloat = 0.0
        var green: CGFloat = 0.0
        var blue:  CGFloat = 0.0
        var alpha: CGFloat = 1.0
        
        if rgba.hasPrefix("#") {
            let index   = advance(rgba.startIndex, 1)
            let hex     = rgba.substringFromIndex(index)
            let scanner = NSScanner(string: hex)
            var hexValue: CUnsignedLongLong = 0
            if scanner.scanHexLongLong(&hexValue) {
                switch (count(hex)) {
                case 3:
                    red   = CGFloat((hexValue & 0xF00) >> 8)       / 15.0
                    green = CGFloat((hexValue & 0x0F0) >> 4)       / 15.0
                    blue  = CGFloat(hexValue & 0x00F)              / 15.0
                case 4:
                    red   = CGFloat((hexValue & 0xF000) >> 12)     / 15.0
                    green = CGFloat((hexValue & 0x0F00) >> 8)      / 15.0
                    blue  = CGFloat((hexValue & 0x00F0) >> 4)      / 15.0
                    alpha = CGFloat(hexValue & 0x000F)             / 15.0
                case 6:
                    red   = CGFloat((hexValue & 0xFF0000) >> 16)   / 255.0
                    green = CGFloat((hexValue & 0x00FF00) >> 8)    / 255.0
                    blue  = CGFloat(hexValue & 0x0000FF)           / 255.0
                case 8:
                    red   = CGFloat((hexValue & 0xFF000000) >> 24) / 255.0
                    green = CGFloat((hexValue & 0x00FF0000) >> 16) / 255.0
                    blue  = CGFloat((hexValue & 0x0000FF00) >> 8)  / 255.0
                    alpha = CGFloat(hexValue & 0x000000FF)         / 255.0
                default:
                    print("Invalid RGB string, number of characters after '#' should be either 3, 4, 6 or 8")
                }
            } else {
                println("Scan hex error")
            }
        } else {
            print("Invalid RGB string, missing '#' as prefix")
        }
        self.init(red:red, green:green, blue:blue, alpha:alpha)
    }
}
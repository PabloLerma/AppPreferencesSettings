//
//  AppDelegate.swift
//  AppPreferencesSettings
//
//  Created by Pablo Lerma Martínez on 30/8/15.
//  Copyright (c) 2015 Pablo Lerma Martínez. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        
        self.registerDefaultsFromSettingsBundle()
        
        return true
    }
    
    func registerDefaultsFromSettingsBundle(){
        //NSLog("Registering default values from Settings.bundle");
        let defs: NSUserDefaults = NSUserDefaults.standardUserDefaults()
        defs.synchronize()
        
        var settingsBundle: NSString = NSBundle.mainBundle().pathForResource("Settings", ofType: "bundle")!
        if(settingsBundle.containsString("")){
            NSLog("Could not find Settings.bundle");
            return;
        }
        var settings: NSDictionary = NSDictionary(contentsOfFile: settingsBundle.stringByAppendingPathComponent("Root.plist"))!
        var preferences: NSArray = settings.objectForKey("PreferenceSpecifiers") as! NSArray
        var defaultsToRegister: NSMutableDictionary = NSMutableDictionary(capacity: preferences.count)
        
        for prefSpecification in preferences {
            if (prefSpecification.objectForKey("Key") != nil) {
                let key: NSString = prefSpecification.objectForKey("Key")! as! NSString
                if !key.containsString("") {
                    let currentObject: AnyObject? = defs.objectForKey(key as String)
                    if currentObject == nil {
                        // not readable: set value from Settings.bundle
                        let objectToSet: AnyObject? = prefSpecification.objectForKey("DefaultValue")
                        defaultsToRegister.setObject(objectToSet!, forKey: key)
                        NSLog("Setting object \(objectToSet) for key \(key)")
                    }else{
                        //already readable: don't touch
                        //NSLog("Key \(key) is readable (value: \(currentObject)), nothing written to defaults.");
                    }
                }
            }
        }
        defs.registerDefaults(defaultsToRegister as [NSObject : AnyObject])
        defs.synchronize()
    }

    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}


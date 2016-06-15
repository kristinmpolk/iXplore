//
//  AppDelegate.swift
//  iXplore
//
//  Created by Ingrid Polk on 6/8/16.
//  Copyright © 2016 KristinPolk. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, UINavigationControllerDelegate, CLLocationManagerDelegate {

    var window: UIWindow?
    var navigationController = UINavigationController()
    var locationManager: CLLocationManager?
    var loginStatus:String?
    var allowed: Bool = false
    var currentLocation: CLLocation?
    var userLocations: [CLLocation] = []


    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        // Override point for customization after application launch.
        
        locationManager = CLLocationManager()
        locationManager?.delegate = self
        locationManager?.requestWhenInUseAuthorization()
        loginStatus = ""
        currentLocation = CLLocation()
    
        let lvc = LoggedInViewController(nibName: "LoggedInViewController", bundle: nil)
        //let lvc = LandingViewController(nibName: "LandingInViewController", bundle: nil)
        self.navigationController = UINavigationController(rootViewController: lvc)
        self.navigationController.navigationBarHidden = false
 
        
        self.window = UIWindow(frame: UIScreen.mainScreen().bounds)
        self.window?.makeKeyAndVisible()
        self.window?.rootViewController = self.navigationController
        return true
    }
    
//    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
//        <#code#>
//    }
    
    func locationManager(manager:CLLocationManager, didChangeAuthorizationStatus status: CLAuthorizationStatus) { //delegate function
        switch status {
        case CLAuthorizationStatus.Restricted:
            loginStatus = "Authorization status restricted"
        case CLAuthorizationStatus.NotDetermined:
            loginStatus = "status not determined"
        case CLAuthorizationStatus.Denied:
            loginStatus = "Access denied"
        default:
            loginStatus = "Authorized"
            self.allowed = true
            
        }
        
//        if allowed {
//            self.locationManager?.startUpdatingLocation()
//            self.locationManager(locationManager!, didUpdateLocations: userLocations)
//        }
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


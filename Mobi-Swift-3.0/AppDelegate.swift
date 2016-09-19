//
//  AppDelegate.swift
//  Mobi-Swift-3.0
//
//  Created by Desenvolvimento Access Mobile on 8/8/16.
//  Copyright © 2016 Access Mobile. All rights reserved.
//

import UIKit
import MapKit
import AVFoundation
import CoreLocation
import RealmSwift
import Alamofire
import FBSDKCoreKit
import FBSDKLoginKit
import Firebase
import FirebaseDatabase
import FirebaseAuth
import Fabric
import TwitterKit



@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate,CLLocationManagerDelegate {
  var window: UIWindow?
  var player = AVAudioPlayer()
  
  
  func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
    print("Iniciou!")
    defineInitialParameters()
    DataManager.sharedInstance.userToken = "cae34df9-2545-4821-9bc2-d94a018bf32f"
    print(FileSupport.findDocsDirectory())
    //RealmWrapper.eraseRealmFile("default")
    if FileSupport.testIfFileExistInDocuments("default.realm") {
      RealmWrapper.realmStart("default")
      var config = Realm.Configuration()
      config.fileURL = config.fileURL?.URLByDeletingLastPathComponent?.URLByAppendingPathComponent("default.realm")
      Realm.Configuration.defaultConfiguration = config
      let realm = try! Realm(configuration: config)
      AppDelegate.realmUpdate(realm)
      DataManager.sharedInstance.realm = realm
      if DataManager.sharedInstance.myUser.password != "" && DataManager.sharedInstance.myUser.email != ""  {
        loginWithUserRealm(DataManager.sharedInstance.myUser, completion: { (result) in
          DataManager.sharedInstance.isLogged = true
          print("deu")
        })
      }
    } else {
      RealmWrapper.realmStart("default")
    }
    downloadFacebookUpdatedInfo()
    Twitter.sharedInstance().startWithConsumerKey("TZE17eCoHF3PqmXNQnQqhIXBV", consumerSecret: "3NINz0hXeFrtudSo6kSIJCLn8Z8TVW16fylD4OrkagZL2IJknJ")
    Fabric.with([Twitter.self])
    FIRApp.configure()
    FIRDatabase.database().persistenceEnabled = true
    if let user = FIRAuth.auth()?.currentUser {
      print(user.email)
    }
    
    try! AVAudioSession.sharedInstance().setCategory(AVAudioSessionCategoryPlayback)
    
    return FBSDKApplicationDelegate.sharedInstance().application(application, didFinishLaunchingWithOptions: launchOptions)
  }
  
  func applicationWillResignActive(application: UIApplication) {
    try! FIRAuth.auth()?.signOut()
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
    let loginManager: FBSDKLoginManager = FBSDKLoginManager()
    loginManager.logOut()
  }
  
  func application(application: UIApplication, openURL url: NSURL, sourceApplication: String?, annotation: AnyObject) -> Bool
  {
    return FBSDKApplicationDelegate.sharedInstance().application(application, openURL: url, sourceApplication: sourceApplication, annotation: annotation)
  }
  
  
  func defineInitialParameters() {
    let audioConfig = AudioConfig(grave: 0, medio: 0, agudo: 0,audioQuality: "Automático")
    DataManager.sharedInstance.audioConfig = audioConfig
    
  }
  
  func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
    let locValue:CLLocationCoordinate2D = manager.location!.coordinate
    let myLocation = CLLocation(latitude: locValue.latitude, longitude: locValue.longitude)
    DataManager.sharedInstance.userLocation = myLocation
    
  }
  
  func downloadFacebookUpdatedInfo() {
    if (FBSDKAccessToken.currentAccessToken() != nil) {
      //aqui consigo informacoes para dar update em algo do face
      
    }
  }
  
  func loginWithUserRealm(user:UserRealm,completion: (result: Bool) -> Void) {
    FIRDatabase.database().reference()
    
    FIRAuth.auth()?.signInWithEmail(user.email, password: user.password, completion: { (user, error) in
      if error == nil {
        print(user?.email)
        print(user?.displayName)
        print(user)
        DataManager.sharedInstance.isLogged = true
        completion(result: true)
      }
    })
    
  }
  
  static func realmUpdate(realm:Realm) {
    let radios = realm.objects(RadioRealm.self)
    DataManager.sharedInstance.allRadios = Array(radios)
    let users = realm.objects(UserRealm.self)
    if users.count > 0 {
      DataManager.sharedInstance.myUser = users.first!
    }
    let colorsRealm = realm.objects(ColorRealm.self).filter("name == 1")
    
    if colorsRealm.count > 0 {
      var colors = [ColorRealm]()
      for color in colorsRealm {
        let red = color.red
        let green = color.green
        let blue = color.blue
        let alpha = color.alpha
        let color2 = ColorRealm(name: 1, red: red, green: green, blue: blue, alpha: alpha)
        colors.append(color2)
      }
      DataManager.sharedInstance.interfaceColor = colors.first!
      DataManager.sharedInstance.existInterfaceColor = true
    }
    DataBaseTest.infoWithoutRadios()
  }
  
  
}


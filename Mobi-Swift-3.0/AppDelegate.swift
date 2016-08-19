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

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate,CLLocationManagerDelegate {
  
  var window: UIWindow?
  var player = AVAudioPlayer()
  
  
  func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
    // Override point for customization after application launch.
    defineInitialParameters()
    //defineTestData()
    DataManager.sharedInstance.userToken = "cae34df9-2545-4821-9bc2-d94a018bf32f"
    
    print(Util.findDocsDirectory())

    
    

    
    
    let manager = RequestManager()
    manager.requestJson("stationunit/search/history") { (result) -> Void in
        let data = Data.response(result)
        print(result)
      
    }
    
    


    
    
    
    
    
    
    
    
    RealmWrapper.eraseRealmFile("default")
    RealmWrapper.realmStart("default")
    
    let date1 = NSTimeInterval(-1000)
    let date11 = NSDate(timeInterval: date1, sinceDate: NSDate())
    let date2 = NSTimeInterval(-10000)
    let date21 = NSDate(timeInterval: date2, sinceDate: NSDate())
    let date3 = NSTimeInterval(-10)
    let date31 = NSDate(timeInterval: date3, sinceDate: NSDate())
    let date4 = NSTimeInterval(-3000)
    let date41 = NSDate(timeInterval: date4, sinceDate: NSDate())

    
    let radio1 = RadioRealm(id: "1", name: "Radio1", country: "Brasil", city: "Carambei", state: "Paraná", street: "Rua Bela Vista", streetNumber: "1859", zip: "84145000", lat: "-25.4281541", long: "-49.2671369", thumbnail: "test-1.png", likenumber: "28", lastAccessDate: date11, repository: true)
    //radio1.setThumbnailImage("test-4.png")
    let radio2 = RadioRealm(id: "2", name: "Radio2", country: "Brasil", city: "Castro", state: "Acre", street: "Rua Bela Vista", streetNumber: "1859", zip: "84145000", lat: "-25.1089541", long: "-49.2671369", thumbnail: "test-1.png", likenumber: "28", lastAccessDate: date21, repository: true)
    //radio2.setThumbnailImage("test-4.png")
    let radio3 = RadioRealm(id: "3", name: "Radio3", country: "Brasil", city: "Castro", state: "Acre", street: "Rua Bela Vista", streetNumber: "1859", zip: "84145000", lat: "-25.1089541", long: "-49.2671369", thumbnail: "test-1.png", likenumber: "28", lastAccessDate: date21, repository: true)
    //radio3.setThumbnailImage("test-4.png")
    let radio4 = RadioRealm(id: "4", name: "Radio4", country: "Brasil", city: "Palmas", state: "Rio Grande do Sul", street: "Rua Bela Vista", streetNumber: "1859", zip: "84145000", lat: "-25.5289541", long: "-49.2671369", thumbnail: "test-1.png", likenumber: "28", lastAccessDate: date41, repository: true)
    //radio3.setThumbnailImage("test-4.png")
    let radio5 = RadioRealm(id: "5", name: "Radio5", country: "Brasil", city: "Seila", state: "Acre", street: "Rua Bela Vista", streetNumber: "1859", zip: "84145000", lat: "-25.2289541", long: "-49.2671369", thumbnail: "test-1.png", likenumber: "28", lastAccessDate: date21, repository: true)
    //radio1.setThumbnailImage("test-4.png")
    let radio6 = RadioRealm(id: "6", name: "Radio6", country: "Brasil", city: "Seila", state: "Roraima", street: "Rua Bela Vista", streetNumber: "1859", zip: "84145000", lat: "-25.2289541", long: "-49.2671369", thumbnail: "test-1.png", likenumber: "28", lastAccessDate: date21, repository: true)
    
    let firstNew = NewRealm(id: "1",newTitle: "Teste 1", newDescription: "Bom dia, estou testando os textos", img: "", date: "Há 2 dias")
    let secondNew = NewRealm(id: "2",newTitle: "Teste 2", newDescription: "Testando a segunda notícia", date: "Há 3 dias")
    let thirdNew = NewRealm(id: "3",img: "", date: "Há 1 dias")
    
    DataManager.sharedInstance.allNews.append(firstNew)
    DataManager.sharedInstance.allNews.append(secondNew)
    DataManager.sharedInstance.allNews.append(thirdNew)
    
    
    DataManager.sharedInstance.allRadios.append(radio1)

    DataManager.sharedInstance.allRadios.append(radio3)
    DataManager.sharedInstance.allRadios.append(radio4)

    DataManager.sharedInstance.allRadios.append(radio6)
    
    DataManager.sharedInstance.localRadios.append(radio3)
    DataManager.sharedInstance.localRadios.append(radio5)
    
    DataManager.sharedInstance.favoriteRadios.append(radio2)

    
    DataManager.sharedInstance.topRadios = DataManager.sharedInstance.allRadios
    DataManager.sharedInstance.recentsRadios = DataManager.sharedInstance.allRadios
    return true
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
  
  func defineInitialParameters() {
    let audioConfig = AudioConfig(grave: 0, medio: 0, agudo: 0,audioQuality: "Automático")
    DataManager.sharedInstance.audioConfig = audioConfig
    
  }

//  func defineTestData() {
//    let first = New(newTitle: "Teste 1", newDescription: "Bom dia, estou testando os textos", img: "", date: "Há 2 dias")
//    let second = New(newTitle: "Teste 2", newDescription: "Testando a segunda notícia", date: "Há 3 dias")
//    let third = New(img: "", date: "Há 1 dias")
//    
//    DataManager.sharedInstance.news.append(first)
//    DataManager.sharedInstance.news.append(second)
//    DataManager.sharedInstance.news.append(third)
//    
//    
//    let radio1 = Radio(id: "1", name: "Radio Local", lat: "-25.4289541", long: "-49.2671369") { (result) in
//      let radio2 = Radio(id: "2", name: "Radio Band", lat: "-24.121974", long: "-49.2171569", completionSuper: { (result) in
//        let radio3 = Radio(id: "3", name: "Radio Antena Sul", lat: "-24.421974", long: "-49.2171369", completionSuper: { (result) in
//          let radio4 = Radio(id: "4", name: "Radio Jovem Pan", lat: "-25.5289541", long: "-49.2111369", completionSuper: { (result) in
//            let radio5 = Radio(id: "5", name: "Radio 2", lat: "-24.121974", long: "-49.2171569", completionSuper: { (result) in
//              let radio6 = Radio(id: "6", name: "Radio Sertão", lat: "-25.5289541", long: "-49.2111369", completionSuper: { (result) in
//              })
//                    DataManager.sharedInstance.allRadios.append(radio6)
//                    DataManager.sharedInstance.localRadios = DataManager.sharedInstance.allRadios
//            })
//                  DataManager.sharedInstance.allRadios.append(radio5)
//          })
//                DataManager.sharedInstance.allRadios.append(radio4)
//        })
//              DataManager.sharedInstance.allRadios.append(radio3)
//      })
//            DataManager.sharedInstance.allRadios.append(radio2)
//    }
//    DataManager.sharedInstance.allRadios.append(radio1)
//
//    radio1.likenumber = 10
//    radio1.setThumbnailImage("test-1.png")
//    DataManager.sharedInstance.topRadios.append(radio1)
//    DataManager.sharedInstance.localRadios = DataManager.sharedInstance.allRadios
//    DataManager.sharedInstance.favoriteRadios.append(radio1)
//    
//
//  }
  
  func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
    let locValue:CLLocationCoordinate2D = manager.location!.coordinate
    let myLocation = CLLocation(latitude: locValue.latitude, longitude: locValue.longitude)
    DataManager.sharedInstance.userLocation = myLocation
    
  }

}


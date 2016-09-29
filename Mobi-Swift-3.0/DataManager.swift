//
//  DataManager.swift
//  Mobi-Swift-3.0
//
//  Created by Desenvolvimento Access Mobile on 8/8/16.
//  Copyright © 2016 Access Mobile. All rights reserved.
//

import UIKit
import CoreLocation
import Alamofire
import RealmSwift
import Firebase



enum NSComparisonResult : Int {
  case OrderedAscending
  case OrderedSame
  case OrderedDescending
}

enum searchMode {
  case All
  case Radios
  case Genre
  case Local
}

enum PostType : Int {
  case Text = 0
  case Image = 1
  case Audio = 2
  case Video = 3
  case Undefined = -1
}

enum StreamingLinkType : Int {
  case Low = 0
  case High = 1
  case Rds = 2
  case Undefined = -1
}

enum StremingQuality : Int {
  case Automatic = 0
  case Low = 1
  case High = 2
  case Undefined = 3
}

enum StatusApp : Int {
  case CorrectyStatus = 0
  case ProblemWithRealm = 1
  case ProblemWithServer = 2
  case ProblemWithInternet = 3
}

class DataManager: NSObject {

  var configApp = AppConfigRealm()
  
  var statusApp:StatusApp = .CorrectyStatus
  
  let baseURL = "http://homolog.feroxsolutions.com.br:8080/radiocontrole-web/api/"
  var userToken:String!
  var myUser = UserRealm()
  var userLocation:CLLocation!
  var audioConfig:AudioConfig!
  var realm:Realm!
  
  var isLoadScreenAppered = false
  
  //Groups of radios
  var allRadios = [RadioRealm]()
  var topRadios = [RadioRealm]()
  var favoriteRadios = [RadioRealm]()
  var recentsRadios = [RadioRealm]()
  var localRadios = [RadioRealm]()
  
  var allMusicGenre = [GenreRealm]()
  var allStates = [StateRealm]()
  
  var isPlay = false
  var radioInExecution = RadioRealm()
  
  var allNews = [New]()
  var addressId = 0
  
  var isLogged = false
  
  var sleepTimer = NSTimer()
  var isSleepModeEnabled  = false
  var dateSleep = NSDate()
  
  var backgroundTask:UIBackgroundTaskIdentifier = UIBackgroundTaskInvalid
  
  
  enum actualCondition {
    case Ok
    case Without
  }
  
  var miniPlayerView = MiniPlayerViewController()
  var playerClass:PlayerViewController!
  
  var interfaceColor = ColorRealm()
  var existInterfaceColor = false
  
  class var sharedInstance: DataManager {
    struct Static {
      static var instance: DataManager?
      static var token: dispatch_once_t = 0
    }
    
    dispatch_once(&Static.token) {
      Static.instance = DataManager()
    }
    return Static.instance!
  }
  
  func updateRadioDistance() {
    for radio in localRadios {
      radio.resetDistanceFromUser()
    }
    localRadios.sortInPlace({ $0.distanceFromUser < $1.distanceFromUser })
  }
  
  func updateAllOverdueInterval() {
    for radio in recentsRadios {
      radio.updateOverdueInterval()
    }
    //EM MANUTENÇÃO - PRECISA PUXAR OS RECENTES DO SERVIDOR
//    if DataManager.sharedInstance.recentsRadios.count > 0 {
//      if recentsRadios[0].lastAccessDate != nil {
//        recentsRadios.sortInPlace({ $0.lastAccessDate.compare($1.lastAccessDate) == .OrderedDescending })
//      }
//    }
  }
  
  
  func instantiateSearch(navigation:UINavigationController) {
    let storyboard = UIStoryboard(name: "Main", bundle: nil)
    let vc = storyboard.instantiateViewControllerWithIdentifier("searchView") as? SearchTableViewController
    navigation.pushViewController(vc!, animated: true)
  }
  
  func instantiateRadioDetailView(navigation:UINavigationController,radio:RadioRealm) {
    let storyboard = UIStoryboard(name: "Main", bundle: nil)
    let vc = storyboard.instantiateViewControllerWithIdentifier("radioDetail") as? RadioViewController
    vc?.actualRadio = radio
    navigation.pushViewController(vc!, animated: true)
  }
  
  
  //  func updateAddressFromRadios(index:Int,radios:[Radio],completion: (resultAddress: Bool) -> Void) -> Bool { //sempre mandar 0 no index para chamar esta função
  //    if radios.count < index {
  //      if radios[index].address.currentClassState != .CompleteAddress {
  //        Address.getAddress(radios[index].address, completion: { (resultAddress) in
  //          self.updateAddressFromRadios(index+1, radios: radios, completion: completion)
  //      })
  //      }
  //      return false
  //    } else {
  //      return true
  //    }
  //  }
  
}


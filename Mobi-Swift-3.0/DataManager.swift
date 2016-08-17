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

class DataManager: NSObject {
  
  let baseURL = "http://homolog.feroxsolutions.com.br:8080/radiocontrole-web/api/"
  var userToken:String!

  var userLocation:CLLocation!
  
  var news = [New]()
  var audioConfig:AudioConfig!
  var realm:Realm!
  
  //Groups of radios
  var allRadios = [RadioRealm]()
  var topRadios = [RadioRealm]()
  var favoriteRadios = [RadioRealm]()
  var recentsRadios = [RadioRealm]()
  var localRadios = [RadioRealm]()
  
  enum actualCondition {
    case Ok
    case Without
  }
  
  
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
  
  func updateOverdueInterval() {
    for radio in recentsRadios {
      radio.updateOverdueInterval()
    }
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
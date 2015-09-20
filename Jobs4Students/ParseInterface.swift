//
//  ParseInterface.swift
//  Jobs4Students
//
//  Created by Dan Tong on 9/20/15.
//  Copyright © 2015 iOS Swift Course. All rights reserved.
//

import UIKit

let appId = "GVaD3r4Vyi7uQHSydphnOWW2KC4EHHAKm31GXDm7"
let clientKey = "ICQxhc9IndnBEq5X0e4XBAvYIeULHhxzuyi0yzzS"
class ParseInterface: NSObject {
  
  class var sharedInstance: ParseInterface {
    struct Static {
      static var instance = ParseInterface()
    }
    return Static.instance
    
  }
  
  override init() {
    super.init()
  }

  func parseSetup() {
    Parse.setApplicationId(appId, clientKey: clientKey)
    
  }

}

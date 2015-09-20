//
//  ViewController.swift
//  Jobs4Students
//
//  Created by Dan Tong on 9/14/15.
//  Copyright © 2015 iOS Swift Course. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view, typically from a nib.
  }

  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }

  override func viewDidAppear(animated: Bool) {
    if ParseInterface.sharedInstance.isLogInPrevious() {
      print("Already login. Show main screen")
    }else {
      print("User must sign up first then login again")
      if ParseInterface.sharedInstance.parseSignUp(ParseInterface.sharedInstance.defaultUserName, userPass: ParseInterface.sharedInstance.defaultPassword) {
        ParseInterface.sharedInstance.parseSignIn(ParseInterface.sharedInstance.defaultUserName , userPass: ParseInterface.sharedInstance.defaultPassword)
        
      }
      
    }
  }

}


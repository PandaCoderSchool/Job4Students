//
//  JobsListViewController.swift
//  Jobs4Students
//
//  Created by Dan Tong on 9/21/15.
//  Copyright © 2015 iOS Swift Course. All rights reserved.
//

import UIKit

class JobsListViewController: UIViewController {
  
  @IBOutlet weak var jobsTableView: UITableView!
  
  var jobsList: [PFObject]? = [PFObject]()
  override func viewDidLoad() {
    super.viewDidLoad()
    
    NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: "fetchJobsInformation", userInfo: nil, repeats: true)
    
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  
  func fetchJobsInformation() {
    jobsList = ParseInterface.sharedInstance.getJobsInformation()
    if jobsList?.count > 0 {
      let jobTitle = jobsList![0]["jobTitle"] as! String
      print("Get Job Title: \(jobTitle)")
    }

    
  }
  
  /*
  // MARK: - Navigation
  
  // In a storyboard-based application, you will often want to do a little preparation before navigation
  override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
  // Get the new view controller using segue.destinationViewController.
  // Pass the selected object to the new view controller.
  }
  */
  
}

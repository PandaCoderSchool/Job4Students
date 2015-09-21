//
//  JobsListViewController.swift
//  Jobs4Students
//
//  Created by Dan Tong on 9/21/15.
//  Copyright © 2015 iOS Swift Course. All rights reserved.
//

import UIKit

class JobsListViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
  
  @IBOutlet weak var jobsTableView: UITableView!
  
  var jobsList: [PFObject]? = [PFObject]()
  override func viewDidLoad() {
    super.viewDidLoad()
    
    jobsTableView.rowHeight = UITableViewAutomaticDimension
    
    jobsTableView.estimatedRowHeight = 160
    
    
    NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: "fetchJobsInformation", userInfo: nil, repeats: true)
    
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  
  func fetchJobsInformation() {
    jobsList = ParseInterface.sharedInstance.getJobsInformation()
    jobsTableView.reloadData()
    if jobsList?.count > 0 {
      for var i = 0; i < jobsList?.count; i++ {
        let jobTitle = jobsList![i]["jobTitle"] as! String
        let jobId = jobsList![i]["jobId"]
        
//        print("Get #\(i), ID: \(jobId), Title: \(jobTitle)")
//        let photoURL = jobsList![i]["photoURL"] as! String
//        print("Photo link: \(photoURL)")
        

      }
    }
  }
  
  // MARK: - TableView Delegate
  
  func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    if jobsList != nil {
      return jobsList!.count
    } else {
      return 0
    }
  }
  func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    
    let cell = tableView.dequeueReusableCellWithIdentifier("JobCell", forIndexPath: indexPath) as! JobCell
    
    cell.jobTitle.text = jobsList![indexPath.row]["jobTitle"] as? String
    cell.companyLabel.text  = jobsList![indexPath.row]["companyName"] as? String
    
    let dateFormatter = NSDateFormatter()
    dateFormatter.dateFormat = "dd'/'MM'/'yyyy"
    let date = dateFormatter.stringFromDate(jobsList![indexPath.row]["dueOn"] as! NSDate)
    cell.dueSubmitDateLabel.text = "Hạn chót: " + date
    
    cell.salaryLabel.text = jobsList![indexPath.row]["salary"] as? String
    
    // MARK: Load image
//    cell.jobImage.image = nil
//    if let urlString:String? = jobsList![indexPath.row]["photoURL"] as? String {
//      if let url:NSURL? = NSURL(string: urlString!) {
//        let request:NSURLRequest = NSURLRequest(URL: url!, cachePolicy: NSURLRequestCachePolicy.ReturnCacheDataElseLoad, timeoutInterval: 5.0)
//        
//        NSOperationQueue.mainQueue().cancelAllOperations()
//        
//        NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue.mainQueue(), completionHandler: {
//          (response:NSURLResponse?, imageData:NSData?, error:NSError?) -> Void in
//          
//          cell.jobImage.image = UIImage(data: imageData!)
//          print("Data: \(imageData)")
//          
//        })
//      }
//    }
    cell.jobImage.image = nil
    let photoUrl = NSURL(string: (jobsList![indexPath.row]["photoURL"] as? String)!)
    print(photoUrl)
        cell.jobImage.setImageWithURL(photoUrl!)
    

    return cell
  }

  
  
  
  
  // MARK: - Navigation
  
  // In a storyboard-based application, you will often want to do a little preparation before navigation
  override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    
    let detailsVC = segue.destinationViewController as! JobDetailsViewController
    let indexPath = jobsTableView.indexPathForCell(sender as! UITableViewCell)
    
    detailsVC.selectedJob = jobsList![indexPath!.row]
  
  }
  
  
}

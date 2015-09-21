//
//  JobDetailsViewController.swift
//  Jobs4Students
//
//  Created by Dan Tong on 9/21/15.
//  Copyright © 2015 iOS Swift Course. All rights reserved.
//

import UIKit
import MapKit

class JobDetailsViewController: UIViewController, MKMapViewDelegate {

  @IBOutlet weak var map: MKMapView!
  
  var selectedJob: PFObject?
  
  
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
      let latitude: CLLocationDegrees = selectedJob!["location"].latitude
      let longitue: CLLocationDegrees = selectedJob!["location"].longitude
      
      let location: CLLocationCoordinate2D = CLLocationCoordinate2DMake(latitude, longitue)
      let latDelta: CLLocationDegrees = 0.01
      let lonDelta: CLLocationDegrees = 0.01
      let span: MKCoordinateSpan = MKCoordinateSpanMake(latDelta, lonDelta)
      let region: MKCoordinateRegion = MKCoordinateRegionMake(location, span)
      map.setRegion(region, animated: true)
      
      
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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

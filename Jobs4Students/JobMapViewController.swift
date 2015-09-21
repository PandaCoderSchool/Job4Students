//
//  JobMapViewController.swift
//  Jobs4Students
//
//  Created by Dan Tong on 9/21/15.
//  Copyright © 2015 iOS Swift Course. All rights reserved.
//

import UIKit
import  MapKit

class JobMapViewController: UIViewController, MKMapViewDelegate {
  
  @IBOutlet weak var map: MKMapView!
  
  var selectedJob: PFObject?
  var jobsList: [PFObject]? = [PFObject]()
  
  var localSearchRequest:MKLocalSearchRequest!
  var localSearch:MKLocalSearch!
  var localSearchResponse:MKLocalSearchResponse!
  var pointAnnotation:MKPointAnnotation!
  var pinAnnotationView:MKPinAnnotationView!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    // Update Map
    
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  override func viewDidAppear(animated: Bool) {
    self.fetchJobsInformation()
  }
  func fetchJobsInformation() {
    jobsList = ParseInterface.sharedInstance.getJobsInformation()
    self.updateJobsMap()
    
    
  }
  
  func updateJobsMap() {
    if jobsList?.count > 0 {
      for var i = 0; i < jobsList?.count; i++ {
        selectedJob = jobsList![i]
        pinJobOnMap(selectedJob)
      }
    }
    
  }
  let regionRadius: CLLocationDistance = 20000 // 20 km
  
  func pinJobOnMap(jobToPin: PFObject?) {
    localSearchRequest = MKLocalSearchRequest()
    localSearchRequest.naturalLanguageQuery = jobToPin!["contactAddress"] as? String
    
    localSearch = MKLocalSearch(request: localSearchRequest)
    localSearch.startWithCompletionHandler { (localSearchResponse, error) -> Void in
      
      if localSearchResponse == nil{
        let alert = UIAlertView(title: nil, message: "Place not found", delegate: self, cancelButtonTitle: "Try again")
        alert.show()
        return
      }
      //3
      self.pointAnnotation = MKPointAnnotation()
      self.pointAnnotation.title = self.selectedJob!["contactAddress"] as? String
      self.pointAnnotation.coordinate = CLLocationCoordinate2D(latitude: localSearchResponse!.boundingRegion.center.latitude, longitude:     localSearchResponse!.boundingRegion.center.longitude)
      
      
      self.pinAnnotationView = MKPinAnnotationView(annotation: self.pointAnnotation, reuseIdentifier: nil)
      self.map.centerCoordinate = self.pointAnnotation.coordinate
      self.map.addAnnotation(self.pinAnnotationView.annotation!)
      
//      let latitude: CLLocationDegrees = localSearchResponse!.boundingRegion.center.latitude
//      let longitue: CLLocationDegrees = localSearchResponse!.boundingRegion.center.longitude
////
//      let location: CLLocationCoordinate2D = CLLocationCoordinate2DMake(latitude, longitue)
      
      let coordinateRegion = MKCoordinateRegionMakeWithDistance(self.pointAnnotation.coordinate, self.regionRadius, self.regionRadius)
      self.map.setRegion(coordinateRegion, animated: true)
      
//      let latDelta: CLLocationDegrees = 0.01
//      let lonDelta: CLLocationDegrees = 0.01
//      let span: MKCoordinateSpan = MKCoordinateSpanMake(latDelta, lonDelta)
//      
//      let region: MKCoordinateRegion = MKCoordinateRegionMake(location, span)
//      self.map.setRegion(region, animated: true)
      
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

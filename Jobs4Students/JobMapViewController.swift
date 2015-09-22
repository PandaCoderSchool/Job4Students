//
//  JobMapViewController.swift
//  Jobs4Students
//
//  Created by Dan Tong on 9/21/15.
//  Copyright © 2015 iOS Swift Course. All rights reserved.
//

import UIKit
import  MapKit

class JobMapViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate {
  
  @IBOutlet weak var map: MKMapView!
  

  var selectedJob: PFObject?
  var jobsList: [PFObject]? = [PFObject]()
  
  var localSearchRequest:MKLocalSearchRequest!
  var localSearch:MKLocalSearch!
  var localSearchResponse:MKLocalSearchResponse!
  var pointAnnotation:MKPointAnnotation!
  var pinAnnotationView:MKPinAnnotationView!
  
  var locationManager = CLLocationManager()
  var userAnnotation = MKPointAnnotation()
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
    // Update Map
    locationManager.delegate = self
    locationManager.desiredAccuracy = kCLLocationAccuracyBest
    locationManager.requestAlwaysAuthorization()
    locationManager.startUpdatingLocation()
    
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  override func viewDidAppear(animated: Bool) {
    self.fetchJobsInformation()
  }
  
  override func viewDidDisappear(animated: Bool) {
    locationManager.stopUpdatingLocation()
    
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
  
  // View job on Map
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
      self.pointAnnotation.title    = jobToPin!["jobTitle"] as? String
      self.pointAnnotation.subtitle = jobToPin!["contactAddress"] as? String
      
      self.pointAnnotation.coordinate = CLLocationCoordinate2D(latitude: localSearchResponse!.boundingRegion.center.latitude, longitude:     localSearchResponse!.boundingRegion.center.longitude)
      
      
      self.pinAnnotationView = MKPinAnnotationView(annotation: self.pointAnnotation, reuseIdentifier: nil)
      self.map.centerCoordinate = self.pointAnnotation.coordinate
      self.map.addAnnotation(self.pinAnnotationView.annotation!)
      
      let coordinateRegion = MKCoordinateRegionMakeWithDistance(self.pointAnnotation.coordinate, self.regionRadius, self.regionRadius)
      self.map.setRegion(coordinateRegion, animated: true)
      
      
    }
    
  }
  
  func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
    
    let userLocation: CLLocation = locations[0]
    let latitude = userLocation.coordinate.latitude
    let longitude = userLocation.coordinate.longitude
    
    let lonDelta:  CLLocationDegrees  = 0.01
    let latDelta: CLLocationDegrees   = lonDelta
    let span: MKCoordinateSpan = MKCoordinateSpanMake(latDelta, lonDelta)
    let location: CLLocationCoordinate2D  = CLLocationCoordinate2DMake(latitude, longitude)
    let region: MKCoordinateRegion = MKCoordinateRegionMake(location, span)
    
    self.map.setRegion(region, animated: false)
    

    updateUserAnnotation(location)
   
  }
  
  func updateUserAnnotation(location: CLLocationCoordinate2D?) {
    
        userAnnotation.coordinate = location!
        userAnnotation.title  = "I'm here"
        self.map.addAnnotation(userAnnotation)
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

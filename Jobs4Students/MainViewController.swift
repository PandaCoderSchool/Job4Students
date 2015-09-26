//
//  MainViewController.swift
//  Jobs4Students
//
//  Created by Dan Tong on 9/26/15.
//  Copyright © 2015 iOS Swift Course. All rights reserved.
//

import UIKit

class MainViewController: UIViewController, UISearchBarDelegate {

  var viewTypes = ["MapView", "ListView"]
  
  var searchBar = UISearchBar()
  
  @IBOutlet weak var mapContainerView: UIView!
  @IBOutlet weak var listContainerView: UIView!
  @IBOutlet weak var viewTypeSelectButton: UIBarButtonItem!
  
  var isMapViewSelected = true
  
    override func viewDidLoad() {
        super.viewDidLoad()
      searchBar.delegate = self
      searchBar.placeholder = "Search a job"
      self.navigationItem.titleView = self.searchBar
      
      isMapViewSelected = true
      mapContainerView.hidden   = !isMapViewSelected
      listContainerView.hidden  = isMapViewSelected
   
    }

  @IBAction func viewTypeSelect(sender: UIBarButtonItem) {
    isMapViewSelected = !isMapViewSelected
    
    if isMapViewSelected {
      sender.image = UIImage(named: viewTypes[1])
      self.changeViewAnimate(listContainerView, toView: mapContainerView)
      
    } else {
      sender.image = UIImage(named: viewTypes[0])
      self.changeViewAnimate(mapContainerView, toView: listContainerView)
    }
    
  }
  /*
  
  -------------------------------------------
    map view hide here          |    view display screen  |       list view hide
                                |                         |
  hidePosition: 
  
    -fromView.frame.size.width  |           0             |      fromView.frame.size.width
  
*/
  
  func changeViewAnimate(fromView: UIView, toView: UIView) {
    toView.hidden = false
    let hidePosition = isMapViewSelected ? fromView.frame.size.width : -fromView.frame.size.width
    
    UIView.animateWithDuration(1.0, delay: 0.0, usingSpringWithDamping: 0.9, initialSpringVelocity: 10.0, options: UIViewAnimationOptions.CurveEaseIn, animations: { () -> Void in
        fromView.transform = CGAffineTransformMakeTranslation(hidePosition, 0)
        toView.transform = CGAffineTransformMakeTranslation(0, 0)
      
      
      }) { (finished) -> Void in
        fromView.hidden = true
        
    }
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

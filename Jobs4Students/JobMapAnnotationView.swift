//
//  JobMapAnnotationView.swift
//  Jobs4Students
//
//  Created by admin on 27/09/15.
//  Copyright © 2015 iOS Swift Course. All rights reserved.
//

import UIKit

class JobMapAnnotationView: NSObject, MKAnnotation {

    var coordinate: CLLocationCoordinate2D
    var title: String?
    var subtitle: String?
    
    override init() {
        self.coordinate = CLLocationCoordinate2D()
        super.init()
    }

}

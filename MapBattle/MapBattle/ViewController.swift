//
//  ViewController.swift
//  MapBattle
//
//  Created by Ariel Rodriguez on 10/15/16.
//  Copyright © 2016 Ariel Rodriguez. All rights reserved.
//

import UIKit
import CoreLocation
import MapKit

extension CLLocationCoordinate2D {
    fileprivate mutating func randomPointOnCircle(_ radius:Float, center:CGPoint) {
        let theta = Float(arc4random_uniform(UInt32.max))/Float(UInt32.max-1) * Float(M_PI) * 2.0
        
        let x = CGFloat(radius * cosf(theta))+center.x
        let y = CGFloat(radius * sinf(theta))+center.y
        self.latitude = CLLocationDegrees(x)
        self.longitude = CLLocationDegrees(y)
    }
    
    static func randomLocationInNYC() -> CLLocationCoordinate2D {
        var l = CLLocationCoordinate2D()
        let c = CGPoint(x: 40.760789, y: -73.980441)
        l.randomPointOnCircle(0.02, center: c)
        return l
    }
}

class ViewController: UIViewController {
    @IBOutlet weak var mapView: MKMapView!
    
    func centerMap() {
        let l = CLLocationCoordinate2D(latitude: 40.760789, longitude: -73.980441)
        let region = MKCoordinateRegionMakeWithDistance(l, 16000, 16000)
        self.mapView.setRegion(region, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.centerMap()
        for i in 0..<10 {
            let a = MKPointAnnotation()
            a.coordinate = CLLocationCoordinate2D.randomLocationInNYC()
            a.title = "Annotation \(i)"
            self.mapView.addAnnotation(a)
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}


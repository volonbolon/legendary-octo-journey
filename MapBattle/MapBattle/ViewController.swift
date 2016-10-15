//
//  ViewController.swift
//  MapBattle
//
//  Created by Ariel Rodriguez on 10/15/16.
//  Copyright © 2016 Ariel Rodriguez. All rights reserved.
//

import UIKit
import Mapbox

extension CLLocationCoordinate2D {
    private mutating func randomPointOnCircle(radius:Float, center:CGPoint) {
        let theta = Float(arc4random_uniform(UInt32.max))/Float(UInt32.max-1) * Float(M_PI) * 2.0
        
        let x = CGFloat(radius * cosf(theta))+center.x
        let y = CGFloat(radius * sinf(theta))+center.y
        self.latitude = CLLocationDegrees(x)
        self.longitude = CLLocationDegrees(y)
    }
    
    static func randomLocationInNYC() -> CLLocationCoordinate2D {
        var l = CLLocationCoordinate2D()
        let c = CGPoint(x: 40.760789, y: -73.980441)
        l.randomPointOnCircle(radius: 0.02, center: c)
        return l
    }
}

class ViewController: UIViewController {

    @IBOutlet var mapView: MGLMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.mapView.centerCoordinate = CLLocationCoordinate2D(latitude: 40.760789, longitude: -73.980441)
        self.mapView.setZoomLevel(14, animated: true)
    
        for i in 0..<10 {
            let title = "Annotation \(i)"
            let p = MGLPointAnnotation()
            p.coordinate = CLLocationCoordinate2D.randomLocationInNYC()
            p.title = title
            
            self.mapView.addAnnotation(p)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

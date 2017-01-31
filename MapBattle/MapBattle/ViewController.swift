//
//  ViewController.swift
//  MapBattle
//
//  Created by Ariel Rodriguez on 10/15/16.
//  Copyright © 2016 Ariel Rodriguez. All rights reserved.
//

import UIKit
import CoreLocation
import GoogleMaps

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
    var mapView:GMSMapView!
    
    override func loadView() {
        let camera = GMSCameraPosition.camera(withLatitude: 40.760789, longitude: -73.980441, zoom: 13.0)
        let mapView = GMSMapView.map(withFrame: CGRect.zero, camera: camera)
        self.mapView = mapView
        view = mapView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        for i in 0..<10 {
            let a = GMSMarker()
            a.position = CLLocationCoordinate2D.randomLocationInNYC()
            a.title = "Annotation \(i)"
            a.map = self.mapView
        }
        
    }
}


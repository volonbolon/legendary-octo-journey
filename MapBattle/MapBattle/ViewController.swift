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

struct Bounds {
    let northEast:CLLocationCoordinate2D
    let southWest:CLLocationCoordinate2D
}

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
    var bounds:Bounds!
    
    override func loadView() {
        let ne = CLLocationCoordinate2D(latitude: 40.895552, longitude: -73.780971)
        let sw = CLLocationCoordinate2D(latitude: 40.491553, longitude: -74.276729)
        
        self.bounds = Bounds(northEast: ne, southWest: sw)
        
        let camera = GMSCameraPosition.camera(withLatitude: 40.760789, longitude: -73.980441, zoom: 13.0)
        let mapView = GMSMapView.map(withFrame: CGRect.zero, camera: camera)
        mapView.setMinZoom(11.0, maxZoom: 20.0)
        mapView.delegate = self
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

extension ViewController: GMSMapViewDelegate { //
    func mapView(_ mapView: GMSMapView, didChange position: GMSCameraPosition) {
        
        var latitude  = position.target.latitude
        var longitude = position.target.longitude
        
        if position.target.latitude > bounds.northEast.latitude {
            latitude = bounds.northEast.latitude;
        }
        
        if position.target.latitude < bounds.southWest.latitude {
            latitude = bounds.southWest.latitude;
        }
        
        if position.target.longitude > bounds.northEast.longitude {
            longitude = bounds.northEast.longitude;
        }
        
        if position.target.longitude < bounds.southWest.longitude {
            longitude = bounds.southWest.longitude;
        }
        
        if latitude != position.target.latitude || longitude != position.target.longitude {
            var l = CLLocationCoordinate2D();
            l.latitude  = latitude
            l.longitude = longitude
            mapView.animate(toLocation: l)
        }
    }
}


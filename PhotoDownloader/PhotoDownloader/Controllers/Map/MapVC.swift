//
//  MapVC.swift
//  PhotoDownloader
//
//  Created by Dmitry on 6.03.22.
//

import UIKit
import MapKit

class MapVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        configureMap()
    }
    
    @IBOutlet private var mapView: MKMapView!
    var geo: Geo?

    private func configureMap() {
        guard let geo = geo,
        let latString = geo.lat,
        let lngString = geo.lng,
        let latDouble = Double(latString),
        let lngDouble = Double(lngString) else { return }
        
        print(latDouble)
        print(lngDouble)
        
        let annotation = MKPointAnnotation()
        annotation.coordinate = CLLocationCoordinate2D(latitude: latDouble, longitude: lngDouble)
        
        let initialLocation = CLLocation(latitude: latDouble, longitude: lngDouble)
        
        mapView.addAnnotation(annotation)
        mapView.centerToLocation(initialLocation)
    }
}

private extension MKMapView {
  func centerToLocation(_ location: CLLocation, regionRadius: CLLocationDistance = 10000) {
    let coordinateRegion = MKCoordinateRegion(
      center: location.coordinate,
      latitudinalMeters: regionRadius,
      longitudinalMeters: regionRadius)
    setRegion(coordinateRegion, animated: true)
  }
}

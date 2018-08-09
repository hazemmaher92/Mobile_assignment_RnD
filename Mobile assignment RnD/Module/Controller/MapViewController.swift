//
//  MapViewController.swift
//  Mobile assignment RnD
//
//  Created by Hazem Maher on 8/8/18.
//  Copyright © 2018 Hazem Maher. All rights reserved.
//

import UIKit
import MapKit

final class MapViewController: UIViewController {

    //MARK: - Properties
    var coord: Coord?
    
    @IBOutlet weak var mapView: MKMapView!
    
    //MARK: - Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let annotation = MKPointAnnotation()
        let span = MKCoordinateSpanMake(5, 5)
        annotation.coordinate = CLLocationCoordinate2D(latitude: (coord?.lat)!, longitude: (coord?.lon)!)
        let region = MKCoordinateRegion(center: annotation.coordinate, span: span)
        mapView.setRegion(region, animated: true)
        mapView.addAnnotation(annotation)
        
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.setNavigationBarHidden(false, animated: true)
    }
}
